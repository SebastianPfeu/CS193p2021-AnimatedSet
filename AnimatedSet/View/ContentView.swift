//
//  ContentView.swift
//  AnimatedSet
//
//  Created by Sebastian Pfeufer on 04.05.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ShapeSetGame()
    
    @Namespace private var dealingNamespace
    
    @State var details = false
    
    var body: some View {
        VStack {
            gameBody
            Spacer()
            HStack {
                cardDeck
                Spacer()
                newGame
                Spacer()
                discardPile
            }
            .padding(3)
        }
    }
    
    var gameBody: some View {
        AspectVGrid(items: viewModel.cardsInGame, aspectRatio: CardConstants.aspectRatio) { card in
            CardView(
                amount: card.content.amount.rawValue,
                type: card.content.type.rawValue,
                color: card.content.color.rawValue,
                shading: card.content.shading.rawValue,
                selected: viewModel.selectedCards.contains(card),
                mismatch: viewModel.mismatchCards.contains(card),
                matched: card.isMatched,
                faceUp: true
            )
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .zIndex(zIndex(of: card))
            .padding(3)
            .onTapGesture {
                withAnimation {
                    viewModel.choose(card)
                }
            }
        }
    }
    
    var cardDeck: some View {
        ZStack {
            ForEach(viewModel.cardDeck) { card in
                CardView(
                    amount: card.content.amount.rawValue,
                    type: card.content.type.rawValue,
                    color: card.content.color.rawValue,
                    shading: card.content.shading.rawValue,
                    selected: viewModel.selectedCards.contains(card),
                    mismatch: viewModel.mismatchCards.contains(card),
                    matched: card.isMatched,
                    faceUp: false
                )
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .onTapGesture {
            withAnimation {
                viewModel.deal()
            }
        }
        .disabled(viewModel.cardDeckComplete)
    }
    
    var discardPile: some View {
        ZStack {
            ForEach(viewModel.discardedCards) { card in
                CardView(
                    amount: card.content.amount.rawValue,
                    type: card.content.type.rawValue,
                    color: card.content.color.rawValue,
                    shading: card.content.shading.rawValue,
                    selected: viewModel.selectedCards.contains(card),
                    mismatch: viewModel.mismatchCards.contains(card),
                    matched: card.isMatched,
                    faceUp: true
                )
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
    }
    
    var newGame: some View {
        Button(action: {
            withAnimation {
                viewModel.new()
            }
            
        }, label: {
            Text("New Game")
        })
        .padding()
        .foregroundColor(.white)
        .background(.gray)
    }
    
    private func dealAnimation(for card: ShapeSetGame.ShapeSetCard) -> Animation {
        var delay = 0.0
        if let index = viewModel.cardDeck.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(3))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: ShapeSetGame.ShapeSetCard) -> Double {
        -Double(viewModel.cardDeck.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
