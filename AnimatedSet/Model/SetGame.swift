//
//  SetGame.swift
//  AnimatedSet
//
//  Created by Sebastian Pfeufer on 04.05.22.
//

import Foundation

struct SetGame<Feature1, Feature2, Feature3, Feature4> where Feature1: CaseIterable, Feature1: Equatable, Feature2: CaseIterable, Feature2: Equatable, Feature3: CaseIterable, Feature3: Equatable, Feature4: CaseIterable, Feature4: Equatable {
    typealias SetCard = Card<Feature1, Feature2, Feature3, Feature4>
    private(set) var cardDeck: Array<SetCard> = []
    var cardsInGame: Array<SetCard> = []
    private var startNumberOfCardsInGame = 12
    var selectedCards: Array<SetCard> = []
    var mismatchCards: Array<SetCard> = []
    
    mutating func newGame() {
        cardDeck = []
        cardsInGame = []
        selectedCards = []
        mismatchCards = []
        startGame()
    }
    
    mutating func dealThreeCards() {
        let matchedCardsInGame = cardsInGame.filter { $0.isMatched }
        if matchedCardsInGame.count == 3 {
            exchangeCards()
        } else {
            if cardDeck.count > 0 {
                for _ in 0..<3 {
                    cardsInGame.append(cardDeck[0])
                    cardDeck.remove(at: 0)
                }
            }
        }
    }
    
    mutating func choose(_ card: SetCard) {
        mismatchCards = []
        exchangeCards()
        let cardsInGame = cardsInGame.filter { $0.isMatched == false }
        if let chosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
            if selectedCards.contains(card) {
                if let selectedIndex = selectedCards.firstIndex(where: { $0.id == card.id }) {
                    selectedCards.remove(at: selectedIndex)
                }
            } else {
                if selectedCards.count == 2 {
                    checkForMatch(card1: selectedCards[0], card2: selectedCards[1], card3: card)
                } else {
                    selectedCards.append(cardsInGame[chosenIndex])
                }
            }
        }
    }
    
    init() {
        startGame()
    }
    
    
    //MARK: - Helper functions
    private mutating func startGame() {
        var identifier = 0
        for f1 in Feature1.allCases {
            for f2 in Feature2.allCases {
                for f3 in Feature3.allCases {
                    for f4 in Feature4.allCases {
                        let card = SetCard(content: SetCard.Content(amount: f1, type: f2, color: f3, shading: f4), id: identifier)
                        cardDeck.append(card)
                        identifier += 1
                    }
                }
            }
        }
        cardDeck.shuffle()
        cardsInGame = Array(cardDeck[0..<startNumberOfCardsInGame])
        for _ in 0..<startNumberOfCardsInGame {
            cardDeck.remove(at: 0)
        }
    }
    
    private mutating func checkForMatch(card1: SetCard, card2: SetCard, card3: SetCard) {
        if ((card1.content.amount != card2.content.amount) && (card1.content.amount != card3.content.amount) && (card2.content.amount != card3.content.amount)) || ((card1.content.amount == card2.content.amount) && (card1.content.amount == card3.content.amount) && (card2.content.amount == card3.content.amount)) {
                if ((card1.content.type != card2.content.type) && (card1.content.type != card3.content.type) && (card2.content.type != card3.content.type)) || ((card1.content.type == card2.content.type) && (card1.content.type == card3.content.type) && (card2.content.type == card3.content.type)) {
                        if ((card1.content.color != card2.content.color) && (card1.content.color != card3.content.color) && (card2.content.color != card3.content.color)) || ((card1.content.color == card2.content.color) && (card1.content.color == card3.content.color) && (card2.content.color == card3.content.color)) {
                                if (card1.content.shading != card2.content.shading) && (card1.content.shading != card3.content.shading) && (card2.content.shading != card3.content.shading) || ((card1.content.shading == card2.content.shading) && (card1.content.shading == card3.content.shading) && (card2.content.shading == card3.content.shading)) {
                                        if let chosenIndex1 = cardsInGame.firstIndex(where: { $0.id == card1.id }), let chosenIndex2 = cardsInGame.firstIndex(where: { $0.id == card2.id }), let chosenIndex3 = cardsInGame.firstIndex(where: { $0.id == card3.id }) {
                                            cardsInGame[chosenIndex1].isMatched = true
                                            cardsInGame[chosenIndex2].isMatched = true
                                            cardsInGame[chosenIndex3].isMatched = true
                                            selectedCards = []
                                        }
                                } else {
                                    addMismatchCards(card1: card1, card2: card2, card3: card3)
                                }
                        } else {
                            addMismatchCards(card1: card1, card2: card2, card3: card3)
                        }
                } else {
                    addMismatchCards(card1: card1, card2: card2, card3: card3)
                }
        } else {
            addMismatchCards(card1: card1, card2: card2, card3: card3)
        }
    }
    
    private mutating func addMismatchCards(card1: SetCard, card2: SetCard, card3: SetCard) {
        mismatchCards.append(card1)
        mismatchCards.append(card2)
        mismatchCards.append(card3)
        selectedCards = []
    }
    
    private mutating func exchangeCards() {
        for card in cardsInGame {
            if card.isMatched == true {
                if let selectedIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
                    if cardDeck.count > 0 {
                        cardsInGame[selectedIndex] = cardDeck[0]
                        cardDeck.remove(at: 0)
                    } else {
                        cardsInGame.remove(at: selectedIndex)
                    }
                }
            }
        }
    }
}
