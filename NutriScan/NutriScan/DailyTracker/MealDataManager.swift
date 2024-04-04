import FirebaseFirestore

struct MealDataManager {
    static func fetchMealData(userId: String, date: String, mealType: String, completion: @escaping ([MealData]) -> Void) {
        let db = Firestore.firestore()

        db.collection("users").document(userId).collection("meals")
            .whereField("date", isEqualTo: date)
            .whereField("type", isEqualTo: mealType) // Query for the specific meal type
            .getDocuments { (querySnapshot, error) in
                var meals: [MealData] = []

                if let documents = querySnapshot?.documents {
                    for document in documents {
                        let data = document.data()
                        let meal = MealData(
                            id: document.documentID,
                            carbs: data["carbs"] as? Double ?? 0,
                            fats: data["fats"] as? Double ?? 0,
                            proteins: data["proteins"] as? Double ?? 0,
                            calories: data["calories"] as? Double ?? 0,
                            name: data["name"] as? String ?? "",
                            type: data["type"] as? String ?? ""
                        )
                        meals.append(meal)
                    }
                }

                completion(meals)
            }
    }

    
    static func insertMealData(userId: String , mealData: RecipeViewModel, mealType: String) {
        print("Inserting meal data for user: \(userId), date: \(Date()), mealData: \(mealData), mealType: \(mealType)")
        let db = Firestore.firestore()
        let mealDocument = db.collection("users").document(userId).collection("meals").document()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let formattedDate = dateFormatter.string(from: Date())


        mealDocument.setData([
            "date": formattedDate,
            "type": mealType,
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


//    static func insertMealData(userId: String , mealData: RecipeViewModel) {
//        print("Inserting meal data for user: \(userId), date: \(Date()), mealData: \(mealData)")
//            let db = Firestore.firestore()
//            let mealDocument = db.collection("users").document(userId).collection("meals").document()
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyyMMdd"
//            let formattedDate = dateFormatter.string(from: Date())
//
//          mealDocument.setData([
//              "date": formattedDate,
//              "type": mealData.mealType,
//              "carbs": mealData.totalNutrients.CHOCDF.quantity,
//              "fats": mealData.totalNutrients.FAT.quantity,
//              "proteins": mealData.totalNutrients.PROCNT.quantity,
//              "calories": mealData.totalNutrients.ENERC_KCAL.quantity,
//              "name": mealData.title
//          ]) { error in
//              if let error = error {
//                  print("Error adding meal: \(error)")
//              } else {
//                  print("Meal added successfully")
//              }
//          }
//      }
    
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
