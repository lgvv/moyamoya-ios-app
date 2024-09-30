import Combine
import Foundation

public protocol DeleteProfileUseCase {
    func execute(requestId: String) -> AnyPublisher<String, RepositoryError>
}

public final class DefaultDeleteProfileUseCase: DeleteProfileUseCase {
    
    private let repository: ProfileRepository
    
    public init(repository: ProfileRepository) {
        self.repository = repository
    }
    
    public func execute(requestId: String) -> AnyPublisher<String, RepositoryError> {
        let query = DeleteProfileQuery(profileId: requestId)
        return repository.deleteProfile(query: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

