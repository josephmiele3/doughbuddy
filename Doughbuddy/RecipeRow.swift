//
//  RecipeRow.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 2/2/24.
//

import Foundation
import SwiftUI


struct RecipeRow: View {
    var recipe : Recipe
    
    var body: some View {
        VStack {
            Text(recipe.name)
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                
            
            Text("\(recipe.recipeSteps.count) steps in this recipe")
                .font(.subheadline)
                .padding()
        }
        
        
    }
}

/* struct RecipeRow_Previews: PreviewProvider {
 static var previews: some View {
 RecipeRow(recipe: RecipeBook().recipes.randomElement() ?? Recipe(name: "Test recipe", stepsNumber: "4", recipeSteps: [
 recipeStep(description: "Chop all vegetables and mix in a large bowl.", timerDuration: 5 * 60), // 5 minutes
 recipeStep(description: "Add dressing and toss the salad before serving.", timerDuration: 1 * 60) // 1 minute to add dressing and toss
 ], recipeIngred: "None"))
 }
 }
 */
