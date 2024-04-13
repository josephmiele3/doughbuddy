//
//  ContentView.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 2/1/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var book : RecipeBook
    var body: some View {
        
        NavigationStack{
            List{
                ForEach(book.recipes) { recipe in
                    NavigationLink {
                        RecipeDetail(recipe: recipe)
                            .navigationTitle(recipe.name)
                    } label: {
                        RecipeRow(recipe: recipe)
                    }
                    
                }
            }
        }
    }
        
}

#Preview {
    ContentView().environmentObject(RecipeBook())
}
