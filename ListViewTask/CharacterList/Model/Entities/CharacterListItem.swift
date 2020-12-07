import Foundation

struct CharacterListItem: Codable,Identifiable {
    
   // let id = UUID()
    let id: Int
    let name: String
    let fullName: String
    let url: String
    //let description:String
    let owner:OwnerCharacter
    
}