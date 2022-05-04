//
//  Squiggle.swift
//  AnimatedSet
//
//  Created by Sebastian Pfeufer on 04.05.22.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let xAltitude = rect.width / 2
        let yAltitude = rect.width / 4
        
        let topLeft = CGPoint(x: center.x - xAltitude, y: center.y - yAltitude)
        let bottomLeft = CGPoint(x: center.x - xAltitude, y: center.y + yAltitude)
        let bottomRight = CGPoint(x: center.x + xAltitude, y: center.y + yAltitude)
        let topRight = CGPoint(x: center.x + xAltitude, y: center.y - yAltitude)
        
        var p = Path()
        
        p.move(to: topLeft)
        p.addLine(to: bottomLeft)
        p.addLine(to: bottomRight)
        p.addLine(to: topRight)
        p.addLine(to: topLeft)
        
        return p
    }
}

