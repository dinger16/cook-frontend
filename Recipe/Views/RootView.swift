//
//  RootView.swift
//  Recipe
//
//  Created by Connor Ding on 10/14/26.
//

import SwiftUI

struct RootView: View {
    @State private var savedRecipes: [RecipeResponse] = []
    @State private var groceryList: [String] = ["Baby spinach", "Lemon", "Parmesan", "Sourdough"]
    @StateObject private var viewModel = RecipeListViewModel()

    var body: some View {
        TabView {
            RecipeListView(viewModel: viewModel, savedRecipes: $savedRecipes, groceryList: $groceryList)
                .tabItem {
                    Label("Discover", systemImage: "sparkles")
                }

            MyRecipesView(savedRecipes: $savedRecipes, groceryList: $groceryList)
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }

            MyListView(groceryList: $groceryList)
                .tabItem {
                    Label("Groceries", systemImage: "basket")
                }
        }
        .tint(Color(red: 0.25, green: 0.43, blue: 0.34))
        .onAppear {
            viewModel.loadData()
        }
    }
}
