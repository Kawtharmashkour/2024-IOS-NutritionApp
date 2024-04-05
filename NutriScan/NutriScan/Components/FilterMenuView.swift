//
//  FilterMenuView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-04-04.
//

import SwiftUI

struct FilterMenuView: View {
    @Binding var isMenuVisible1: Bool
    // Arrays to store the selected items in each section
        @State private var selectedAllergies: [String] = []
        @State private var selectedDiets: [String] = []
        @State private var selectedCalories: Int?
    
    var body: some View {
        ZStack {
                    if isMenuVisible1 {
                        Color.black.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                // Close the menu when tapping outside
                                withAnimation {
                                    isMenuVisible1 = false
                                }
                            }
                        HStack {
                            Spacer()
                            NavigationView {
                                        List {
                                            Section(header: Text("Allergies")) {
                                                ForEach(Constants.allergies, id: \.self) { allergy in
                                                    HStack {
                                                        Text(allergy)
                                                            .onTapGesture {
                                                                toggleSelection(&selectedAllergies, item: allergy)
                                                                print (selectedAllergies)
                                                            }
                                                        
                                                        if selectedAllergies.contains(allergy) {
                                                            Spacer()
                                                            Image(systemName: "checkmark")
                                                                .foregroundColor(.blue)
                                                        }
                                                    }
                                                    
                                                }
                                            }
                                            Section(header: Text("Diets")) {
                                                ForEach(Constants.diets, id: \.self) { diet in
                                                    Text(diet)
                                                }
                                            }
                                            Section(header: Text("Calories")) {
                                                TextField("Enter Max. Calories", value: $selectedCalories, formatter: NumberFormatter())
                                                        .keyboardType(.numberPad)
                                            }
                                        }
                                        .navigationBarTitle("Filters")
                                        .navigationBarItems(trailing:
                                            HStack {
                                                Button("Done") {
                                                    withAnimation{
                                                        isMenuVisible1 = false
                                                    }
                                                }
                                                Button("Clear") {
                                                    clearSelections()
                                                }
                                            }
                                        )
                                    }
                            .frame(width: UIScreen.main.bounds.width * 0.75)
                            .offset(x: isMenuVisible1 ? 0 : UIScreen.main.bounds.width)
                            .animation(.easeInOut)
                        }

                    }
                }
    }
    // Function to toggle selection of an item in the array
        private func toggleSelection(_ array: inout [String], item: String) {
            if let index = array.firstIndex(of: item) {
                array.remove(at: index)
            } else {
                array.append(item)
            }
        }
        
        // Function to clear all selections
        private func clearSelections() {
            selectedAllergies.removeAll()
            print ("Cleared allergy list: \(selectedAllergies)")
            selectedDiets.removeAll()
            selectedCalories = nil
        }

}


struct FilterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMenuView(isMenuVisible1: .constant(true))
    }
}
