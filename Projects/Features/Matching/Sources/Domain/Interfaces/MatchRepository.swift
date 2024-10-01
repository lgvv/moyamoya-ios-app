import Entity
import Combine

public protocol MatchingRepository {
    func matchingUser(query: MatchingUserQuery) -> AnyPublisher<MatchingInfo, RepositoryError>
    func matchingUser(query: MatchingUserQuery) async -> Result<MatchingInfo, RepositoryError>
}
