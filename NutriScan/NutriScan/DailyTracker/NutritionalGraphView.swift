import SwiftUI
import Charts

struct NutritionalGraphView: View {
    var meals: [MealData]
    @AppStorage("calorieGoal") private var calorieGoal: Double = 1500
    @AppStorage("proteinGoal") private var proteinGoal: Double = 50
    @AppStorage("fatGoal") private var fatGoal: Double = 70
    @AppStorage("carbGoal") private var carbGoal: Double = 300

    var totalCalories: Double {
        meals.reduce(0) { $0 + $1.calories }
    }

    var totalProteins: Double {
        meals.reduce(0) { $0 + $1.proteins }
    }

    var totalCarbs: Double {
        meals.reduce(0) { $0 + $1.carbs }
    }

    var totalFats: Double {
        meals.reduce(0) { $0 + $1.fats }
    }

    var nutrientData: [NutrientData] {
        let data = [
            NutrientData(type: "Protein", total: proteinGoal, intake: totalProteins),
            NutrientData(type: "Carbs", total: carbGoal, intake: totalCarbs),
            NutrientData(type: "Fat", total: fatGoal, intake: totalFats),
            NutrientData(type: "Calories", total: calorieGoal, intake: totalCalories)
        ]
        return data.sorted { $0.type == "Calories" ? false : $1.type == "Calories" }
    }

    var body: some View {
        GeometryReader { geometry in
            let chartWidth = geometry.size.width / 2
            let maxScaleValue: Double = 3000 // Set a fixed scale up to 3000

            HStack {
                ZStack {
                    ForEach(Array(nutrientData.enumerated()), id: \.element.type) { (index, nutrient) in
                        Chart {
                            SectorMark(angle: .value("Intake", nutrient.intake), innerRadius: .ratio(0.9 - CGFloat(index) * 0.1))
                                .foregroundStyle(color(for: nutrient.type))
                            SectorMark(angle: .value("Remaining", maxScaleValue - nutrient.intake), innerRadius: .ratio(0.9 - CGFloat(index) * 0.1))
                                .foregroundStyle(Color("ColorGreenAdaptive"))
                        }
                        .chartLegend(.hidden)
                        .frame(width: chartWidth - CGFloat(index) * 30, height: chartWidth - CGFloat(index) * 30)
                        .chartXScale(domain: 0...maxScaleValue) // Set the domain to match the fixed scale
                    }
                }

                VStack {
                    Chart {
                        ForEach(nutrientData, id: \.type) { nutrient in
                            BarMark(
                                x: .value("Intake", nutrient.intake),
                                y: .value("Nutrient", nutrient.type)
                            )
                            .foregroundStyle(color(for: nutrient.type))
                        }
                    }
                    .frame(width: chartWidth, height: chartWidth)
                    .chartLegend(.hidden)
                    .chartXScale(domain: 0...maxScaleValue) // Set the x-axis range to match the fixed scale
                    .padding()
                }
            }
        }
    }

    private func color(for nutrientType: String) -> Color {
        switch nutrientType {
        case "Calories":
            return .red
        case "Protein":
            return .green
        case "Carbs":
            return .yellow
        case "Fat":
            return .blue
        default:
            return .pink
        }
    }
}

struct NutrientData {
    let type: String
    let total: Double
    let intake: Double

    var intakeRatio: Double {
        intake / total
    }
}
