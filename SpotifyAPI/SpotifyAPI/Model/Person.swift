//
//  Person.swift
//  iTunesSearch
//
//  Created by Angel Zambrano on 2/11/22.
//

import Foundation
import UIKit



class Person {
    var name: String
    var email: String?
    var password: String?

    var img: UIImage

    init(name: String, year: String, img: UIImage) {
        self.name = name
        self.img = img
    }



}
