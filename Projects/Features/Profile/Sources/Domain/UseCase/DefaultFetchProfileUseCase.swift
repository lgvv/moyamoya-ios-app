import Entity
import Combine
import Foundation

public protocol FetchProfileUseCase {
    func fetchProfileFromDeviceId() -> AnyPublisher<Profile, RepositoryError>
    func fetchProfileFromId(query: FetchUserQuery) -> AnyPublisher<Profile, RepositoryError>
}

public final class DefaultFetchProfileUseCase: FetchProfileUseCase {
    private let repository: ProfileRepository
    
    public init(repository: ProfileRepository) {
        self.repository = repository
    }
    
    /// 디바이스 기반으로 id 조회
    public func fetchProfileFromDeviceId() -> AnyPublisher<Profile, RepositoryError> {
        repository.fetchProfile()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// 프로필 아이디 기반으로 조회
    public func fetchProfileFromId(query: FetchUserQuery) -> AnyPublisher<Profile, RepositoryError> {
        repository.fetchProfile(query: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
