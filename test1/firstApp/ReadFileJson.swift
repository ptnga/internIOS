import Foundation

class ReadFileJson {
    func readJsonFile(named name: String, ofType type: String) -> [String: Any]? {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            
            if let dictionary = jsonObject as? [String: Any] {
                return dictionary
            } else {
                return nil
            }
        } catch {
            print("Error reading JSON file: \(error)")
            return nil
        }
    }
}
