//
//  EditRecipeDatabaseView.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 4/13/24.
//

import SwiftUI

struct EditRecipeDatabaseView: View {
    var book: [Recipe]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        
        
        NavigationStack{
            List{
                ForEach(book) { recipe in
                    NavigationLink {
                        EditRecipeView(recipe: recipe)
                            .navigationTitle(recipe.name)
                    } label: {
                        RecipeRow(recipe: recipe)
                    }
                    
                    
                }.onDelete(perform: deleteRecipes)
            }.toolbar {Button("Test", action:addsamples)}
            
        }
    };
    func addsamples(){
        let testrecipe = Recipe(name: "test", stepsNumber: "4", recipeSteps: [recipeStep(stepFollow: "", timerDuration: 40)], recipeIngred: "2")
        modelContext.insert(testrecipe)
    }
    func deleteRecipes(indexSet: IndexSet){
        for index in indexSet {
            let recipe = book[index]
            modelContext.delete(recipe)
        }
    }
}
