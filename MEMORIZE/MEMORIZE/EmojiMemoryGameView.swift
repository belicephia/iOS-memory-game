//
//  ContentView.swift
//  MEMORIZE
//
//  Created by Ziwei Xia on 6/3/21.
//

import SwiftUI

enum Emojitype {
    case Transport
    case Emotions
    case Animal
}

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    @Namespace private var dealingNamespace
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{

                Text(game.themename).font(.largeTitle)
                Spacer()
                Text("Memory game")
                Spacer()
                Text("Score: \(game.score)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    //            VStack{
    //                ScrollView{
    //                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
    //                        //ForEach(emojis[emojitype][0..<, emojiCount], id: \.self){emoji in CardView(content: emoji)
    //                        //ForEach((emojityp[0..<emojiCount]), id: \.self){emoji in CardView(content: emoji)
    //                        ForEach(game.cards){card in
                gameBody
                HStack{
                    newg
                    Spacer()
                    deckBody
                    Spacer()
                    shuffle
                
                }
            
                    
            
            
        .font(.largeTitle)
        .padding(.horizontal)
        }
    }.foregroundColor(game.themecolor)
    }
        
        
     @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    private func isUndealt(_ card: EmojiMemoryGame.Card)-> Bool{
        !dealt.contains(card.id)
    }
    
//    @State private var dealt = Set<Int>()
//
//    private func deal(_ card : EmojiMemoryGame.Card){
//        dealt.insert(card.id)
//    }
//
//    private func isUndealt(_ card: EmojiMemoryGame.Card)-> Bool{
//        !dealt.contains(card.id)
//    }
    private func dealAnimation(for card: EmojiMemoryGame.Card)->Animation{
        var delayt = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }){
            delayt = Double(index)*(1.5/Double(game.cards.count))
        }
        return Animation.easeInOut(duration: 2).delay(delayt)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card)->Double{
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    @ViewBuilder
    var gameBody: some View{
        AspectVGrid(items:game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp || isUndealt(card){
                Color.clear
            }else{
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)){
                            game.choose(card)
                        }
                        
                    }
                    
            }
            
        
        
        }
//        .onAppear{
//            withAnimation{
//                for card in game.cards{
//                    deal(card)
//                }
//            }
//        }
    }
    
//    var deckBody: some View{
//        ZStack{
//            ForEach(game.cards.filter(isUndealt)) {
//                card in
//                CardView(card)
//                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .scale))
//            }
//        }
//        .frame(width: 60, height: 90)
//        .foregroundColor(game.themecolor)
//    }
    
    
    var  deckBody: some View{
        ZStack{
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))

                    
            }
            
        }
        .frame(width: 60, height: 90 )
        .foregroundColor(game.themecolor)
        .onTapGesture {
            for card in game.cards{
                //deal cards
                withAnimation(dealAnimation(for: card)){
                    
                        deal(card)
                    }
                }
            }
        }
    
    var shuffle: some View{
        Button("Shuffle"){
            withAnimation{
                game.shuffle()
            }
            
        }.font(.system(size: 20)).background(Color.white)
    }

    var newg: some View{
        Button(action: {game.newGame();
                dealt = [];
//            withAnimation{
//                for card in game.cards{
//                    deal(card)
//                }
//            }
            
        }, label: {
            Text("New Game").font(.system(size: 20)).background(Color.white)
        })
    }
    
    
   

    
    
}



struct CardView: View {
//    var content: String
//
//    @State var isFaceUp: Bool = true
    private let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View{
        GeometryReader{ geometry in

            ZStack{
                Group{
                    if card.isConsumingBonusTime{
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees:(-animatedBonusRemaining)*360-90))
                            .onAppear{
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusRemaining)){
                                    animatedBonusRemaining = 0
                                }
                            }

                    }else{
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees:(-card.bonusRemaining)*360-90))
                    }
                }
                .padding(5)
                .opacity(DrawingConstants.opacityVal)
                
                
                        
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360:0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        .font(Font.system(size: DrawingConstants.fontSize))
                        .scaleEffect(scale(thatFits:geometry.size))
                
               
                }
            .cardify(isFaceUp: card.isFaceUp)
            }
        }
    private func scale(thatFits size: CGSize)->CGFloat{
        min(size.width,size.height)/(DrawingConstants.fontSize/DrawingConstants.fontScale)
    }
    
    

    private struct DrawingConstants{
        static let cornerRadius:CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.65
        static let opacityVal: Double = 0.5
        static let paddingVal: Double = 3.0
        static let fontSize: CGFloat = 32
    
}
} 




































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
