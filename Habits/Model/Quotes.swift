//
//  Quotes.swift
//  Habits
//
//  Created by Alexander Thompson on 9/2/22.
//

import Foundation

struct Quotes: Codable {
    var quotes: [Quote]
}

struct Quote: Codable {
    let text: String?
    let author: String?
}
