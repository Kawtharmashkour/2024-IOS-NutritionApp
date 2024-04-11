import SwiftUI

struct NutritionView: View {

    @State private var selectedDate: Date = Date()
        @StateObject private var viewModel = NutritionViewModel(userId: AuthViewModel().userId ?? "")
        @State private var showAddMealView = false
        @State private var showProfile = false
        @EnvironmentObject var authViewModel: AuthViewModel

        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 10) {
                        CalendarView(days: generateDays(), selectedDate: $selectedDate)

                        Text("Selected Date: \(selectedDate, formatter: displayDateFormatter)")
                            .padding()

                        NutritionalGraphView(meals: viewModel.breakfastData + viewModel.lunchData + viewModel.dinnerData + viewModel.snackData)

                        Spacer().frame(height: 200)

                        VStack(spacing: 20) {
                            MealSectionView(
                                mealType: "breakfast",
                                meals: $viewModel.breakfastData,
                                showAddMealView: $showAddMealView,
                                currentMealType: .constant("breakfast"),
                                userId: authViewModel.userId ?? ""
                            )
                            .sheet(isPresented: $showAddMealView) {
                                RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "breakfast"))
                            }

                            MealSectionView(
                                mealType: "lunch",
                                meals: $viewModel.lunchData,
                                showAddMealView: $showAddMealView,
                                currentMealType: .constant("lunch"),
                                userId: authViewModel.userId ?? ""
                            )
                            .sheet(isPresented: $showAddMealView) {
                                RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "lunch"))
                            }

                            MealSectionView(
                                mealType: "dinner",
                                meals: $viewModel.dinnerData,
                                showAddMealView: $showAddMealView,
                                currentMealType: .constant("dinner"),
                                userId: authViewModel.userId ?? ""
                            )
                            .sheet(isPresented: $showAddMealView) {
                                RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "dinner"))
                            }

                            MealSectionView(
                                mealType: "snack",
                                meals: $viewModel.snackData,
                                showAddMealView: $showAddMealView,
                                currentMealType: .constant("snack"),
                                userId: authViewModel.userId ?? ""
                            )
                            .sheet(isPresented: $showAddMealView) {
                                RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "snack"))
                            }
                        }
                    }
                    .padding()
                    .toolbar {
                        HStack {
                            NavigationLink(destination: ProfileView(), isActive: $showProfile) {
                                Button(action: {
                                    showProfile = true
                                }) {
                                    Image(systemName: "person.circle.fill")
                                        .foregroundColor(Color("ColorGreenAdaptive"))
                                }
                            }

                            NavigationLink(destination: SettingView()) {  
                                Image(systemName: "gearshape")
                                    .foregroundColor(Color("ColorGreenAdaptive"))
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
