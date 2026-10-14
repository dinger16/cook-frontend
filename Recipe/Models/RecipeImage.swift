//
//  RecipeImage.swift
//  Recipe
//
//  Created by Connor Ding on 10/14/26.
//

import Foundation

struct RecipeImageCreate: Codable, Hashable {
    let imageUrl: String
    let isPrimary: Bool
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case isPrimary = "is_primary"
    }
}

struct RecipeImageResponse: Codable, Identifiable, Hashable {
    let id: Int
    let imageUrl: String
    let isPrimary: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case isPrimary = "is_primary"
    }
}
