import UIKit

enum UserDeafultsSaveObkect {
    case saveString(String, key: String = "saveString")

    var key: String {
        switch self {
        case.saveString:
            return "saveString"
        }
    }

}

enum UserDeafaultsKey: String {
    case simpleKey
}

extension UserDefaults {

    func savePersons(persons: [ToDoItem]) {
        let encoder = JSONEncoder()

        if let encoderdData = try? encoder.encode(persons) {
            UserDefaults.standard.set(encoderdData, forKey: "personKey")
        } else {
            debugPrint("error")
        }


    }

    func getPersons() -> [Person] {
        if let personData =  UserDefaults.standard.object(forKey: "personKey") as? Data {
            let decoder = JSONDecoder()
            let decodingResult = try? decoder.decode([Person].self, from: personData)
            return decodingResult ?? []
        } else {
            debugPrint("error")
            return []

        }
    }
