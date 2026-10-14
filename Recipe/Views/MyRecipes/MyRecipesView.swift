import SwiftUI

struct MyRecipesView: View {
	@Binding var savedRecipes: [RecipeResponse]
	@Binding var groceryList: [String]

	private let ink = Color(red: 0.16, green: 0.22, blue: 0.19)

	var body: some View {
		NavigationStack {
			Group {
				if savedRecipes.isEmpty {
					ContentUnavailableView {
						Label("Your recipe box is waiting", systemImage: "bookmark")
					} description: {
						Text("Save recipes as you browse and they’ll be ready here when you need them.")
					}
					.foregroundStyle(ink)
				} else {
					ScrollView {
						LazyVStack(spacing: 14) {
							ForEach(savedRecipes) { recipe in
								NavigationLink {
									RecipeDetailView(recipe: recipe, savedRecipes: $savedRecipes, groceryList: $groceryList)
								} label: {
									HStack(spacing: 14) {
										AsyncImageView(url: recipe.primaryImageURL)
											.frame(width: 104, height: 112)
											.clipShape(RoundedRectangle(cornerRadius: 10))
										VStack(alignment: .leading, spacing: 8) {
											Text(recipe.title)
												.font(.system(size: 19, weight: .semibold, design: .serif))
												.multilineTextAlignment(.leading)
												.foregroundStyle(ink)
												.lineLimit(3)
											Label("\(recipe.prepTime + recipe.cookTime) minutes", systemImage: "clock")
												.font(.caption)
												.foregroundStyle(.secondary)
											Text("\(recipe.recipeIngredients.count) INGREDIENTS")
												.font(.system(size: 9, weight: .bold))
												.tracking(0.9)
												.foregroundStyle(Color(red: 0.25, green: 0.43, blue: 0.34))
										}
										Spacer(minLength: 0)
									}
									.padding(10)
									.background(.white, in: RoundedRectangle(cornerRadius: 14))
								}
								.buttonStyle(.plain)
							}
						}
						.padding(20)
					}
				}
			}
			.background(Color(red: 0.96, green: 0.95, blue: 0.91).ignoresSafeArea())
			.navigationTitle("Recipe box")
			.navigationBarTitleDisplayMode(.large)
		}
		.tint(ink)
	}
}

