//
//  ContentView.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 2/1/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @EnvironmentObject var book : RecipeBook
    @Query(sort: \Recipe.name) var book: [Recipe]
    var body: some View {
        
        NavigationStack{
            List{
                ForEach(book) { recipe in
                    NavigationLink {
                        RecipeDetail(recipe: recipe)
                            .navigationTitle(recipe.name)
                    } label: {
                        RecipeRow(recipe: recipe)
                    }
                    
                    
                }
            }
            NavigationLink(destination: EditRecipeDatabaseView(book: book)) {
                Text("Edit Recipe Database")
            }.padding()
        }
        
        
        
    };
    

        }

/* #Preview {
 ContentView().environmentObject(RecipeBook())
 }
 */
