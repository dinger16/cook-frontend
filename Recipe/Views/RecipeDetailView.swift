//
//  RecipeDetailView.swift
//  Recipe
//
//  Created by Connor Ding on 10/14/26.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: RecipeResponse
    @Binding var savedRecipes: [RecipeResponse]
    @Binding var groceryList: [String]
    
    private var isSaved: Bool {
        savedRecipes.contains(where: { $0.id == recipe.id })
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Recipe Header Image
                if let url = recipe.primaryImageURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color(.tertiarySystemFill))
                                .overlay(ProgressView())
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Rectangle()
                                .fill(Color(.tertiarySystemFill))
                                .overlay(Image(systemName: "photo").foregroundColor(.secondary))
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(height: 240)
                    .clipped()
                }

                VStack(alignment: .leading, spacing: 16) {
                    
                    // Title & Quick Metadata
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 16) {
                            Label("\(recipe.prepTime + recipe.cookTime) mins", systemImage: "clock")
                            Label("\(recipe.servings) servings", systemImage: "person.2")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    
                    Divider()

                    // Action Bar
                    HStack(spacing: 12) {
                        Button(action: {
                            addIngredientsToList()
                        }) {
                            Label("Add to Grocery List", systemImage: "cart.badge.plus")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.primary)
                                .foregroundColor(Color(.systemBackground))
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            toggleSaveRecipe()
                        }) {
                            Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                .font(.headline)
                                .frame(width: 44, height: 44)
                                .background(Color(.secondarySystemBackground))
                                .foregroundColor(.primary)
                                .cornerRadius(10)
                        }
                    }

                    Divider()

                    // Ingredients Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients")
                            .font(.headline)
                        
                        ForEach(recipe.recipeIngredients) { item in
                            HStack {
                                Text("• \(item.ingredient.name)")
                                Spacer()
                                Text("\(item.amount.description) \(item.unit)")
                                    .foregroundColor(.secondary)
                            }
                            .font(.subheadline)
                        }
                    }

                    Divider()

                    // Steps Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Instructions")
                            .font(.headline)
                        
                        ForEach(recipe.steps.sorted(by: { $0.stepNumber < $1.stepNumber })) { step in
                            HStack(alignment: .top, spacing: 12) {
                                Text("\(step.stepNumber)")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .frame(width: 24, height: 24)
                                    .background(Color(.secondarySystemBackground))
                                    .clipShape(Circle())
                                
                                Text(step.description)
                                    .font(.subheadline)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addIngredientsToList() {
        let itemsToAdd = recipe.recipeIngredients.map { "\($0.amount) \($0.unit) \($0.ingredient.name)" }
        groceryList.append(contentsOf: itemsToAdd)
    }

    private func toggleSaveRecipe() {
        if isSaved {
            savedRecipes.removeAll(where: { $0.id == recipe.id })
        } else {
            savedRecipes.append(recipe)
        }
    }
}
