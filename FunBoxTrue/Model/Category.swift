import Foundation
  
struct Category : Codable {
    var id: String
    var name: String
    var cost : String
    var lost : String
    init(dictionary: Dictionary<String, Any>) {
        
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        cost = dictionary["cost"] as? String ?? ""
        lost = dictionary["lost"] as? String ?? ""
        
    }

}




