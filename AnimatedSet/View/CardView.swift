//
//  CardView.swift
//  AnimatedSet
//
//  Created by Sebastian Pfeufer on 04.05.22.
//

import SwiftUI

struct CardView: View {
    let amount: Int
    let type: String
    let color: String
    let shading: String
    let selected: Bool
    let mismatch: Bool
    let matched: Bool
    
    var body: some View {
        let shapeAmountRange = 1...amount
        let shapeColor: Color = {
            switch color {
                case "red": return Color.red
                case "blue": return Color.blue
                case "green": return Color.green
                default: return Color.black
            }
        }()
        let shapeShading: Double = {
            switch shading {
                case "solid": return 1.0
                case "striped": return 0.5
                case "outlined": return 0.0
                default: return 1.0
            }
        }()
        
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: min(geometry.size.width, geometry.size.height) / DrawingConstants.cornerRadiusScaleFactor)
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.cardLineWidth)
                VStack {
                    ForEach((shapeAmountRange), id: \.self) {_ in
                        ZStack {
                            if type == "oval" {
                                Oval().foregroundColor(shapeColor).opacity(shapeShading)
                                Oval().stroke(shapeColor, lineWidth: DrawingConstants.shapeLineWidth)
                            } else if type == "diamond" {
                                Diamond().foregroundColor(shapeColor).opacity(shapeShading)
                                Diamond().stroke(shapeColor, lineWidth: DrawingConstants.shapeLineWidth)
                            } else {
                                Squiggle().foregroundColor(shapeColor).opacity(shapeShading)
                                Squiggle().stroke(shapeColor, lineWidth: DrawingConstants.shapeLineWidth)
                            }
                        }
                    }
                }
                .padding(min(geometry.size.width, geometry.size.height) / DrawingConstants.cardPaddingScaleFactor)
                if matched {
                    shape.fill().foregroundColor(.green).opacity(DrawingConstants.opacityForSignalColor)
                } else if mismatch {
                    shape.fill().foregroundColor(.red).opacity(DrawingConstants.opacityForSignalColor)
                } else if selected {
                    shape.fill().foregroundColor(.yellow).opacity(DrawingConstants.opacityForSignalColor)
                }
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadiusScaleFactor: CGFloat = 4
        static let cardLineWidth: CGFloat = 3
        static let shapeLineWidth: CGFloat = 2
        static let cardPaddingScaleFactor: CGFloat = 4
        static let opacityForSignalColor = 0.5
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
