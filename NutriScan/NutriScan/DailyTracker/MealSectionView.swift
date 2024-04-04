import SwiftUI

struct MealSectionView: View {
    let mealType: String
    @Binding var meals: [MealData]
    @Binding var showAddMealView: Bool
    @State private var recognizedText = ""
    @State private var showScanner = false
    let userId: String

    var body: some View {
        VStack(alignment: .leading) {
            // Meal type and buttons
            HStack {
                Text(mealType)
                    .fontWeight(.bold)

                Spacer()

                Button(action: {
                    showScanner = true
                }) {
                    Image(systemName: "doc.text.viewfinder")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding(.trailing, 10)

                Button(action: {
                    showAddMealView = true
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.bottom, 5) // Add some spacing between the buttons and the nutritional info

            // Nutritional elements
            HStack {
                VStack {
                    Text("Calories")
                    Text("\(meals.reduce(0) { $0 + $1.calories }, specifier: "%.2f")")
                }
                Spacer()

                VStack {
                    Text("Proteins")
                    Text("\(meals.reduce(0) { $0 + $1.proteins }, specifier: "%.2f")")
                }
                Spacer()

                VStack {
                    Text("Carbs")
                    Text("\(meals.reduce(0) { $0 + $1.carbs }, specifier: "%.2f")")
                }
                Spacer()

                VStack {
                    Text("Fat")
                    Text("\(meals.reduce(0) { $0 + $1.fats }, specifier: "%.2f")")
                }
            }
            .padding(.bottom, 5) // Add some spacing between the nutritional info and the meal list

            // Display each meal item
            List {
                ForEach(meals, id: \.id) { meal in
                    VStack(alignment: .leading) {
                        Text(meal.name)
                            .font(.headline)

                        // Split the meal type string into an array and display each type
                        ForEach(meal.type.components(separatedBy: ", "), id: \.self) { type in
                            Text("Type: \(type)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteMeal)
            }
        }
        .sheet(isPresented: $showScanner) {
            TextScannerView(recognizedText: $recognizedText)
                .onDisappear {
                    let extractedInfo = extractNutritionalInfo(from: recognizedText.components(separatedBy: "\n"))
                    print("Extracted Info: \(extractedInfo)")
                    // Add additional logic to handle the extracted nutritional information
                }
        }
    }

    private func deleteMeal(at offsets: IndexSet) {
            for index in offsets {
                if let mealId = meals[index].id {
                    MealDataManager.deleteMealData(userId: userId, mealId: mealId) { success in
                        if success {
                            meals.remove(at: index)
                        }
                    }
                }
            }
        }
    }
