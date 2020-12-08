import Foundation
import Combine


class CharacterListDetailsViewModel:ObservableObject,CharacterListService {
    var apiSession: APIService
    
    let itemOwner : OwnerCharacter
    
   private var cancellables = Set<AnyCancellable>()
       
    let id:Int
    
    @Published var item: CharacterListItem2?
    
    @Published var dateString: String?
    
    init(itemOwner : OwnerCharacter,id:Int,apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        self.itemOwner = itemOwner
        self.id = id
    }
    
    func getCharacterListDetails() {
        
        let cancellable = self.getCharacterListDetails(id: "\(id)").sink(receiveCompletion: { result in
            switch result {
            case .failure(let error):
                print("Handle erroe:\(error)")
            case .finished:
                break
            }
        }) { item in
            self.item = item
            self.dateString = self.convertDateFormat(inputDate: item.createdAt)
        }
        self.cancellables.insert(cancellable)
    }
    
    private func convertDateFormat(inputDate: String) -> String? {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:'Z'"

        let oldDate = olDateFormatter.date(from: inputDate) ?? Date()

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MM/dd/yyyy"

         return convertDateFormatter.string(from: oldDate)
    }
}