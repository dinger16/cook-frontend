import SwiftUI

struct AsyncImageView: View {
	let url: URL?

	var body: some View {
		Group {
			if let url {
				AsyncImage(url: url) { phase in
					switch phase {
					case .empty:
						placeholder.overlay(ProgressView().tint(.white.opacity(0.85)))
					case .success(let image):
						image.resizable().scaledToFill()
					case .failure:
						placeholder
					@unknown default:
						placeholder
					}
				}
			} else {
				placeholder
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.clipped()
	}

	private var placeholder: some View {
		Rectangle()
			.fill(Color(red: 0.78, green: 0.82, blue: 0.73))
			.overlay {
				Image(systemName: "leaf.fill")
					.font(.system(size: 26))
					.foregroundStyle(Color(red: 0.25, green: 0.43, blue: 0.34).opacity(0.7))
			}
	}
}

