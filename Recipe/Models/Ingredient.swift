//
//  Ingredient.swift
//  Recipe
//
//  Created by Connor Ding on 10/14/26.
//

import Foundation

struct IngredientResponse: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let category: String
}
