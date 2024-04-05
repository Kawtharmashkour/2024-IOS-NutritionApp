import SwiftUI

struct NutritionView: View {
    @State private var selectedDate: Date = Date()
    @State private var breakfastData: [MealData] = []
    @State private var lunchData: [MealData] = []
    @State private var dinnerData: [MealData] = []
    @State private var snackData: [MealData] = []
    @State private var teaData: [MealData] = []
    @State private var currentMealType: String = ""
    @State private var showAddMealView = false
    @State private var showSettings = false
    @EnvironmentObject var authViewModel: AuthViewModel
    var allMeals: [MealData] {
           breakfastData + lunchData + dinnerData + snackData
       }
    

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Calendar navigation bar
                    CalendarView(days: generateDays(), selectedDate: $selectedDate)

                    Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                        .padding()

                    // Nutritional elements circular graph
                    NutritionalGraphView(meals: allMeals)
                  
                    Spacer().frame(height: 200)
                    // Meal sections
                    VStack {
                        MealSectionView(
                            mealType: "breakfast",
                            meals: $breakfastData,
                            showAddMealView: $showAddMealView,
                            currentMealType: $currentMealType,
                            userId: authViewModel.userId ?? ""
                        )
                        .sheet(isPresented: $showAddMealView) {
                            RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "breakfast"))
                        }

                        MealSectionView(
                            mealType: "lunch",
                            meals: $lunchData,
                            showAddMealView: $showAddMealView,
                            currentMealType: $currentMealType,
                            userId: authViewModel.userId ?? ""
                        )
                        .sheet(isPresented: $showAddMealView) {
                            RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "lunch"))
                        }
                        MealSectionView(
                            mealType: "dinner",
                            meals: $dinnerData,
                            showAddMealView: $showAddMealView,
                            currentMealType: $currentMealType,
                            userId: authViewModel.userId ?? ""
                        )
                        .sheet(isPresented: $showAddMealView) {
                            RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "dinner"))
                        }

                        MealSectionView(
                            mealType: "snack",
                            meals: $snackData,
                            showAddMealView: $showAddMealView,
                            currentMealType: $currentMealType,
                            userId: authViewModel.userId ?? ""
                        )
                        .sheet(isPresented: $showAddMealView) {
                            RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "snack"))
                        }
//                        MealSectionView(
//                            mealType: "teatime",
//                            meals: $teaData,
//                            showAddMealView: $showAddMealView,
//                            currentMealType: $currentMealType,
//                            userId: authViewModel.userId ?? ""
//                        )
//                        .sheet(isPresented: $showAddMealView) {
//                            RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "teatime"))
//                        }
                    }
                }
                .navigationTitle("Today")
                .toolbar {
                    NavigationLink(destination: SettingView(), isActive: $showSettings) {
                                           Button(action: {
                                               showSettings = true
                                           }) {
                                               Image(systemName: "gearshape")
                                                   .foregroundColor(.blue)
                                           }
                                       }
                    .onAppear {
                
                        let userId = authViewModel.userId ?? "DDVmxDPbFZZhEs4QebM8HTQQLVi1"
                           let dateString = dateFormatter.string(from: selectedDate)

                        MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "breakfast") { meals in
                            breakfastData = meals
                            print("Breakfast data: \(breakfastData)")
                        }
                        MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "lunch") { meals in
                            lunchData = meals
                            print("Lunch data: \(lunchData)")
                        }
                        MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "dinner") { meals in
                            lunchData = meals
                            print("dinner data: \(dinnerData)")
                        }
                        MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "snack") { meals in
                            snackData = meals
                            print("snack data: \(snackData)")
                        }

//                        MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "teatime") { meals in
//                            teaData = meals
//                            print("tea data: \(teaData)")
//                        }
                    }
                }
            }
        }
    }
    
    

    private func generateDays() -> [Date] {
        let today = Date()
        let calendar = Calendar.current
        let range = -15...15
        return range.map { calendar.date(byAdding: .day, value: $0, to: today)! }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
}

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView()
                    .environmentObject(AuthViewModel())
    }
}
