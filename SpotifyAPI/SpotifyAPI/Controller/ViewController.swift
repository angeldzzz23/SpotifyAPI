//
//  ViewController.swift
//  SpotifyAPI
//
//  Created by Angel Zambrano on 2/10/22.
//

import UIKit




class ViewController: UIViewController {
    // this is the token we first request. 
    let token =  "BQAhvve_2qGKeEYJQAIZGPm5_MbgzibHfSJRMtrUjGTsg3PRbJfyE6mkydn9aleV4rRBfbk7Xd1qu2a72es"

    var  arti: [Artist] = []
    
    @IBOutlet weak var CoolImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // https://open.spotify.com/artist/?si=RDBi_yHlRV-Sxym_8iZQbQ
        NetworkManager.getArtists(with: ["0XwVARXT135rw8lyw1EeWP","4obzFoKoKRHIphyHzJ35G3, "], and: token) { artist in
            if let artist = artist {
                self.arti = artist.artists
            }
        }
        
    }
    // https://open.spotify.com/artist/?si=SMvuvydsTtqFzNoRIFX1LA
    
    
    
    @IBAction func buttonWasPression(_ sender: Any) {
        print(arti)

        
        
        Task {
              do {
                  // getting the first url
                  guard let url = URL(string: arti[0].images[0].url) else {return}
                  print(arti[0].images.count)
                  let image = try await NetworkManager.fetchImage(from: url)
                  
                  
                  // putting it on the main thread
                  DispatchQueue.main.async {
                      self.CoolImage.image = image
                      self.label.text = self.arti[0].name
                  }
                 
              } catch {
                  print(error)
                
              }
          }
        
        
        
     
    }
    

}

