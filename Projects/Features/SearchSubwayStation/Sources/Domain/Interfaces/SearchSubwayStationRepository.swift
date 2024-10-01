import Entity
import Combine

public protocol SearchSubwayStationRepository {
    func searchSubwayStations(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], SubwayStationRepositoryError>
}
