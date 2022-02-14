//
//  SpotifyArtistController.swift
//  SpotifyAPI
//
//  Created by Angel Zambrano on 2/13/22.
//

import Foundation
import UIKit




// the network manager for the  spotify artists API
// TODO: create documentation
// TODO: save token in
class SpotifyArtistController {
    
    
    // implement the getting of the token
    private var token = "BQDyaIdbXe27CsJO7E7ECoLuBvZD5r13oTdlDACFwfToa8eO_0T7AaXAFbSt2aF2bB-_YRbOGhyVxO2nJ88"
    
    // create the
    
    // getting artists using ids
     func getArtists(with ids: [String], completion: @escaping (Result<ArtistItem?, Error>) -> Void) {
        
        let combined = ids.joined(separator: ",") // puts all of the ids into a single string
        guard var url2 = URLComponents(string: "https://api.spotify.com/v1/artists") else {return} // creates a component of the url
        let queryItems = [URLQueryItem(name: "ids", value: combined)] // creates the query items
        url2.queryItems = queryItems // adds query to url compeonent
    
        
        // creating the request
        var request = URLRequest(url: url2.url!) //
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
   
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(ArtistItem.self, from: data) // gets the artists
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
    
    // with the artistId, it
    func getRelatedArtistss(artistId: String, completion: @escaping (Result<ArtistItem?, Error>) -> Void) {
       
      
        guard let url = URL(string: "https://api.spotify.com/v1/artists/\(artistId)/related-artists") else {return}
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
       let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let error = error {
               completion(.failure(error))
           } else if let data = data {
               do {
                   let decoder = JSONDecoder()
                   let searchResponse = try decoder.decode(ArtistItem.self, from: data) // gets the artists
                   completion(.success(searchResponse))
               } catch {
                   completion(.failure(error))
               }
           }
       }
       
       task.resume()
       
   }
    
    func searchby(searchingString: String, completion: @escaping (Result<Search?, Error>) -> Void) {
        // setting up the end point
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
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(Search.self, from: data) // gets the artists
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
    
    
    
 
   


}

/*
class StoreItemController {
    func fetchItems(matching query: [String: String], completion: @escaping (Result<[StoreItem], Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    completion(.success(searchResponse.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    enum StoreItemError: Error, LocalizedError {
        case imageDataMissing
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(StoreItemError.imageDataMissing))
            }
        }
        
        task.resume()
    }
}
*/