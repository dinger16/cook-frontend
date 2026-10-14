import SwiftUI

struct MyListView: View {
	@Binding var groceryList: [String]
	@State private var newItem = ""
	@State private var checkedItems: Set<String> = []

	private let ink = Color(red: 0.16, green: 0.22, blue: 0.19)
	private let leaf = Color(red: 0.25, green: 0.43, blue: 0.34)

	private var remainingCount: Int {
		groceryList.filter { !checkedItems.contains($0) }.count
	}

	var body: some View {
		NavigationStack {
			VStack(spacing: 0) {
				HStack(alignment: .lastTextBaseline) {
					Text("Market list")
						.font(.system(size: 28, weight: .bold, design: .serif))
						.foregroundStyle(ink)
					Spacer()
					Text("\(remainingCount) TO PICK UP")
						.font(.caption2.weight(.bold))
						.tracking(1)
						.foregroundStyle(leaf)
				}
				.padding(.horizontal, 20)
				.padding(.top, 12)
				.padding(.bottom, 18)

				HStack(spacing: 10) {
					TextField("Add an ingredient", text: $newItem)
						.font(.subheadline)
						.submitLabel(.done)
						.onSubmit(addItem)
					Button(action: addItem) {
						Image(systemName: "plus")
							.font(.system(size: 15, weight: .bold))
							.foregroundStyle(.white)
							.frame(width: 38, height: 38)
							.background(leaf, in: Circle())
					}
					.buttonStyle(.plain)
					.accessibilityLabel("Add ingredient")
				}
				.padding(.leading, 15)
				.padding(.trailing, 6)
				.frame(height: 50)
				.background(.white, in: RoundedRectangle(cornerRadius: 12))
				.padding(.horizontal, 20)
				.padding(.bottom, 14)

				if groceryList.isEmpty {
					ContentUnavailableView("Your list is clear", systemImage: "basket", description: Text("Add an ingredient above or send ingredients here from a recipe."))
						.foregroundStyle(ink)
						.frame(maxHeight: .infinity)
				} else {
					ScrollView {
						LazyVStack(spacing: 0) {
							ForEach(Array(groceryList.enumerated()), id: \.offset) { index, item in
								HStack(spacing: 13) {
									Button {
										toggleChecked(item)
									} label: {
										Image(systemName: checkedItems.contains(item) ? "checkmark.circle.fill" : "circle")
											.font(.system(size: 21))
											.foregroundStyle(checkedItems.contains(item) ? leaf : Color.gray.opacity(0.55))
									}
									.buttonStyle(.plain)
									.accessibilityLabel(checkedItems.contains(item) ? "Mark \(item) as needed" : "Mark \(item) as picked up")

									Text(item)
										.font(.system(size: 16, weight: .medium))
										.foregroundStyle(checkedItems.contains(item) ? .secondary : ink)
										.strikethrough(checkedItems.contains(item))
									Spacer()
									Button {
										groceryList.remove(at: index)
										checkedItems.remove(item)
									} label: {
										Image(systemName: "xmark")
											.font(.system(size: 11, weight: .bold))
											.foregroundStyle(.secondary.opacity(0.7))
											.frame(width: 30, height: 36)
									}
									.buttonStyle(.plain)
									.accessibilityLabel("Remove \(item)")
								}
								.padding(.horizontal, 15)
								.frame(height: 56)
								if index < groceryList.count - 1 {
									Divider().padding(.leading, 49)
								}
							}
						}
						.background(.white, in: RoundedRectangle(cornerRadius: 14))
						.padding(.horizontal, 20)
						.padding(.bottom, 20)
					}
				}
			}
			.background(Color(red: 0.96, green: 0.95, blue: 0.91).ignoresSafeArea())
			.navigationTitle("Groceries")
			.navigationBarTitleDisplayMode(.inline)
		}
		.tint(ink)
	}

	private func addItem() {
		let item = newItem.trimmingCharacters(in: .whitespacesAndNewlines)
		guard !item.isEmpty else { return }
		groceryList.append(item)
		newItem = ""
	}

	private func toggleChecked(_ item: String) {
		if checkedItems.contains(item) {
			checkedItems.remove(item)
		} else {
			checkedItems.insert(item)
		}
	}
}

