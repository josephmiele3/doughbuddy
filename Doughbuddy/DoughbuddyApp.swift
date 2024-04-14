//
//  DoughbuddyApp.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 1/31/24.
//

import SwiftUI
import SwiftData

@main
struct DoughbuddyApp: App {
  //  @StateObject var recipebook = RecipeBook()
 /*   var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
*/
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
      //  .environmentObject(recipebook)
        .modelContainer(for: [Recipe.self, recipeStep.self])
        

    }
}
