import SwiftUI

struct WeeklyDropBannerView: View {
	let recipe: RecipeResponse

	var body: some View {
		ZStack(alignment: .bottomLeading) {
			AsyncImageView(url: recipe.primaryImageURL)
				.frame(height: 225)
				.overlay {
					LinearGradient(
						colors: [.clear, .black.opacity(0.78)],
						startPoint: .center,
						endPoint: .bottom
					)
				}

			VStack(alignment: .leading, spacing: 8) {
				Text("EDITOR'S PICK")
					.font(.caption2.weight(.bold))
					.tracking(1.4)
					.padding(.horizontal, 9)
					.padding(.vertical, 6)
					.background(Color(red: 0.88, green: 0.55, blue: 0.32), in: Capsule())
					.foregroundStyle(.white)
				Text(recipe.title)
					.font(.system(size: 24, weight: .bold, design: .serif))
					.foregroundStyle(.white)
					.multilineTextAlignment(.leading)
					.lineLimit(2)
				Label("\(recipe.prepTime + recipe.cookTime) min  ·  \(recipe.servings) servings", systemImage: "clock")
					.font(.caption.weight(.medium))
					.foregroundStyle(.white.opacity(0.9))
			}
			.padding(18)
		}
		.frame(height: 225)
		.clipShape(RoundedRectangle(cornerRadius: 16))
		.overlay(alignment: .topTrailing) {
			Image(systemName: "arrow.up.right")
				.font(.system(size: 13, weight: .bold))
				.foregroundStyle(.white)
				.frame(width: 34, height: 34)
				.background(.black.opacity(0.25), in: Circle())
				.padding(14)
		}
	}
}

