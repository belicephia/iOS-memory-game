//
//  Theme.swift
//  MEMORIZE
//
//  Created by Ziwei Xia on 6/10/21.
//

import Foundation
import SwiftUI
struct Theme {
    var colorofcard: Color
    var emojiarray: [String]
    var name: String
    var numofpair: Int
    
    init(colorofcard: Color,emojiarray: [String],name: String ,numofpair: Int){
        self.name = name
        self.colorofcard = colorofcard
        self.emojiarray = emojiarray
        self.numofpair = numofpair > emojiarray.count ? emojiarray.count : numofpair
    }
    
}
  
