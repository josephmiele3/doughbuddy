//
//  RecipeBook.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 2/2/24.
//

import Foundation
import SwiftUI
import SwiftData

 

 @Model
 class Recipe {
        var name : String
        var stepsNumber : String
     @Relationship(deleteRule: .cascade) var recipeSteps : [recipeStep]
        var recipeIngred : String
        var id = UUID()
     
     init(name: String, stepsNumber: String, recipeSteps: [recipeStep], recipeIngred: String) {
             self.name = name
             self.stepsNumber = stepsNumber
             self.recipeSteps = recipeSteps
             self.recipeIngred = recipeIngred
         }
    }

@Model
class recipeStep {
    var stepFollow : String
    var timerDuration : TimeInterval?
    var stepOrder: Int
    
    init(stepFollow: String, timerDuration: TimeInterval? = nil, stepOrder: Int) {
        self.stepFollow = stepFollow
        self.timerDuration = timerDuration
        self.stepOrder = stepOrder
    }
}

