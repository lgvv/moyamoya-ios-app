import Entity
import Combine
import Foundation

public protocol CreateProfileUseCase {
    func createProfile(query: CreateUserQuery)-> AnyPublisher<Profile, RepositoryError>
}

public final class DefaultCreateProfileUseCase: CreateProfileUseCase {
    private let repository: ProfileRepository
    
    public init(repository: ProfileRepository) {
        self.repository = repository
    }
    
    /// 본인 프로필 생성
    public func createProfile(query: CreateUserQuery)-> AnyPublisher<Profile, RepositoryError> {
        repository.createProfile(query: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
