//
//  RecipeIngredient.swift
//  Recipe
//
//  Created by Connor Ding on 10/14/26.
//

import Foundation

struct RecipeIngredientCreate: Codable, Hashable {
    let ingredientId: Int
    let amount: Decimal
    let unit: String
    
    enum CodingKeys: String, CodingKey {
        case ingredientId = "ingredient_id"
        case amount, unit
    }
}

struct RecipeIngredientResponse: Codable, Identifiable, Hashable {
    var id: Int { ingredientId }
    let ingredientId: Int
    let amount: Decimal
    let unit: String
    let ingredient: IngredientResponse
    
    enum CodingKeys: String, CodingKey {
        case ingredientId = "ingredient_id"
        case amount, unit, ingredient
    }
}
