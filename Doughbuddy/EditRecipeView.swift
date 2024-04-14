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
    var body: some View {
        
        VStack{
            Form{
                TextField("Name", text: $recipe.name)
                Section(header: Text("Add New Step")) {
                    TextField("Enter step \(recipe.recipeSteps.count + 1) for the recipe.", text: $newStepText)
                    TextField("If this step requires a timer, enter one here. If not, leave blank.", text: $timerDurationText)
                    //.keyboardType(.numberPad)
                    Button("Add Step", action: addStep)
                }
            }

            }
            
    };
    
    func addStep(){
        guard newStepText.isEmpty == false else {return}
        if let duration = TimeInterval(timerDurationText) {
            let newstep = recipeStep(stepFollow: newStepText, timerDuration: duration)
            recipe.recipeSteps.insert(newstep, at: recipe.recipeSteps.endIndex)
            newStepText = ""
            timerDurationText = ""
        } else {
            print("Invalid duration input")
            let newstep = recipeStep(stepFollow: newStepText, timerDuration: nil)
            recipe.recipeSteps.insert(newstep, at: recipe.recipeSteps.endIndex)
            newStepText = ""
            timerDurationText = ""
        }
        
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
