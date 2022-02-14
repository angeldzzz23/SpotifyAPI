//
//  Search.swift
//  SpotifyAPI
//
//  Created by Angel Zambrano on 2/12/22.
//

import Foundation

// these are the structures that contain the search feature

// MARK: -Artists
struct Search: Codable {
    let artists: NumArtists?
}


// MARK: - Item
struct NumArtists: Codable {
    let href: String
    let items: [Artist]
    let limit: Int
//    let next: String
    let offset: Int
    let total: Int
}


