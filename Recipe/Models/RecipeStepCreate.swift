//
//  RecipeStepCreate.swift
//  Recipe
//
//  Created by Connor Ding on 10/14/26.
//


import Foundation

struct RecipeStepCreate: Codable, Hashable {
    let stepNumber: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case stepNumber = "step_number"
        case description
    }
}

struct RecipeStepResponse: Codable, Identifiable, Hashable {
    let id: Int
    let stepNumber: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case stepNumber = "step_number"
        case description
    }
}