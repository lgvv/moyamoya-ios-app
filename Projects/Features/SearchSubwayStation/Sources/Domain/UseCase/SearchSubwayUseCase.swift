import Entity
import Combine
import Foundation

public protocol SearchSubwayUseCase {
    func execute(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], SubwayStationRepositoryError>
}

public final class DefaultSearchSubwayUseCase: SearchSubwayUseCase {
    private let repository: SearchSubwayStationRepository
    
    typealias Key = SearchSubwayStationQuery
    typealias Value = [SubwayInfo]
    
    private(set) var cache: [Key: Value] = [:]
    
    public init(repository: SearchSubwayStationRepository) {
        self.repository = repository
    }
    
    public func execute(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], SubwayStationRepositoryError> {
        // 캐시에 값이 있는지 확인
        if let cachedData = cache[query] {
            // 캐시된 값을 바로 반환
            return Just(cachedData)
                .setFailureType(to: SubwayStationRepositoryError.self)
                .eraseToAnyPublisher()
        } else {
            return repository.searchSubwayStations(query: query)
                .handleEvents(receiveOutput: { [weak self] result in
                    guard let self else { return }
                    // 성공적으로 데이터를 가져오면 캐시에 저장
                    self.cache[query] = result
                })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}
