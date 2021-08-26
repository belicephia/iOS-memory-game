//
//  MEMORIZEApp.swift
//  MEMORIZE
//
//  Created by Ziwei Xia on 6/3/21.
//

import SwiftUI

@main
struct MEMORIZEApp: App {
    private let game = EmojiMemoryGame()
     
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game:  game)
        }
    }
}
