//
//  ContentView.swift
//  AnimatedSet
//
//  Created by Sebastian Pfeufer on 04.05.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ShapeSetGame()
    
    var body: some View {
        VStack {
            AspectVGrid(items: viewModel.cardsInGame, aspectRatio: 2/3) { card in
                CardView(
                    amount: card.content.amount.rawValue,
                    type: card.content.type.rawValue,
                    color: card.content.color.rawValue,
                    shading: card.content.shading.rawValue,
                    selected: viewModel.selectedCards.contains(card),
                    mismatch: viewModel.mismatchCards.contains(card),
                    matched: card.isMatched
                )
                .padding(3)
                .onTapGesture {
                    viewModel.choose(card)
                }
            }
            Spacer()
            HStack {
                Button(action: {
                    viewModel.deal()
                }, label: {
                    Text("Deal 3 Cards")
                })
                .padding()
                .foregroundColor(.white)
                .background(.gray)
                .disabled(viewModel.cardDeckIsEmpty)
                Spacer()
                Button(action: {
                    viewModel.new()
                }, label: {
                    Text("New Game")
                })
                .padding()
                .foregroundColor(.white)
                .background(.gray)
            }
            .padding(.horizontal)
            Spacer()
            
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
