//
//  EmojiMemoryGame.swift
//  MEMORIZE
//
//  Created by Ziwei Xia on 6/5/21.
//

import SwiftUI



    
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    init(){
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojiarray.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    @Published private var model: MemoryGame<String>
    
    //static let emojitrans = ["ð","ð","ð","ð","ð","ð","ðģ","ð","ðē","ðī"]
    
    private static var themes: Array<Theme> = [
        Theme(colorofcard: .red,
              emojiarray: ["ð","ð","ð","ð","ð","ð","ðģ","ð","ðē","ðī"],
              name: "Transportation",
               numofpair: 6),
        Theme(colorofcard: .yellow,
              emojiarray: ["ðĄ","ðĪŠ","ð","ð","ðą","ðĪĐ","ðĨķ","ð","ðĪŪ","ðĨĩ"],
              name: "Emotions",
              numofpair: 5),
        Theme(colorofcard: .blue,
              emojiarray: ["ðķ","ð­","ðĶ","ð·","ðą","ðĻ","ðĶ","ð","ðĶ","ðĶ"],
              name: "Animal",
              numofpair: 4)
    ]
    
//    static let transTheme = Theme(colorofcard: .blue, emojiarray: ["ð","ð","ð","ð","ð","ð","ðģ","ð","ðē","ðī"], name:"Transportation",numofpair: 6)
//
//    static let emosTheme = Theme(colorofcard: .red, emojiarray: ["ðĄ","ðĪŠ","ð","ð","ðą","ðĪĐ","ðĨķ","ð","ðĪŪ","ðĨĩ"], name: "Emotions",numofpair: 5)
//
//    static let aniTheme = Theme(colorofcard: .orange, emojiarray: ["ðķ","ð­","ðĶ","ð·","ðą","ðĻ","ðĶ","ð","ðĶ","ðĶ"], name: "Animal", numofpair: 6)

    //@State var currentTheme = aniTheme
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: theme.numofpair) {
            pairIndex in theme.emojiarray[pairIndex]}
    }
//    static func createMemoryGame() -> MemoryGame<String>{
//        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in emojitrans[pairIndex]}
//
//    }
//
    private var theme: Theme
    //var objectWillChange: ObservableObjectPublisher
    
    

    var cards: Array<Card> {
         model.cards
    }
    
    //MARK: - Intent(s)
    
    var themename: String{
        theme.name
    }
    
    var themecolor: Color{
        theme.colorofcard
    }
    
    var score:Int{
        return model.score
    }

    func choose(_ card: Card){
        //objectWillChange.send()
        model.choose(card)
        
    }
        
    func newGame(){
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojiarray.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        }
    
    func emoGame(){
        theme = EmojiMemoryGame.themes[1]
        theme.emojiarray.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    
    
}
