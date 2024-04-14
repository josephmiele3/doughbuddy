//
//  EditRecipeView.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 4/13/24.
//

import SwiftUI
import SwiftData

struct EditRecipeView: View {
    
    @Bindable var recipe : Recipe
    @State private var newStepText = ""
    @State private var timerDurationText = ""
    @State var coolvar1 = ""

    var body: some View {
        
        VStack{
            Form{
                TextField("Name", text: $recipe.name)
                Section(header: Text("Add New Step")) {
                    TextField("Enter step \(recipe.recipeSteps.count + 1) for the recipe.", text: $newStepText)
                    TextField("If this step requires a timer, enter one here. If not, leave blank.", text: $timerDurationText)
                    //.keyboardType(.numberPad)
                    TextField("manually increment this by 1", text: $coolvar1)
                    Button("Add Step", action: addStep)
                }
            }

            }
            
    };
    
    func addStep() {
        guard !newStepText.isEmpty else { return }

        // Determine the maximum stepOrder currently in recipeSteps
        let maxStepOrder = recipe.recipeSteps.map { $0.stepOrder }.max() ?? 0
        let newStepOrder = maxStepOrder + 1

        if let duration = TimeInterval(timerDurationText) {
            let newStep = recipeStep(stepFollow: newStepText, timerDuration: duration, stepOrder: newStepOrder)
            recipe.recipeSteps.append(newStep)
        } else {
            let newStep = recipeStep(stepFollow: newStepText, timerDuration: nil, stepOrder: newStepOrder)
            recipe.recipeSteps.append(newStep)
        }

        // Clear the fields
        newStepText = ""
        timerDurationText = ""
    }
}
/*
 
 #Preview {
 do {
 let config = ModelConfiguration(isStoredInMemoryOnly: true)
 let contain = try ModelContainer(for: Recipe.self, configurations: config)
 let example = Recipe(name: "test", stepsNumber: "4", recipeSteps: [recipeStep(stepFollow: "test test", timerDuration: 40)], recipeIngred: "2")
 return EditRecipeView(recipe: example)
 .modelContainer(contain)
 
 } catch {
 fatalError("Failed to create container")
 }
 }
 */
