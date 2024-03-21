import SwiftUI
import Charts

struct NutritionalGraphView: View {
    var nutrientData: [NutrientData] = [
        .init(type: "Calories", total: 2200, intake: 653),
        .init(type: "Protein", total: 70, intake: 47.77),
        .init(type: "Carbs", total: 383, intake: 90.34),
        .init(type: "Fat", total: 90, intake: 25.79)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            let chartWidth = geometry.size.width / 2
            
            HStack {
                ZStack {
                    ForEach(Array(nutrientData.enumerated()), id: \.element.type) { (index, nutrient) in
                        Chart {
                            SectorMark(angle: .value("Intake", nutrient.intakeRatio), innerRadius: .ratio(0.9 - CGFloat(index) * 0.1))
                                .foregroundStyle(color(for: nutrient.type))
                            SectorMark(angle: .value("Remaining", 1 - nutrient.intakeRatio), innerRadius: .ratio(0.9 - CGFloat(index) * 0.1))
                                .foregroundStyle(.gray)
                        }
                        .chartLegend(.hidden)
                        .frame(width: chartWidth - CGFloat(index) * 30, height: chartWidth - CGFloat(index) * 30)
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
                }
            }
        }
    }
    
    private func color(for nutrientType: String) -> Color {
        switch nutrientType {
        case "Calories":
            return .blue
        case "Protein":
            return .green
        case "Carbs":
            return .orange
        case "Fat":
            return .red
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

struct NutritionalGraphView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionalGraphView()
    }
}
