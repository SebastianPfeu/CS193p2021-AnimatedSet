//
//  ShapeSetGame.swift
//  AnimatedSet
//
//  Created by Sebastian Pfeufer on 04.05.22.
//

import SwiftUI

class ShapeSetGame: ObservableObject {
    @Published var model = SetGame<ShapeAmount, ShapeType, ShapeColor, ShapeShading>()
    
    typealias ShapeSetCard = Card<ShapeAmount, ShapeType, ShapeColor, ShapeShading>
    
    var cardsInGame: Array<ShapeSetCard> {
        return model.cardsInGame
    }
    
    var discardedCards: Array<ShapeSetCard> {
        return model.discardedCards
    }
    
    var cardDeck: Array<ShapeSetCard> {
        return model.cardDeck
    }
    
    var selectedCards: Array<ShapeSetCard> {
        return model.selectedCards
    }
    
    var mismatchCards: Array<ShapeSetCard> {
        return model.mismatchCards
    }
    
    var cardDeckComplete: Bool {
        return model.cardsInGame.count == 0 && model.discardedCards.count == 0
    }
    
    var cardDeckIsEmpty: Bool {
        return model.cardDeck.count == 0
    }
    
    enum ShapeAmount: Int {
        case one = 1, two = 2, three = 3
    }
    
    enum ShapeType: String {
        case oval, diamond, squiggle
    }
    
    enum ShapeColor: String {
        case red, blue, green
    }
    
    enum ShapeShading: String {
        case solid, striped, outlined
    }
    
    // MARK: - Intent(s)
    func deal() {
        model.dealThreeCards()
    }
    
    func new() {
        model.newGame()
    }
    
    func choose(_ card: ShapeSetCard) {
        model.choose(card)
    }
}

extension ShapeSetGame.ShapeAmount: CaseIterable {
    
}

extension ShapeSetGame.ShapeType: CaseIterable {
    
}

extension ShapeSetGame.ShapeColor: CaseIterable {
    
}

extension ShapeSetGame.ShapeShading: CaseIterable {
    
}

