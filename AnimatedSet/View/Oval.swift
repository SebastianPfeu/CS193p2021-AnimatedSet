//
//  Oval.swift
//  AnimatedSet
//
//  Created by Sebastian Pfeufer on 04.05.22.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let xAltitude = rect.width / 2
        let yAltitude = rect.width / 4
        
        let topLeft = CGPoint(x: center.x - xAltitude + yAltitude, y: center.y - yAltitude)
        let centerLeft = CGPoint(x: center.x - xAltitude + yAltitude, y: center.y)
        let bottomRight = CGPoint(x: center.x + xAltitude - yAltitude, y: center.y + yAltitude)
        let centerRight = CGPoint(x: center.x + xAltitude - yAltitude, y: center.y)
        
        var p = Path()
        
        p.move(to: topLeft)
        p.addArc(center: centerLeft, radius: yAltitude, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 90), clockwise: true)
        p.addLine(to: bottomRight)
        p.addArc(center: centerRight, radius: yAltitude, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: -90), clockwise: true)
        p.addLine(to: topLeft)
        
        return p
    }
}
