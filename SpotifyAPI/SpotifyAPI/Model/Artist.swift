//
//  cool.swift
//  SpotifyAPI
//
//  Created by Angel Zambrano on 2/11/22.
//

import Foundation
import UIKit


struct Token: Codable {
    var accessToken: String?
    var refreshToken: String?
    var error: String?
    var errorDescription: String?
}

struct ArtistItem: Codable {
    let artists: [Artist]
}

// MARK: - Image
struct Image: Codable {
    let height: Int
    let url: String
    let width: Int
}

// MARK: - Artist
struct Artist: Codable {
    let genres: [String]
    let href: String?
    let id: String
    let images: [Image]
    let name: String
    let popularity: Int

    enum CodingKeys: String, CodingKey {
        case  genres, href, id, images, name, popularity
    }
    
}

