import Entity
import Combine
import SwiftUI

public protocol MatchingUseCase {
    func execute(query: MatchingUserQuery) async -> AnyPublisher<MatchingInfo, RepositoryError>
    
    func load(query: MatchingUserQuery) async -> Result<MatchingInfo, RepositoryError>
    func refresh(query: MatchingUserQuery) async -> Result<MatchingInfo, RepositoryError>
}

public final actor DefaultMatchingUseCase: MatchingUseCase {
    private let repository: MatchingRepository
    
    /// 매칭 상대의 쿼리
    typealias Key = MatchingUserQuery
    /// 매칭 값
    typealias Value = MatchingInfo
    
    private(set) var cache: [Key: Value] = [:]
    
    public init(repository: MatchingRepository) {
        self.repository = repository
    }
    
    public func execute(query: MatchingUserQuery) -> AnyPublisher<MatchingInfo, RepositoryError> {
        return Future { promise in
            Task {
                let result = await self.load(query: query)
                switch result {
                case .success(let matchingInfo):
                    promise(.success(matchingInfo))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func load(query: MatchingUserQuery) async -> Result<MatchingInfo, RepositoryError> {
        // 쿼리가 캐시에 있는지 확인
        if let cachedData = cache[query] {
            // 캐시된 값을 반환
            return .success(cachedData)
        } else {
            // 캐시가 없으면 레포지토리에서 가져오기
            let result = await repository.matchingUser(query: query)
            switch result {
            case .success(let matchingInfo):
                // 결과를 캐시에 저장
                cache[query] = matchingInfo
                return .success(matchingInfo)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    public func refresh(query: MatchingUserQuery) async -> Result<MatchingInfo, RepositoryError> {
        cache = [:]
        
        return await load(query: query)
    }
}
