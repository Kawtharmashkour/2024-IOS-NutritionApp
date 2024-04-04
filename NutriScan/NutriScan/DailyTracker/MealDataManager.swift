import FirebaseFirestore

struct MealDataManager {
    static func fetchMealData(userId: String, date: String, mealTypes: [String], completion: @escaping ([MealData]) -> Void) {
        let db = Firestore.firestore()

        db.collection("users").document(userId).collection("meals")
            .whereField("date", isEqualTo: date)
            .getDocuments { (querySnapshot, error) in
                var meals: [MealData] = []

                if let documents = querySnapshot?.documents {
                    for document in documents {
                        let data = document.data()
                        let mealTypeArray = data["type"] as? [String] ?? []

                        if mealTypes.contains(where: mealTypeArray.contains) {
                            let meal = MealData(
                                id: document.documentID,
                                carbs: data["carbs"] as? Double ?? 0,
                                fats: data["fats"] as? Double ?? 0,
                                proteins: data["proteins"] as? Double ?? 0,
                                calories: data["calories"] as? Double ?? 0,
                                name: data["name"] as? String ?? "",
                                type: mealTypeArray.joined(separator: ", ")
                            )
                            meals.append(meal)
                            print("Meal type: \(meal.type)")  // Add this line to log the meal type
                        }
                    }
                }

                completion(meals)
            }
    }
    
    static func insertMealDataScan(userId: String, mealData: MealData) {
        let db = Firestore.firestore()
        let mealDocument = db.collection("users").document(userId).collection("meals").document(mealData.id ?? UUID().uuidString)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let formattedDate = dateFormatter.string(from: Date())
        
        mealDocument.setData([
            "date": formattedDate,
            "type": mealData.type,
            "carbs": mealData.carbs,
            "fats": mealData.fats,
            "proteins": mealData.proteins,
            "calories": mealData.calories,
            "name": mealData.name
        ]) { error in
            if let error = error {
                print("Error adding meal: \(error)")
            } else {
                print("Meal added successfully")
            }
        }
    }

    static func insertMealData(userId: String , mealData: RecipeViewModel) {
        print("Inserting meal data for user: \(userId), date: \(Date()), mealData: \(mealData)")
            let db = Firestore.firestore()
            let mealDocument = db.collection("users").document(userId).collection("meals").document()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let formattedDate = dateFormatter.string(from: Date())
        
          mealDocument.setData([
              "date": formattedDate,
              "type": mealData.mealType,
              "carbs": mealData.totalNutrients.CHOCDF.quantity,
              "fats": mealData.totalNutrients.FAT.quantity,
              "proteins": mealData.totalNutrients.PROCNT.quantity,
              "calories": mealData.totalNutrients.ENERC_KCAL.quantity,
              "name": mealData.title
          ]) { error in
              if let error = error {
                  print("Error adding meal: \(error)")
              } else {
                  print("Meal added successfully")
              }
          }
      }
    
    static func deleteMealData(userId: String, mealId: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        print("Deleting meal data for user: \(userId), mealId: \(mealId)")
        db.collection("users").document(userId).collection("meals").document(mealId).delete { error in
            if let error = error {
                print("Error deleting meal: \(error)")
                completion(false)
            } else {
                print("Meal deleted successfully")
                completion(true)
            }
        }
    }
    
  }

struct MealData {
    let id: String?
    var carbs: Double
    var fats: Double
    var proteins: Double
    var calories: Double
    var name: String
    var type: String
}
