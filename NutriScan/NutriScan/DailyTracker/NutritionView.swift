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
    @State private var showProfile = false
    @State private var mealdataManager = MealDataManager()
    @EnvironmentObject var authViewModel: AuthViewModel
    var allMeals: [MealData] {
           breakfastData + lunchData + dinnerData + snackData
       }
    

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing:10) {
                    // Calendar navigation bar
                    CalendarView(days: generateDays(), selectedDate: $selectedDate)

                    Text("Selected Date: \(selectedDate, formatter: displayDateFormatter)")
                        .padding()

                    // Nutritional elements circular graph
                    NutritionalGraphView(meals: allMeals)
                  
                    Spacer().frame(height: 200)
                    // Meal sections
                    VStack(spacing:20) {
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
                }.padding()
                .toolbar {
                    NavigationLink(destination: ProfileView(), isActive: $showProfile) {
                                           Button(action: {
                                               showProfile = true
                                           }) {
                                               Image(systemName: "person.circle.fill")
                                                   .foregroundColor(Color("ColorGreenAdaptive"))
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
                            dinnerData = meals
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
    private let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
}

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView()
                    .environmentObject(AuthViewModel())
    }
}
