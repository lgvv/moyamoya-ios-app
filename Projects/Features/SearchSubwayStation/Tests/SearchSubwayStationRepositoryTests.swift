import XCTest
import Combine
import Entity
@testable import SearchSubwayStationFeature

final class SearchSubwayStationRepositoryTests: XCTestCase {
    
    var sut: SearchSubwayStationRepository?
    
    override func setUp() {
        super.setUp()
        
        sut = SearchSubwayStationRepositoryImpl(apiClient: .init())
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func test_api통신_잘_되는지_확인() {
        let expectation = XCTestExpectation(description: "API 호출이 완료되어야 합니다.")
        
        let query = SearchSubwayStationQuery(searchText: "강남")
        
        // when
        let response = sut!.searchSubwayStations(query: query)
        var cancellables = Set<AnyCancellable>()
        
        response.sink { completion in
            switch completion {
            case .finished:
                break
            case let .failure(error):
                XCTFail("API 호출 실패: \(error.localizedDescription)")
            }
            expectation.fulfill()
            
        } receiveValue: { subwayInfos in
            // 예상되는 데이터
            let expectedData: [SubwayInfo] = [
                .init(name: "강남", lines: ["2", "sinbundang"]),
                .init(name: "강남구청", lines: ["7", "bundang"]),
                .init(name: "강남대", lines: ["7", "ever"])
            ]
            
            // 반환된 데이터가 예상 데이터와 일치하는지 확인
            XCTAssertEqual(subwayInfos.count,
                           expectedData.count,
                           "반환된 데이터 수가 예상과 일치해야 함.")
            
            // 반환된 데이터가 예상 데이터에 포함되는지 확인
            for info in subwayInfos {
                XCTAssertTrue(expectedData.contains(where: { $0.name == info.name }),
                              "예상된 데이터에 포함되어야 함: \(info.name)")
            }
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }

    func test_api통신_실패시_올바른에러반환() {
        let expectation = XCTestExpectation(description: "API 호출 실패 시 올바른 에러를 반환해야 합니다.")
        
        // 이 부분은 Stub을 사용하여 의도적으로 실패하는 경우를 설정해야 합니다.
        // 예: sut!.configureResult(success: nil, failure: .someError)
        
        let query = SearchSubwayStationQuery(searchText: "존재하지 않는 역")
        
        // when
        let response = sut!.searchSubwayStations(query: query)
        var cancellables = Set<AnyCancellable>()
        
        response.sink { completion in
            switch completion {
            case .finished:
                XCTFail("성공적으로 완료되면 안 된다.")
            case let .failure(error):
                XCTAssertNotNil(error, "에러가 반환되어야 함.")
            }
            expectation.fulfill()
            
        } receiveValue: { _ in
            XCTFail("리턴 값이 없어야 함.")
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }

}

