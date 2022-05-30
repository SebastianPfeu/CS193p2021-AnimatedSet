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
    let faceUp: Bool
    
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
            let shape = RoundedRectangle(cornerRadius: min(geometry.size.width, geometry.size.height) / DrawingConstants.cornerRadiusScaleFactor)
            if faceUp {
                ZStack {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: mismatch ? DrawingConstants.cardLineWidth * 2.5 : DrawingConstants.cardLineWidth).foregroundColor(mismatch ? .red : .black)
                        .animation(.linear(duration: 0.5), value: mismatch)
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
                            .rotationEffect(Angle.degrees(matched ? 180 : 0))
                            .animation(.linear(duration: 0.5), value: matched)
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
            } else {
                shape.fill().foregroundColor(.gray)
                shape.strokeBorder(lineWidth: DrawingConstants.cardLineWidth)
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
