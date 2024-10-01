import Entity
import SwiftUI
import Combine
import FunchCore
import FunchNetworking

public final class SearchSubwayStationRepositoryImpl: SearchSubwayStationRepository {
    
    private let apiClient: APIClient
    
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    /// `지하철역` 검색
    public func searchSubwayStations(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], SubwayStationRepositoryError> {
        let requestDTO = RequestDTO.SearchSubwayStation(query: query)
        return Future { [weak self] promise in
            guard let self else { return }
            self.apiClient.request(
                ResponseDTO.SearchSubwayStation.self,
                target: .searchSubwayStations(parameters: requestDTO.toDitionary)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
                    promise(.success([]))
                }
            }
        }.eraseToAnyPublisher()
    }
}
