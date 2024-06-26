//
//  FilterMenuView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-04-04.
//

import SwiftUI

struct FilterMenuView: View {
    @Binding var isMenuVisible1: Bool
    var doneAction: ((String) -> Void)? // Closure to be called when "Done" button is pressed
    // Arrays to store the selected items in each section
    @AppStorage("selectedFilters") var selectedFilters: String = ""
        @State private var selectedDiets: [String] = []
       // @State private var selectedCalories: Int?
    
    var body: some View {
        ZStack {
                if isMenuVisible1 {
                    Color.black .opacity(0.5)//comment
                        .navigationBarBackButtonHidden(true)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                                isMenuVisible1 = false
                            }
                    HStack {
                            Spacer()
                            NavigationView {
                                List {
                                    Section(header: Text("Health")) {
                                        ForEach(Constants.allergies, id: \.self) { allergy in
                                                    HStack {
                                                        Text(allergy)
                                                            .onTapGesture {
                                                                toggleSelection(item: ("&health=" + allergy))
                                                                print (selectedFilters)
                                                            }
                                                        if selectedFilters.contains(allergy) {
                                                            Spacer()
                                                            Image(systemName: "checkmark")
                                                                .foregroundColor(.blue)
                                                        }
                                                    }
                                                }
                                            }
                                            Section(header: Text("Diets")) {
                                                ForEach(Constants.diets, id: \.self) { diet in
                                                    HStack {
                                                        Text(diet)
                                                            .onTapGesture {
                                                                toggleSelection(item: ("&diet=" + diet))
                                                                print (selectedFilters)
                                                            }
                                                        if selectedFilters.contains(diet) {
                                                            Spacer()
                                                            Image(systemName: "checkmark")
                                                                .foregroundColor(.blue)
                                                        }
                                                    }
                                                }
                                            }
                                            /*Section(header: Text("Calories")) {
                                                TextField("Enter Max. Calories", value: $selectedCalories, formatter: NumberFormatter())
                                                        .keyboardType(.numberPad)
                                            }*/
                                        }
                                        .navigationBarTitle("Filters")
                                        .navigationBarItems(trailing:
                                            HStack {
                                                Button("Done") {
                                                    handleDoneButton()
                                                   /* withAnimation{
                                                        isMenuVisible1 = false
                                                    }*/
                                                }
                                                Button("Clear") {
                                                    clearSelections()
                                                }
                                            }
                                        )
                                    }
                            .navigationBarBackButtonHidden(true)
                            .frame(width: UIScreen.main.bounds.width * 0.75)
                            .offset(x: isMenuVisible1 ? 0 : UIScreen.main.bounds.width)
                            .animation(.easeInOut)
                        }

                    }
                }
    }
    // Function to toggle selection of an item in the array
        private func toggleSelection(item: String) {
            if selectedFilters.contains(item) {
                selectedFilters = selectedFilters.replacingOccurrences(of: (item), with: "")
                print("selectedFilter after remove")
            } else {
                selectedFilters += item
            }
        }
        
        // Function to clear all selections
        private func clearSelections() {
            selectedFilters.removeAll()
            print ("Cleared allergy list: \(selectedFilters)")
            selectedDiets.removeAll()
           // selectedCalories = nil
        }
    
    // Function to handle "Done" button action
        private func handleDoneButton() {
            // Call the done action closure if provided
            doneAction?(selectedFilters)
            // Close the menu
            isMenuVisible1 = false
        }

}


/*struct FilterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMenuView(isMenuVisible1: .constant(true))
    }
}*/
