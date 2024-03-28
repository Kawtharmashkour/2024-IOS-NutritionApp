import FirebaseFirestore

struct MealDataManager {
    static func fetchMealData(userId: String, date: String, mealType: String, completion: @escaping ([MealData]) -> Void) {
        print("Fetching meal data for user: \(userId), date: \(date), mealType: \(mealType)")
        let db = Firestore.firestore()

        db.collection("users").document(userId).collection("meals")
            .whereField("type", isEqualTo: mealType.lowercased())
            .getDocuments { (querySnapshot, error) in
                var meals: [MealData] = []

                if let documents = querySnapshot?.documents {
                    print("Documents found: \(documents.count)")
                    for document in documents {
                        let data = document.data()
                        print("Document data: \(data)")
                        let meal = MealData(
                            id: document.documentID,
                            carbs: data["carbs"] as? Double ?? 0,
                            fats: data["fats"] as? Double ?? 0,
                            proteins: data["proteins"] as? Double ?? 0,
                            calories: data["calories"] as? Double ?? 0,
                            name: data["name"] as? String ?? ""
                        )
                        meals.append(meal)
                    }
                }else {
                    print("No documents found or error: \(error?.localizedDescription ?? "Unknown error")")
                }

                completion(meals)
                print("Completion handler called with meals: \(meals)")
            }
    }
    static func insertMealData(userId: String, mealType: String, mealData: RecipeViewModel) {
        print("Inserting meal data for user: \(userId), date: \(Date()), mealType: \(mealType), mealData: \(mealData)")
          let db = Firestore.firestore()
          let mealDocument = db.collection("users").document(userId).collection("meals").document()

          mealDocument.setData([
              "date": "\(Date())",
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
}
