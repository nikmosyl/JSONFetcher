//
//  GameTable.swift
//  JSONFetcher
//
//  Created by nikita on 30.01.24.
//
import Foundation

struct GameTable: Decodable {
    let success: Bool
    let deck_id: String
    let shuffled: Bool
    let remaining: Int
}

struct CardDeck: Decodable {
    let success: Bool
    let deck_id: String
    let cards: [Card]
    let remaining: Int
}

struct Card: Decodable {
    let code: String
    let image: URL
    let value: String
    let suit: String
}
