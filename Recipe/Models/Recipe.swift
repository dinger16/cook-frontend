//
//  Recipe.swift
//  Recipe
//
//  Created by Connor Ding on 10/14/26.
//

import Foundation

struct RecipeWrite: Codable {
    let title: String
    let prepTime: Int
    let cookTime: Int
    let servings: Int
    let recipeIngredients: [RecipeIngredientCreate]
    let steps: [RecipeStepCreate]
    let images: [RecipeImageCreate]
    
    enum CodingKeys: String, CodingKey {
        case title
        case prepTime = "prep_time"
        case cookTime = "cook_time"
        case servings
        case recipeIngredients = "recipe_ingredients"
        case steps, images
    }
}

struct RecipeResponse: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let prepTime: Int
    let cookTime: Int
    let servings: Int
    let recipeIngredients: [RecipeIngredientResponse]
    let steps: [RecipeStepResponse]
    let images: [RecipeImageResponse]
    
    var primaryImageURL: URL? {
        let primary = images.first(where: { $0.isPrimary }) ?? images.first
        return primary.flatMap { URL(string: $0.imageUrl) }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case prepTime = "prep_time"
        case cookTime = "cook_time"
        case servings
        case recipeIngredients = "recipe_ingredients"
        case steps, images
    }
}
