import SwiftUI
import Combine
import FunchNetworking
import Entity

public final class MatchingRepositoryImpl: MatchingRepository {
    
    private let apiClient: APIClient
    
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    public func matchingUser(query: MatchingUserQuery) -> AnyPublisher<MatchingInfo, RepositoryError> {
        return Future { [weak self] promise in
            guard let self else { return }
            let requestDTO = RequestDTO.MatchingUser(query: query)
            self.apiClient.request(
                ResponseDTO.MatchingUser.self,
                target: .matchingUser(parameters: requestDTO.toDitionary)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
                    promise(.failure(.message("프로필 조회에 실패했어요.")))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func matchingUser(query: MatchingUserQuery) async -> Result<MatchingInfo, RepositoryError> {
        let requestDTO = RequestDTO.MatchingUser(query: query)
        
        // APIClient의 비동기 요청 메서드를 사용해야 함
        let result: Result<ResponseDTO.MatchingUser, RepositoryError> = await withCheckedContinuation { continuation in
            apiClient.request(
                ResponseDTO.MatchingUser.self,
                target: .matchingUser(parameters: requestDTO.toDitionary)
            ) { result in
                switch result {
                case .success(let success):
                    continuation.resume(returning: .success(success))
                case .failure(_):
                    continuation.resume(returning: .failure(.message("프로필 조회에 실패했어요.")))
                }
            }
        }
        
        switch result {
        case .success(let responseDTO):
            return .success(responseDTO.toDomain())
        case .failure(let error):
            return .failure(error)
        }
    }
}
