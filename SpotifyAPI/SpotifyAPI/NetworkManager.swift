//
//  NetworkManager.swift
//  SpotifyStats
//
//  Created by Colin Murphy on 7/7/20.
//  Copyright © 2020 Colin Murphy. All rights reserved.


import UIKit
import StoreKit


enum StoreItemError: Error, LocalizedError {
    case itemsNotFound
    case imageDataMissing
}



// this is the network manager for the Spotify API
struct NetworkManager
{
    // fetching the image
    
    static func fetchImage(from url: URL) async throws -> UIImage {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents!.url!)
    
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw StoreItemError.imageDataMissing
        }
    
        guard let image = UIImage(data: data) else {
            throw StoreItemError.imageDataMissing
        }
        return image
    } 
    
}
