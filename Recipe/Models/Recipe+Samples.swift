import Foundation

extension RecipeResponse {
    static let sampleWeeklyDrop = RecipeResponse(
        id: 1,
        title: "Creamy lemon orzo with crispy chickpeas",
        prepTime: 15,
        cookTime: 25,
        servings: 4,
        recipeIngredients: [
            sampleIngredient(1, "Orzo", 250, "g"),
            sampleIngredient(2, "Chickpeas", 1, "can"),
            sampleIngredient(3, "Baby spinach", 100, "g"),
            sampleIngredient(4, "Lemon", 1, "whole"),
            sampleIngredient(5, "Vegetable stock", 600, "ml"),
            sampleIngredient(6, "Parmesan", 50, "g")
        ],
        steps: [
            RecipeStepResponse(id: 1, stepNumber: 1, description: "Drain and dry the chickpeas. Toss with olive oil, smoked paprika, salt, and pepper, then roast at 220°C until crisp."),
            RecipeStepResponse(id: 2, stepNumber: 2, description: "Toast the orzo in a little olive oil, then add the warm stock. Simmer, stirring often, until creamy and just tender."),
            RecipeStepResponse(id: 3, stepNumber: 3, description: "Fold in spinach, lemon zest and juice, and grated parmesan. Season to taste and finish with the crispy chickpeas.")
        ],
        images: [sampleImage(1, "photo-1476124369491-e7addf5db371")]
    )

    static let sampleFeed: [RecipeResponse] = [
        sampleWeeklyDrop,
        RecipeResponse(
            id: 2,
            title: "Miso butter mushroom toast",
            prepTime: 10,
            cookTime: 15,
            servings: 2,
            recipeIngredients: [
                sampleIngredient(7, "Mixed mushrooms", 300, "g"),
                sampleIngredient(8, "Sourdough", 2, "slices"),
                sampleIngredient(9, "White miso", 1, "tbsp"),
                sampleIngredient(10, "Butter", 30, "g"),
                sampleIngredient(11, "Parsley", 10, "g")
            ],
            steps: [
                RecipeStepResponse(id: 4, stepNumber: 1, description: "Tear the mushrooms into bite-sized pieces and sear in a hot pan until deeply golden."),
                RecipeStepResponse(id: 5, stepNumber: 2, description: "Lower the heat. Stir in butter and miso until glossy, then spoon over toasted sourdough."),
                RecipeStepResponse(id: 6, stepNumber: 3, description: "Scatter with chopped parsley and plenty of black pepper.")
            ],
            images: [sampleImage(2, "photo-1506084868230-bb9d95c24759")]
        ),
        RecipeResponse(
            id: 3,
            title: "Green goddess crispy rice bowl",
            prepTime: 20,
            cookTime: 20,
            servings: 2,
            recipeIngredients: [
                sampleIngredient(12, "Jasmine rice", 200, "g"),
                sampleIngredient(13, "Cucumber", 1, "whole"),
                sampleIngredient(14, "Avocado", 1, "whole"),
                sampleIngredient(15, "Greek yogurt", 100, "g"),
                sampleIngredient(16, "Fresh herbs", 25, "g")
            ],
            steps: [
                RecipeStepResponse(id: 7, stepNumber: 1, description: "Cook the rice, spread it on a tray, and let it steam-dry for a few minutes."),
                RecipeStepResponse(id: 8, stepNumber: 2, description: "Crisp the rice in a hot skillet with olive oil, turning occasionally until golden."),
                RecipeStepResponse(id: 9, stepNumber: 3, description: "Blend yogurt with herbs and lemon. Serve with cucumber, avocado, and the crispy rice.")
            ],
            images: [sampleImage(3, "photo-1512621776951-a57141f2eefd")]
        ),
        RecipeResponse(
            id: 4,
            title: "One-pan tomato butter beans",
            prepTime: 8,
            cookTime: 22,
            servings: 3,
            recipeIngredients: [
                sampleIngredient(17, "Butter beans", 2, "cans"),
                sampleIngredient(18, "Cherry tomatoes", 300, "g"),
                sampleIngredient(19, "Garlic", 3, "cloves"),
                sampleIngredient(20, "Feta", 100, "g"),
                sampleIngredient(21, "Basil", 10, "g")
            ],
            steps: [
                RecipeStepResponse(id: 10, stepNumber: 1, description: "Soften sliced garlic in olive oil, then add the tomatoes and a pinch of salt."),
                RecipeStepResponse(id: 11, stepNumber: 2, description: "When the tomatoes burst, stir in drained butter beans and simmer until silky."),
                RecipeStepResponse(id: 12, stepNumber: 3, description: "Crumble over feta and torn basil. Bring the pan to the table with toasted bread.")
            ],
            images: [sampleImage(4, "photo-1547592180-85f173990554")]
        )
    ]

    private static func sampleIngredient(_ id: Int, _ name: String, _ amount: Int, _ unit: String) -> RecipeIngredientResponse {
        RecipeIngredientResponse(
            ingredientId: id,
            amount: Decimal(amount),
            unit: unit,
            ingredient: IngredientResponse(id: id, name: name, category: "Pantry")
        )
    }

    private static func sampleImage(_ id: Int, _ photoID: String) -> RecipeImageResponse {
        RecipeImageResponse(
            id: id,
            imageUrl: "https://images.unsplash.com/\(photoID)?auto=format&fit=crop&w=1200&q=85",
            isPrimary: true
        )
    }
}