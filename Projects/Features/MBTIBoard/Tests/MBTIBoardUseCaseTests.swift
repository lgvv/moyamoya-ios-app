import XCTest
import Entity
@testable import MBTIBoardFeature

final class DefaultMBTIBoardUseCaseTests: XCTestCase {
    
    var mockRepository: MockMBTIRepository!
    var useCase: DefaultMBTIBoardUseCase!
    
    override func setUp() {
        super.setUp()
        
        mockRepository = MockMBTIRepository()
        useCase = DefaultMBTIBoardUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        super.tearDown()
        
        mockRepository = nil
        useCase = nil
    }
    
    func test_저장된_mbti_카운트가_증가하는지_테스트() {
        // Given
        let mbti = "INTJ"
        mockRepository.mbtiCounts = [mbti: 5]
        
        // When
        let count = useCase.count(mbti: mbti)
        
        // Then
        XCTAssertTrue(mockRepository.countCalled, "count 메서드가 호출되어야 함.")
        XCTAssertEqual(count, 5, "count 메서드는 5를 반환해야 함.")
    }
    
    func test_새로운_mbti가_저장되는지_테스트() {
        // Given
        let mbti = "INTP"
        
        // When
        useCase.save(mbti: mbti)
        
        // Then
        XCTAssertTrue(mockRepository.saveCalled, "save 메서드가 호출되어야 함.")
        XCTAssertEqual(mockRepository.savedMBTI, mbti, "저장된 MBTI는 \(mbti)여야 함.")
        XCTAssertEqual(mockRepository.mbtiCounts[mbti], 1, "MBTI 카운트는 1이어야 함.")
    }
    
    func test_mbti_카운트를_올바르게_반환하는지_테스트() {
        // Given
        let mbti = "ENFP"
        mockRepository.mbtiCounts = [mbti: 2]
        
        // When
        useCase.save(mbti: mbti)
        
        // Then
        XCTAssertTrue(mockRepository.saveCalled, "save 메서드가 호출되어야 함.")
        XCTAssertEqual(mockRepository.savedMBTI, mbti, "저장된 MBTI는 \(mbti)여야 함.")
        XCTAssertEqual(mockRepository.mbtiCounts[mbti], 3, "MBTI 카운트는 3이어야 함.")
    }
}

extension DefaultMBTIBoardUseCaseTests {
    // Mock MBTIRepository
    class MockMBTIRepository: MBTIRepository {
        var countCalled = false
        var saveCalled = false
        var savedMBTI: String?
        var mbtiCounts: [String: Int] = [:]
        
        func count(mbti: String) -> Int {
            countCalled = true
            return mbtiCounts[mbti] ?? 0
        }
        
        func save(mbti: String) {
            saveCalled = true
            savedMBTI = mbti
            mbtiCounts[mbti] = (mbtiCounts[mbti] ?? 0) + 1
        }
    }
}
