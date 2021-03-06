import Foundation

struct RepositoriesListDetailsItem: Codable,Identifiable {
    
    let id: Int
    let name: String
    let fullName: String
    let owner:OwnerCharacter
    let createdAt:String
    
}
