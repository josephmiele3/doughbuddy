//
//  RecipeDetail.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 2/3/24.
//

import Foundation
import SwiftUI

struct RecipeDetail: View {
    var recipe: Recipe
    
    @State private var currentStepIndex = 0
    
    // Timer related states
    @State private var timer: Timer?
    @State private var secondsRemaining: TimeInterval = 0
    @State private var timerIsActive = false
    @State private var showingInputView = false
    @State private var inputTemperature: String = ""
    @State private var showAlert = false

    
    var body: some View {
        VStack {
            Text(recipe.recipeSteps[currentStepIndex].description).padding()
            
            // Show start timer button if the current step has a timer duration and timer is not active
            if let timerDuration = recipe.recipeSteps[currentStepIndex].timerDuration, !timerIsActive {
                Button("Start Timer") {
                    startTimer(duration: timerDuration)
                }.padding()
            }
            
            //Need a better formula to calculate rising time
            
          Button("Start Timer With Temperature") {
                    startTimerPrompt()
                }
            
            .sheet(isPresented: $showingInputView) {
                TemperatureInputView(inputTemperature: $inputTemperature, showing: $showingInputView)
                    .onDisappear {
                        startTimerWithInput()
                    }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Please enter a valid number for the temperature."), dismissButton: .default(Text("OK")))
            }

            
            // Timer display, only shown if timer is active
            if timerIsActive {
                if secondsRemaining > 3600 {
                    let hours = Int(secondsRemaining) / 3600
                    let minutes = (Int(secondsRemaining) % 3600) / 60
                    let seconds = Int(secondsRemaining) % 60
                    Text("Time left: \(hours) hours, \(minutes) min, \(seconds) sec").padding()
                } else {
                    let minutes = Int(secondsRemaining) / 60
                    let seconds = Int(secondsRemaining) % 60
                    Text("Time left: \(minutes) min, \(seconds) sec").padding()
                }
            }
            
            // Navigation buttons
            HStack {
                
                Button("Previous") {
                    goToPreviousStep()
                }.padding()
                .disabled(currentStepIndex == 0) // Disable if on the first step
                Spacer()
                Button("Next") {
                    goToNextStep()
                }.padding()
                .disabled(currentStepIndex >= recipe.recipeSteps.count - 1) // Disable if on the last step
            }
        }
        .onDisappear {
            // Invalidate the timer when the view disappears
            timer?.invalidate()
        }
    }
    
    private func goToNextStep() {
        if currentStepIndex < recipe.recipeSteps.count - 1 {
            currentStepIndex += 1
            resetTimerState()
        }
    }
    
    private func goToPreviousStep() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
            resetTimerState()
        }
    }
    
    private func resetTimerState() {
        // Invalidate existing timer and reset timer state
        timer?.invalidate()
        secondsRemaining = 0
        timerIsActive = false
    }
    
    private func startTimer(duration: TimeInterval) {
        timerIsActive = true
        secondsRemaining = duration
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    if secondsRemaining > 0 {
                        secondsRemaining -= 1
                    } else {
                        timer?.invalidate()
                        self.timerIsActive = false
                    }
                }
        }
    
    private func startTimerPrompt() {
        showingInputView = true
    }

    private func startTimerWithInput() {
        guard let T = Double(inputTemperature) else {
            showAlert = true
            return
        }
        
        let R = -0.375 * T + 40.125
        var adjustedR = R * 3600
        if adjustedR >= 3600 * 30{
            adjustedR = 3600 * 30
        }
        else if adjustedR <= 3600 * 4{
            adjustedR = 3600 * 4
        }
        startTimer(duration: adjustedR)
    }

    }
    
     

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: RecipeBook().recipes.randomElement() ?? Recipe(name: "Test recipe", stepsNumber: "4", recipeSteps: [recipeStep(description: "nothing here", timerDuration: nil) ], recipeIngred: "None"))
    }
}

