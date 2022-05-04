//
//  ShapeSetGame.swift
//  AnimatedSet
//
//  Created by Sebastian Pfeufer on 04.05.22.
//

import SwiftUI

class ShapeSetGame: ObservableObject {
    @Published var model = SetGame<ShapeAmount, ShapeType, ShapeColor, ShapeShading>()
    
    var cardsInGame: Array<Card<ShapeAmount, ShapeType, ShapeColor, ShapeShading>> {
        return model.cardsInGame
    }
    
    var selectedCards: Array<Card<ShapeAmount, ShapeType, ShapeColor, ShapeShading>> {
        return model.selectedCards
    }
    
    var mismatchCards: Array<Card<ShapeAmount, ShapeType, ShapeColor, ShapeShading>> {
        return model.mismatchCards
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
    
    func choose(_ card: Card<ShapeAmount, ShapeType, ShapeColor, ShapeShading>) {
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

