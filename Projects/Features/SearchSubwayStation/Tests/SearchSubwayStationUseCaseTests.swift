import XCTest
import Entity
import Combine
@testable import SearchSubwayStationFeature

final class SearchSubwayStationUseCaseTests: XCTestCase {
    
    let repository = StubSearchSubwayStationRepository()
    var sut: SearchSubwayUseCase?
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        repository.initialize()
        
        sut = DefaultSearchSubwayUseCase(
            repository: repository
        )
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        cancellables.removeAll()
    }

    func test_캐싱로직이_제대로_동작하는지_검증() {
        // given
        let query: SearchSubwayStationQuery = .init(searchText: "강남")
        let expectedData: [SubwayInfo] = [.init(name: "강남역", lines: ["1"])]
        // Stub에 성공 결과 설정
        repository.configureResult(success: expectedData, failure: nil)
        
        // when
        var firstResult: [SubwayInfo] = []
        var secondResult: [SubwayInfo] = []
        
        // 첫 번째 검색 실행 (캐시에 없으므로 repository에서 데이터를 가져옴)
        let firstSearchExpectation = expectation(description: "첫번째 검색 성공")
        sut?.execute(query: query)
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                firstResult = result
                firstSearchExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [firstSearchExpectation], timeout: 2.0)
        
        // Stub의 호출 여부를 확인 (repository가 호출되었어야 함)
        XCTAssertTrue(repository.searchCalled, "첫 요청에서 Repository가 호출되었음.")
        
        // 캐시 확인 (첫 번째 결과가 캐시에 저장되어야 함)
        guard let useCase = sut as? DefaultSearchSubwayUseCase else {
            XCTFail("DefaultSearchSubwayUseCase 타입 캐스팅 실패")
            return
        }
        XCTAssertEqual(useCase.cache[query], expectedData, "Repository는 캐싱으로 인해 한 번만 호출.")
        
        // 두 번째 검색 실행 (캐시에 데이터가 있으므로 repository가 호출되지 않음)
        let secondSearchExpectation = expectation(description: "두번쨰 검색 호출")
        sut?.execute(query: query)
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                secondResult = result
                secondSearchExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [secondSearchExpectation], timeout: 1.0)
        
        // repository가 다시 호출되지 않았는지 확인
        XCTAssertEqual(repository.searchCallCount, 1, "Repository는 캐싱으로 인해 한 번만 호출 되어야 함.")

        // 검증
        XCTAssertEqual(firstResult, expectedData, "첫 번째 검색은 예상된 데이터를 반환해야 함.")
        XCTAssertEqual(secondResult, expectedData, "두 번째 검색은 캐시된 데이터를 반환해야 함.")
    }
}

extension SearchSubwayStationUseCaseTests {
    class StubSearchSubwayStationRepository: SearchSubwayStationRepository {
        
        private var success: [SubwayInfo] = []
        private var failure: SubwayStationRepositoryError? = nil
        var searchCalled: Bool = false
        var searchCallCount: Int = 0
        
        func configureResult(
            success: [SubwayInfo],
            failure: SubwayStationRepositoryError?
        ) {
            self.success = success
            self.failure = failure
        }
        
        func initialize() {
            success = []
            failure = nil
            searchCalled = false
            searchCallCount = 0
        }
        
        func searchSubwayStations(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], SubwayStationRepositoryError> {
            searchCalled = true
            searchCallCount += 1
            
            if let error = failure {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            } else {
                return Just(success)
                    .setFailureType(to: SubwayStationRepositoryError.self)
                    .eraseToAnyPublisher()
            }
        }
    }
}
