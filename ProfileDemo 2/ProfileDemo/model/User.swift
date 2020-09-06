//
//  User.swift
//  ProfileDemo
//
//  Created by a on 5/13/20.
//  Copyright © 2020 a. All rights reserved.
//


import UIKit


let encoder = JSONEncoder()
let decoder = JSONDecoder()


struct User : Codable {
    var name: String?
    var email: String!
    var password: String!
    var phoneNum: String!
    var gender: String!
    var address: String!
    var image: Image
    }
struct Image: Codable{
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        
        return image
    }
}
