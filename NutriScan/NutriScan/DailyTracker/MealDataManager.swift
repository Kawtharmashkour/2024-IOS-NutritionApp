import FirebaseFirestore

struct MealDataManager {
    static func fetchMealData(userId: String, date: String, mealType: String, completion: @escaping ([MealData]) -> Void) {
        let db = Firestore.firestore()

        db.collection("users").document(userId).collection("meals")
            .whereField("date", isEqualTo: date)
            .whereField("type", isEqualTo: mealType)
            .getDocuments { (querySnapshot, error) in
                var meals: [MealData] = []

                if let documents = querySnapshot?.documents {
                    print("Documents found: \(documents.count)")
                    for document in documents {
                        let data = document.data()
                        print("Document data: \(data)")
                        let meal = MealData(
                            carbs: data["carbs"] as? Double ?? 0,
                            fats: data["fats"] as? Double ?? 0,
                            proteins: data["proteins"] as? Double ?? 0,
                            calories: data["calories"] as? Double ?? 0,
                            name: data["name"] as? String ?? "",
                            image: data["image"] as? String ?? ""
                        )
                        meals.append(meal)
                    }
                }else {
                    print("No documents found or error: \(error?.localizedDescription ?? "Unknown error")")
                }

                completion(meals)
            }
    }
    static func insertMealData(userId: String, date: String, mealType: String, mealData: MealData) {
          let db = Firestore.firestore()
          let mealDocument = db.collection("users").document(userId).collection("meals").document()

          mealDocument.setData([
              "date": date,
              "type": mealType,
              "carbs": mealData.carbs,
              "fats": mealData.fats,
              "proteins": mealData.proteins,
              "calories": mealData.calories,
              "name": mealData.name,
              "image": mealData.image
          ]) { error in
              if let error = error {
                  print("Error adding meal: \(error)")
              } else {
                  print("Meal added successfully")
              }
          }
      }
  }

struct MealData {
    let id = UUID() 
    var carbs: Double
    var fats: Double
    var proteins: Double
    var calories: Double
    var name: String
    var image: String
}
