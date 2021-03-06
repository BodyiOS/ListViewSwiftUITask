import Foundation
import Combine

protocol RepositoriesListService {
    var apiSession: APIService {get}
    
    func getRepositoriesList() ->AnyPublisher<[RepositoriesListItem],ApiErorr>
    func getRepositoriesDataNeeded(url:String) ->AnyPublisher<OwnerCharacter,ApiErorr>
    func searchRepositoriesList(searchText:String) ->AnyPublisher<RepositoriesSearchListItem,ApiErorr>
    
}

extension RepositoriesListService {
    
    func getRepositoriesList() ->AnyPublisher<[RepositoriesListItem],ApiErorr> {
        return apiSession.request(with: RepositoriesEndPoints.repositoriesList)
            .eraseToAnyPublisher()
    }
    
    func getRepositoriesDataNeeded(url:String) -> AnyPublisher<OwnerCharacter,ApiErorr> {
        return apiSession.request(with: RepositoriesEndPoints.repositoriesOwnerUrl(url))
        .eraseToAnyPublisher()
    }
    
    func searchRepositoriesList(searchText:String) -> AnyPublisher<RepositoriesSearchListItem,ApiErorr> {
        return apiSession.request(with: RepositoriesEndPoints.searchRepositoriesList(searchText))
        .eraseToAnyPublisher()
    }
    
}
