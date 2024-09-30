//import XCTest
//import Combine
//import Entity
//@testable import MatchingFeature
//
//final class MatchingRepositoryTests: XCTestCase {
//    
//    var sut: MatchingRepository?
//    var cancellables: Set<AnyCancellable>!
//
//    override func setUp() {
//        super.setUp()
//        
//        sut = MatchingRepositoryImpl(apiClient: .init())
//        cancellables = Set<AnyCancellable>()
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//        
//        sut = nil
//        cancellables = nil
//    }
//
//    func test_api통신_성공() {
//        let expectation = XCTestExpectation(description: "API 호출이 완료되어야 합니다.")
//        
//        let testableRequestId = "65bf251debe5db753688ba02"
//        let testableTargetUserCode = "G36K"
//        
//        let query = MatchingUserQuery(
//            requestId: testableRequestId,
//            targetUserCode: testableTargetUserCode
//        )
//        
//        // when
//        let response = sut!.matchingUser(query: query)
//        
//        response.sink { completion in
//            switch completion {
//            case .finished:
//                break
//            case let .failure(error):
//                XCTFail("API 호출 실패: \(error.localizedDescription)")
//            }
//            expectation.fulfill()
//            
//        } receiveValue: { matchingInfo in
//            // 예상되는 데이터
//            let expectedMatchingInfo = MatchingInfo(
//                id: .init(),
//                profile: .init(
//                    name: "testable_name",
//                    major: "CS",
//                    clubs: ["Nexters"],
//                    mbti: "ISTP",
//                    bloodType: "O",
//                    subwayInfos: []
//                ),
//                similarity: 80,
//                chemistryInfos: [.init(title: "testable_title", description: "testable_description")],
//                recommendInfos: [.init(title: "testable_title")],
//                subwayChemistryInfo: .init(title: "testable_title", description: "testable_description")
//            )
//            
//            // 반환된 데이터가 예상 데이터와 일치하는지 확인
//            XCTAssertEqual(matchingInfo, expectedMatchingInfo, "반환된 매칭 정보가 예상과 일치해야 함.")
//        }.store(in: &cancellables)
//
//        wait(for: [expectation], timeout: 5)
//    }
//
//    func test_api통신_실패시_올바른에러반환() {
//        let expectation = XCTestExpectation(description: "API 호출 실패 시 올바른 에러를 반환해야 합니다.")
//
//        let testableRequestId = "존재하지 않는 요청 아이디"
//        let testableTargetUserCode = "G36K"
//        let query = MatchingUserQuery(requestId: testableRequestId, targetUserCode: testableTargetUserCode)
//        
//        // when
//        let response = sut!.matchingUser(query: query)
//        
//        response.sink { completion in
//            switch completion {
//            case .finished:
//                XCTFail("성공적으로 완료되면 안 된다.")
//            case let .failure(error):
//                XCTAssertNotNil(error, "에러가 반환되어야 함.")
//                // 추가적인 에러 타입 검증 가능
//            }
//            expectation.fulfill()
//            
//        } receiveValue: { _ in
//            XCTFail("리턴 값이 없어야 함.")
//        }.store(in: &cancellables)
//
//        wait(for: [expectation], timeout: 5)
//    }
//}
