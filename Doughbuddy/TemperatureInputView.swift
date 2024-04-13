//
//  TemperatureInputView.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 3/1/24.
//

import SwiftUI

struct TemperatureInputView: View {
    @Binding var inputTemperature: String
    @Binding var showing: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Enter your local temperature in Fahrenheit")
            TextField("Temperature in Fahrenheit", text: $inputTemperature)
            
            Button("Submit") {
                if Double(inputTemperature) != nil {
                    showing = false
                }
            }
            .padding()
        }
        .padding()
    }
}


/*#Preview {

    TemperatureInputView(inputTemperature: $inputTemperature, showing: $showingInputView)

}
*/
