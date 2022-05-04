//
//  Card.swift
//  AnimatedSet
//
//  Created by Sebastian Pfeufer on 04.05.22.
//

import Foundation

struct Card<Feature1, Feature2, Feature3, Feature4>: Identifiable, Equatable where Feature1: Equatable, Feature2: Equatable, Feature3: Equatable, Feature4: Equatable {
    static func == (lhs: Card<Feature1, Feature2, Feature3, Feature4>, rhs: Card<Feature1, Feature2, Feature3, Feature4>) -> Bool {
        lhs.id == rhs.id
    }
    
    var isMatched = false
    let content: Content
    struct Content {
        var amount: Feature1
        var type: Feature2
        var color: Feature3
        var shading: Feature4
    }
    let id: Int
    
    init(content: Content, id: Int) {
        self.content = content
        self.id = id
    }
}

