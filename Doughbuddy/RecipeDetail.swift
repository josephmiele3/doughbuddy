//
//  RecipeDetail.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 2/3/24.
//

import Foundation
import SwiftUI
import SwiftData

struct RecipeDetail: View {
    @Bindable var recipe: Recipe
    
    @State private var currentStepIndex = 0
    
    // Timer related states
    @State private var timer: Timer?
    @State private var secondsRemaining: TimeInterval = 0
    @State private var timerIsActive = false
    @State private var showingInputView = false
    @State private var inputTemperature: String = ""
    @State private var showAlert = false

    //SwiftData is so bad holy moly
    private var sortedSteps: [recipeStep]{
        recipe.recipeSteps.sorted(by: {$0.stepOrder < $1.stepOrder})
    }
    
    @State private var showingRatingView = false
    @State private var inputComment: String = ""
    @State private var inputRating: Int = 0
    
    var body: some View {
        VStack {
            if currentStepIndex < sortedSteps.count {
                Text(sortedSteps[currentStepIndex].stepFollow).padding()
                Text("Step \(sortedSteps[currentStepIndex].stepOrder)")

            }
            
            
            
            
            
            // Show start timer button if the current step has a timer duration and timer is not active
            if let timerDuration = sortedSteps[currentStepIndex].timerDuration, !timerIsActive {
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
            VStack{
                Button("Show Comment") {
                    if currentStepIndex >= sortedSteps.count - 1 {
                        // Last step, show view for comment and rating
                        showingRatingView = true
                    }
                }.padding()
                    .disabled(currentStepIndex < sortedSteps.count - 1)
            }
            // Display input view at the last step
            if showingRatingView {
                VStack {
                    TextField("Enter your comment", text: $recipe.recipeIngred).padding()
                    Picker("Rating", selection: $recipe.stepsNumber) {
                        ForEach(1...5, id: \.self) { rating in
                            Text("\(rating) Stars").tag(String(rating))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                .padding()
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
    
    private func submitFeedback(comment: String, rating: Int) {
        // Handle the submission of feedback
        print("Comment: \(comment), Rating: \(rating) stars")
        // Reset for the next usage
        showingInputView = false
        inputComment = ""
        inputRating = 0
    }

    }
    
     

/* struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: RecipeBook().recipes.randomElement() ?? Recipe(name: "Test recipe", stepsNumber: "4", recipeSteps: [recipeStep(stepFollow: "nothing here", timerDuration: nil) ], recipeIngred: "None"))
    }
}
*/
