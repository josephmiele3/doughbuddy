//
//  RecipeBook.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 2/2/24.
//

import Foundation
import SwiftUI

class RecipeBook : ObservableObject {
    @Published var recipes = [
        Recipe(name: "Basic Sourdough Bread",
               stepsNumber: "5",
               recipeSteps: [
                   recipeStep(description: "Mix 100g sourdough starter with 375ml warm water.", timerDuration: nil),
                   recipeStep(description: "Add 500g bread flour and 10g salt to the mixture, then knead until smooth.", timerDuration: nil),
                   recipeStep(description: "Let the dough rest for a first rise, covered, for about 5 hours at room temperature.", timerDuration: 5 * 60 * 60),
                   recipeStep(description: "Fold the dough onto itself and shape it. Then, let it rest for a second rise in a floured banneton or bowl for 2 hours.", timerDuration: 2 * 60 * 60),
                   recipeStep(description: "Bake at 230°C (450°F) for 35 minutes with steam, then another 20 minutes without steam to develop the crust.", timerDuration: 35 * 60)
               ],
               recipeIngred: "100g sourdough starter, 375ml warm water, 500g bread flour, 10g salt"
           ),
        Recipe( name: "Whole Wheat Sourdough",
                stepsNumber: "6",
                recipeSteps: [
                    recipeStep(description: "Autolyse by mixing 400g whole wheat flour with 350ml water. Let it sit for 1 hour.", timerDuration: 60 * 60),
                    recipeStep(description: "Add 100g sourdough starter and 10g salt to the mixture. Knead until well combined.", timerDuration: nil),
                    recipeStep(description: "Stretch and fold the dough every 30 minutes for the first 2 hours of bulk fermentation.", timerDuration: 2 * 60 * 60),
                    recipeStep(description: "After bulk fermentation, shape the dough and place it into a floured banneton. Let it rise overnight in the refrigerator.", timerDuration: 12 * 60 * 60),
                    recipeStep(description: "The next morning, let the dough come to room temperature for about 1 hour before baking.", timerDuration: 60 * 60),
                    recipeStep(description: "Bake at 240°C (465°F) for 50 minutes.", timerDuration: 50 * 60)
                ],
                recipeIngred: "400g whole wheat flour, 350ml water, 100g sourdough starter, 10g salt"
            ),
        Recipe(name: "Blueberry Muffins",
            stepsNumber: "4",
            recipeSteps: [
                recipeStep(description: "1. Preheat the oven to 375°F (190°C) and line a muffin tin with paper liners.", timerDuration: nil),
                recipeStep(description: "2. In a large bowl, whisk together 2 cups of all-purpose flour, 1 cup of granulated sugar, 1 tablespoon of baking powder, and a pinch of salt.", timerDuration: nil),
                recipeStep(description: "3. In a separate bowl, mix together 1 cup of milk, 1/2 cup of melted butter, and 2 large eggs. Add the wet ingredients to the dry ingredients and stir until just combined. Fold in 1.5 cups of fresh or frozen blueberries.", timerDuration: nil),
                recipeStep(description: "4. Divide the batter evenly among the muffin cups and bake for 20 minutes or until a toothpick inserted into the center comes out clean.", timerDuration: 20 * 60)
            ],
            recipeIngred: """
            - 2 cups all-purpose flour
            - 1 cup granulated sugar
            - 1 tablespoon baking powder
            - Pinch of salt
            - 1 cup milk
            - 1/2 cup melted butter
            - 2 large eggs
            - 1.5 cups fresh or frozen blueberries
            """
        )
    ]
}


 struct Recipe : Identifiable {
        var name : String
        var stepsNumber : String
        var recipeSteps : [recipeStep]
        var recipeIngred : String
        var id = UUID()
    }

struct recipeStep {
    let description : String
    let timerDuration : TimeInterval?
}

