import SwiftUI

struct NutritionView: View {
    @State private var selectedDate: Date = Date()
    @State private var breakfastData: [MealData] = []
    @State private var lunchData: [MealData] = []
    @State private var dinnerData: [MealData] = []
    @State private var snackData: [MealData] = []
    @State private var currentMealType: String? = nil
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
                            mealType: "Breakfast",
                            meals: $breakfastData,
                            showAddMealView: $showAddMealView,
                            currentMealType: $currentMealType,
                            userId: authViewModel.userId ?? ""
                        )
                        .sheet(isPresented: $showAddMealView) {
                            //AddMealView(userId: authViewModel.userId ?? "", date: dateFormatter.string(from: selectedDate), mealType: currentMealType ?? "")
                            RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "Breakfast"))
                        }

                        MealSectionView(
                            mealType: "Lunch",
                            meals: $lunchData,
                            showAddMealView: $showAddMealView,
                            currentMealType: $currentMealType,
                            userId: authViewModel.userId ?? ""
                        )
                        .sheet(isPresented: $showAddMealView) {
                            AddMealView(userId: authViewModel.userId ?? "", date: dateFormatter.string(from: selectedDate), mealType: currentMealType ?? "")
                        }

                        MealSectionView(
                            mealType: "Dinner",
                            meals: $dinnerData,
                            showAddMealView: $showAddMealView,
                            currentMealType: $currentMealType,
                            userId: authViewModel.userId ?? ""
                        )
                        .sheet(isPresented: $showAddMealView) {
                            AddMealView(userId: authViewModel.userId ?? "", date: dateFormatter.string(from: selectedDate), mealType: currentMealType ?? "")
                        }
                        MealSectionView(
                            mealType: "Snack",
                            meals: $snackData,
                            showAddMealView: $showAddMealView,
                            currentMealType: $currentMealType,
                            userId: authViewModel.userId ?? ""
                        )
                        .sheet(isPresented: $showAddMealView) {
                            AddMealView(userId: authViewModel.userId ?? "", date: dateFormatter.string(from: selectedDate), mealType: currentMealType ?? "")
                        }
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

                        MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "Breakfast") { meals in
                            breakfastData = meals
                        }
                        MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "Lunch") { meals in
                            lunchData = meals
                        }
                        MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "Dinner") { meals in
                            dinnerData = meals
                        }
                        MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "Snack") { meals in
                            snackData = meals
                        }
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
