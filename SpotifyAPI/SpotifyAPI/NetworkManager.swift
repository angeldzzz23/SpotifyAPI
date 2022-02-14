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
    
    // getting artists
    
    
    // getting artists using ids
//    static func getArtists(with ids: [String],and token: String, completion: @escaping (ArtistItem?) -> Void) {
//
//        let combined = ids.joined(separator: ",")
//
//        guard var url2 = URLComponents(string: "https://api.spotify.com/v1/artists") else {return}
//
//        let queryItems = [URLQueryItem(name: "ids", value: combined)]
//
//        url2.queryItems = queryItems
//
//
//
//        // creating the request
//        var request = URLRequest(url: url2.url!)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//
//        // doing the URL Request
//        URLSession.shared.dataTask(with: request) { data, response, err in
//            guard err == nil else {
//                print("error: ", err!)
//                return
//            }
//
//            guard  let response = response as? HTTPURLResponse else {
//                    print("no response")
//                return
//            }
//
//            guard response.statusCode == 200 else {
//                print("BAD RESPONSE: ", response.statusCode)
//                return
//            }
//
//            guard let data = data else {
//                print("no data ")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let artist = try decoder.decode(ArtistItem.self, from: data)
//                completion(artist)
//            }
//            catch {
//                print("catch: ", error)
//            }
//
//        }.resume()
//
//    }
    
    

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
    
    
    // TODO: getting related artists
    
    // getting related artists
   static func getRelatedArtist(token: String,artistId: String, completion: @escaping (ArtistItem?) -> Void) {
        
        guard let url = URL(string: "https://api.spotify.com/v1/artists/\(artistId)/related-artists") else {return}
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // doing the URL Request
        URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else {
                print("error: ", err!)
                return
            }
            
            guard  let response = response as? HTTPURLResponse else {
                    print("no response")
                return
            }
            
            guard response.statusCode == 200 else {
                print("BAD RESPONSE: ", response.statusCode)
                return
            }
            
            guard let data = data else {
                print("no data ")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let artist = try decoder.decode(ArtistItem.self, from: data)
                completion(artist)
            }
            catch {
                print("catch: ", error)
            }
          
        }.resume()
        

    }
    
    // TODO: Searching artist
    func search(searchingString: String, token: String, completion: @escaping (Search?) -> Void) {
        
        // setting up the url
        guard var url2 = URLComponents(string: "https://api.spotify.com/v1/search") else {return}

        // setting up the query items
        let queryItems = [
            URLQueryItem(name: "q", value: "artist:\(searchingString)"),
            URLQueryItem(name: "type", value: "artist"),
            URLQueryItem(name: "market", value: "US"),
            URLQueryItem(name: "limit", value: "20")
        ]
        
        url2.queryItems = queryItems
        
        print(url2)
        
        // setting up the request
        var request = URLRequest(url: url2.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        //
        URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else {
                print("error: ", err!)
                return
            }
            
            guard  let response = response as? HTTPURLResponse else {
                    print("no response")
                return
            }
            
            guard response.statusCode == 200 else {
                print("BAD RESPONSE: ", response.statusCode)
                return
            }
            
            guard let data = data else {
                print("no data ")
                return
            }
            
            print("here")
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let artist = try decoder.decode(Search.self, from: data)
                completion(artist)
            }
            catch {
                print("catch: ", error)
            }
          
        }.resume()
        
    }
    
}
