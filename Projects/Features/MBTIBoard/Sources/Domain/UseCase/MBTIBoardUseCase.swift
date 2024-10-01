import Combine
import Foundation

public protocol MBTIBoardUseCase {
    func count(mbti: String) -> Int
    func save(mbti: String)
}

public final class DefaultMBTIBoardUseCase: MBTIBoardUseCase {
    private let repository: MBTIRepository
    
    public init(repository: MBTIRepository) {
        self.repository = repository
    }
    
    /// 입력 mbti와 매치 수 반환
    public func count(mbti: String) -> Int {
        repository.count(mbti: mbti)
    }
    
    /// 입력 mbti와 매치한 기록을 저장
    public func save(mbti: String) {
        repository.save(mbti: mbti)
    }
}
