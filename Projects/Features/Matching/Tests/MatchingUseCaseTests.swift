import XCTest
import Entity
import Combine
@testable import MatchingFeature

final class DefaultMatchingUseCaseTests: XCTestCase {
    
    private var sut: DefaultMatchingUseCase!
    private var mockRepository: MockMatchingRepository!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        // Mock repository 인스턴스 생성
        mockRepository = MockMatchingRepository()
        // DefaultMatchingUseCase 인스턴스 생성
        sut = DefaultMatchingUseCase(repository: mockRepository)
    }

    override func tearDown() {
        cancellables.removeAll()
        sut = nil
        mockRepository = nil
        
        super.tearDown()
    }
    
    func test_캐싱로직이_제대로_동작하는지_검증() async {
        // given: 캐시에 없는 쿼리로 시작
        let query = MatchingUserQuery(
            requestId: "65bf251debe5db753688ba02",
            targetUserCode: "G36K"
        )
        
        let repositoryMatchingInfo = MatchingInfo(
            profile: .init(
                name: "First Fetch",
                major: "Computer Science",
                clubs: ["Nexters"],
                mbti: "INTJ",
                bloodType: "O",
                subwayInfos: []
            ),
            similarity: 95,
            chemistryInfos: [],
            recommendInfos: []
        )
        
        // 레포지토리에서 처음 반환될 값 설정
        mockRepository.matchingUserResult = .success(repositoryMatchingInfo)
        
        // when: 첫 번째 실행 (레포지토리에서 데이터를 가져와야 함)
        let firstResult = await sut.load(query: query)
        
        // then: 첫 번째 실행 결과가 레포지토리에서 가져온 값과 동일해야 함
        switch firstResult {
        case .success(let matchingInfo):
            XCTAssertEqual(matchingInfo, repositoryMatchingInfo)
        case .failure:
            XCTFail("Expected success, but got failure")
        }
        
        // 레포지토리에서 데이터를 다시 가져오지 않도록 새로운 데이터를 설정 (캐시 테스트)
        let newRepositoryMatchingInfo = MatchingInfo(
            profile: .init(
                name: "Second Fetch",
                major: "Physics",
                clubs: ["Club B"],
                mbti: "ENTP",
                bloodType: "A",
                subwayInfos: []
            ),
            similarity: 80,
            chemistryInfos: [],
            recommendInfos: []
        )
        
        mockRepository.matchingUserResult = .success(newRepositoryMatchingInfo)

        // when: 두 번째 실행 (캐시에서 데이터를 가져와야 함, 레포지토리 호출 없이)
        let secondResult = await sut.load(query: query)
        
        // then: 두 번째 실행 결과가 첫 번째 캐시된 값과 동일해야 함
        switch secondResult {
        case .success(let matchingInfo):
            XCTAssertEqual(matchingInfo, repositoryMatchingInfo) // 캐시된 값을 반환
        case .failure:
            XCTFail("Expected success, but got failure")
        }
        
        // verify: 두 번째 호출 시 레포지토리가 아닌 캐시에서 값을 가져왔는지 확인
        XCTAssertNotEqual(try secondResult.get(), newRepositoryMatchingInfo)
    }
    
    func test_refresh할때_캐시가_비워지고_새로운_데이터가_불러와지는지_테스트() async {
        // Given
        let query = MatchingUserQuery(
            requestId: "65bf251debe5db753688ba02",
            targetUserCode: "G36K"
        )
        
        let matchingInfoBeforeRefresh = MatchingInfo(
            profile: MatchingInfo.MatchProfile(
                name: "Old User",
                major: "Mathematics",
                clubs: ["Chess Club"],
                mbti: "ENTP",
                bloodType: "O",
                subwayInfos: []
            ),
            similarity: 75,
            chemistryInfos: [],
            recommendInfos: []
        )
        
        let matchingInfoAfterRefresh = MatchingInfo(
            profile: MatchingInfo.MatchProfile(
                name: "New User",
                major: "Physics",
                clubs: ["Drama Club"],
                mbti: "INFP",
                bloodType: "B",
                subwayInfos: []
            ),
            similarity: 85,
            chemistryInfos: [],
            recommendInfos: []
        )
        
        // 캐시에 먼저 저장할 데이터를 설정 (이전 데이터)
        mockRepository.matchingUserResult = .success(matchingInfoBeforeRefresh)
        _ = await sut.refresh(query: query) // load 호출로 캐시를 채움
        
        // 캐시에 값이 들어있는지 확인
        let cachedValueBeforeRefresh = await sut.cache[query]
        XCTAssertEqual(cachedValueBeforeRefresh, matchingInfoBeforeRefresh, "캐시에는 이전 데이터가 있어야 합니다.")
        
        // 캐시 비우기 및 새로운 데이터 불러오기
        // 새로운 데이터로 repository 값을 설정 (새로운 데이터)
        mockRepository.matchingUserResult = .success(matchingInfoAfterRefresh)
        
        // When
        let refreshResult = await sut.refresh(query: query)
        
        // 캐시가 비워졌고, 새로운 데이터가 불러와졌는지 확인
        let cachedValueAfterRefresh = await sut.cache[query]
        
        // Then
        switch refreshResult {
        case .success(let newMatchingInfo):
            XCTAssertEqual(newMatchingInfo, matchingInfoAfterRefresh, "새로운 데이터를 성공적으로 불러와야 합니다.")
            XCTAssertEqual(cachedValueAfterRefresh, matchingInfoAfterRefresh, "캐시에 새로운 데이터가 있어야 합니다.")
        case .failure:
            XCTFail("refresh가 실패했습니다.")
        }
    }
}


extension DefaultMatchingUseCaseTests {
    class MockMatchingRepository: MatchingRepository {
        
        /// 저장된 테스트 결과 (옵셔널)
        var matchingUserResult: Result<MatchingInfo, RepositoryError>?
        
        /// async-await 방식으로 결과 반환
        func matchingUser(query: MatchingUserQuery) async -> Result<MatchingInfo, RepositoryError> {
            return matchingUserResult ?? .failure(.message("No data"))
        }
        
        /// Combine 방식으로 결과 반환
        func matchingUser(query: MatchingUserQuery) -> AnyPublisher<MatchingInfo, RepositoryError> {
            if let result = matchingUserResult {
                return Future { promise in
                    promise(result)
                }
                .eraseToAnyPublisher()
            } else {
                return Fail(error: RepositoryError.message("No data")).eraseToAnyPublisher()
            }
        }
    }
}
