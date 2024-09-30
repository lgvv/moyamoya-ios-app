import Entity
import Combine

public protocol ProfileRepository {
    func fetchProfile() -> AnyPublisher<Profile, RepositoryError>
    func fetchProfile(query: FetchUserQuery) -> AnyPublisher<Profile, RepositoryError>
    func createProfile(query: CreateUserQuery) -> AnyPublisher<Profile, RepositoryError>
    func deleteProfile(query: DeleteProfileQuery) -> AnyPublisher<String, RepositoryError>
}
