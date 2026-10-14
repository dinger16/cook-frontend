//
//  RecipeListViewModel.swift
//  Recipe
//
//  Created by Connor Ding on 10/14/26.
//

import Foundation
import Combine

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var weeklyDrop: RecipeResponse?
    @Published var standardRecipes: [RecipeResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadData() {
        self.weeklyDrop = RecipeResponse.sampleWeeklyDrop
        self.standardRecipes = RecipeResponse.sampleFeed
    }
}
