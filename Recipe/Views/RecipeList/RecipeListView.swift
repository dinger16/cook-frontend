import SwiftUI

struct RecipeListView: View {
	@ObservedObject var viewModel: RecipeListViewModel
	@Binding var savedRecipes: [RecipeResponse]
	@Binding var groceryList: [String]
	@State private var searchText = ""
	@State private var selectedFilter = "All"

	private let filters = ["All", "Under 30 min", "30+ min"]
	private let ink = Color(red: 0.16, green: 0.22, blue: 0.19)
	private let leaf = Color(red: 0.25, green: 0.43, blue: 0.34)

	private var filteredRecipes: [RecipeResponse] {
		viewModel.standardRecipes.filter { recipe in
			let matchesSearch = searchText.isEmpty || recipe.title.localizedCaseInsensitiveContains(searchText)
			let matchesFilter: Bool
			switch selectedFilter {
			case "Under 30 min":
				matchesFilter = recipe.prepTime + recipe.cookTime <= 30
			case "30+ min":
				matchesFilter = recipe.prepTime + recipe.cookTime > 30
			default:
				matchesFilter = true
			}
			let matchesIngredient = searchText.isEmpty || recipe.recipeIngredients.contains {
				$0.ingredient.name.localizedCaseInsensitiveContains(searchText)
			}
			return matchesSearch && matchesIngredient && matchesFilter
		}
	}

	var body: some View {
		NavigationStack {
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 26) {
					header

					if searchText.isEmpty && selectedFilter == "All", let weeklyDrop = viewModel.weeklyDrop {
						VStack(alignment: .leading, spacing: 12) {
							sectionHeading("THIS WEEK'S DROP", trailing: "01 / 04")
							NavigationLink {
								RecipeDetailView(recipe: weeklyDrop, savedRecipes: $savedRecipes, groceryList: $groceryList)
							} label: {
								WeeklyDropBannerView(recipe: weeklyDrop)
							}
							.buttonStyle(.plain)
						}
					}

					VStack(alignment: .leading, spacing: 14) {
						sectionHeading("FIND YOUR NEXT FAVORITE", trailing: "\(filteredRecipes.count) recipes")
						ScrollView(.horizontal, showsIndicators: false) {
							HStack(spacing: 9) {
								ForEach(filters, id: \.self) { filter in
									Button {
										selectedFilter = filter
									} label: {
										Text(filter)
											.font(.subheadline.weight(.medium))
											.padding(.horizontal, 15)
											.padding(.vertical, 9)
											.background(selectedFilter == filter ? leaf : Color.white)
											.foregroundStyle(selectedFilter == filter ? .white : ink)
											.clipShape(Capsule())
											.overlay(Capsule().strokeBorder(leaf.opacity(selectedFilter == filter ? 0 : 0.16)))
									}
									.buttonStyle(.plain)
								}
							}
						}

						LazyVStack(spacing: 12) {
							ForEach(filteredRecipes) { recipe in
								RecipeFeedRow(
									recipe: recipe,
									isSaved: savedRecipes.contains(where: { $0.id == recipe.id }),
									savedRecipes: $savedRecipes,
									groceryList: $groceryList,
									onSave: { toggleSaved(recipe) }
								)
							}
						}
					}
				}
				.padding(.horizontal, 20)
				.padding(.top, 12)
				.padding(.bottom, 28)
			}
			.background(Color(red: 0.96, green: 0.95, blue: 0.91).ignoresSafeArea())
			.toolbar(.hidden, for: .navigationBar)
		}
		.tint(ink)
	}

	private var header: some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack(alignment: .center) {
				VStack(alignment: .leading, spacing: 3) {
					Text("GOOD FOOD, LESS FUSS")
						.font(.caption2.weight(.bold))
						.tracking(1.6)
						.foregroundStyle(leaf)
					Text("What's cooking?")
						.font(.system(size: 31, weight: .bold, design: .serif))
						.foregroundStyle(ink)
				}
				Spacer()
				Image(systemName: "sun.max.fill")
					.font(.system(size: 20, weight: .medium))
					.foregroundStyle(Color(red: 0.84, green: 0.43, blue: 0.25))
					.frame(width: 46, height: 46)
					.background(.white.opacity(0.8), in: Circle())
					.accessibilityLabel("Good food, less fuss")
			}

			HStack(spacing: 10) {
				Image(systemName: "magnifyingglass")
					.foregroundStyle(leaf)
				TextField("Search recipes or ingredients", text: $searchText)
					.font(.subheadline)
					.autocorrectionDisabled()
			}
			.padding(.horizontal, 14)
			.frame(height: 48)
			.background(.white, in: RoundedRectangle(cornerRadius: 12))
		}
	}

	private func sectionHeading(_ title: String, trailing: String) -> some View {
		HStack(alignment: .firstTextBaseline) {
			Text(title)
				.font(.caption.weight(.bold))
				.tracking(1.1)
				.foregroundStyle(ink)
			Spacer()
			Text(trailing)
				.font(.caption2.weight(.medium))
				.foregroundStyle(leaf)
		}
	}

	private func toggleSaved(_ recipe: RecipeResponse) {
		if savedRecipes.contains(where: { $0.id == recipe.id }) {
			savedRecipes.removeAll(where: { $0.id == recipe.id })
		} else {
			savedRecipes.append(recipe)
		}
	}
}

private struct RecipeFeedRow: View {
	let recipe: RecipeResponse
	let isSaved: Bool
	@Binding var savedRecipes: [RecipeResponse]
	@Binding var groceryList: [String]
	let onSave: () -> Void

	var body: some View {
		HStack(spacing: 14) {
			NavigationLink {
				RecipeDetailView(recipe: recipe, savedRecipes: $savedRecipes, groceryList: $groceryList)
			} label: {
				HStack(spacing: 14) {
					AsyncImageView(url: recipe.primaryImageURL)
						.frame(width: 100, height: 100)
						.clipShape(RoundedRectangle(cornerRadius: 10))

					VStack(alignment: .leading, spacing: 7) {
						Text(recipe.title)
							.font(.system(size: 17, weight: .semibold, design: .serif))
							.foregroundStyle(Color(red: 0.16, green: 0.22, blue: 0.19))
							.multilineTextAlignment(.leading)
							.lineLimit(2)
						Label("\(recipe.prepTime + recipe.cookTime) min  ·  \(recipe.servings) servings", systemImage: "clock")
							.font(.caption)
							.foregroundStyle(.secondary)
						Text("EASY  ·  WEEKDAY FAVORITE")
							.font(.system(size: 9, weight: .bold))
							.tracking(0.8)
							.foregroundStyle(Color(red: 0.25, green: 0.43, blue: 0.34))
					}
					.frame(maxWidth: .infinity, alignment: .leading)
				}
				.contentShape(Rectangle())
			}
			.buttonStyle(.plain)
			Spacer(minLength: 0)

			Button(action: onSave) {
				Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
					.font(.system(size: 15, weight: .semibold))
					.foregroundStyle(isSaved ? Color(red: 0.78, green: 0.36, blue: 0.24) : .secondary)
					.frame(width: 34, height: 40)
					.contentShape(Rectangle())
			}
			.buttonStyle(.plain)
			.accessibilityLabel(isSaved ? "Remove saved recipe" : "Save recipe")
		}
		.padding(10)
		.background(.white.opacity(0.82), in: RoundedRectangle(cornerRadius: 14))
	}
}

#Preview {
	RootView()
}

