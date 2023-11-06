//
//  ContentView.swift
//  weSplit
//
//  Created by Montserrat Gomez on 2023-11-03.
//

import SwiftUI

struct ContentView: View {
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool //para que desaparesca el keyboard
	
	let tipPercentages = [10, 15, 20, 25, 0]
	
	/// Es una variable calculada para calcular el porcentaje
	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		let tipSelection = Double(tipPercentage)
		
		let tipValue = checkAmount / 100 * tipSelection
		let grandTotal = checkAmount + tipValue
		let amountPerPerson = grandTotal / peopleCount
		
		return amountPerPerson
	}
	
    var body: some View {
		
		NavigationStack{
			Form{
				Section{ //ingresar la cantidad
					TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)
						.submitLabel(.next)
				}
				Section("How much tip do you want to leave?") {
			
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(tipPercentages, id: \.self){
							Text($0, format: .percent)
						}
					}
					.pickerStyle(.segmented)
				}
				
				Section("Amount per person") { //mostrar la cantidad
					Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
					
					Picker("Number of people", selection: $numberOfPeople){
						ForEach(2..<30){
							Text("\($0) people")
						}
					}
					.pickerStyle(.automatic)
				}
				
				Section(){
					var total = totalPerPerson + checkAmount
					HStack{
						Text("Total:")
							.font(.title2)
						Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
							.font(.title3)
					}
					
				}
				
			}
			.navigationTitle("We Split")
			.toolbar {
				if amountIsFocused {
					Button("Done") {
						amountIsFocused = false
					}
				}
			}
		}
		
    }
}

#Preview {
    ContentView()
}
