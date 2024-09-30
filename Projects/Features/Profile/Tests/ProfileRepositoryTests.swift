import XCTest
import Entity
import Combine
@testable import ProfileFeature

final class ProfileRepositoryTests: XCTestCase {

    /// 나중에 프로토콜로 교체할게요.
    var repository: ProfileRepository?
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        repository = ProfileRepositoryImpl(apiClient: .init())
    }

    override func tearDown() {
        super.tearDown()
        
        repository = nil
        cancellables.removeAll()
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    /// 디바이스 기반 조회
    func test_fetch_profile_from_device_id() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        let expectationData: Profile = .init(
            userId: "65ccd1bcffc89209ea09ce40",
            userCode: "",
            userNickname: "",
            majors: [],
            clubs: [],
            mbti: "",
            bloodType: "",
            subwayInfos: [],
            viewerShip: ""
        )
        
        let result = repository?.fetchProfile()
        result?.sink { completion in
            if case .failure = completion {
                XCTFail("completion.userCode")
            }
            expectation.fulfill()
        } receiveValue: { profile in
            XCTAssertEqual(expectationData.userId, profile.userId)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    /// 프로필 아이디 기반 조회
    func test_fetch_profile_from_id() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        let testableId = "65ccd1bcffc89209ea09ce40"
        let expectationData: Profile = .init(
            userId: "65ccd1bcffc89209ea09ce40",
            userCode: "GRTK",
            userNickname: "",
            majors: [],
            clubs: [],
            mbti: "",
            bloodType: "",
            subwayInfos: [],
            viewerShip: ""
        )
        let query = FetchUserQuery(id: testableId)
        
        let result = repository?.fetchProfile(query: query)
        result?.sink { completion in
            if case .failure = completion {
                XCTFail("completion.userCode")
            }
            expectation.fulfill()
        } receiveValue: { profile in
            XCTAssertEqual(expectationData.userCode, profile.userCode)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    /// 유저 생성
    func test_createProfile() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        let expectationData: Profile = .init(
            userId: "65ccd1bcffc89209ea09ce40",
            userCode: "GRTK",
            userNickname: "",
            majors: [],
            clubs: [],
            mbti: "",
            bloodType: "",
            subwayInfos: [],
            viewerShip: ""
        )
        
        // mock으로 나중에 뺄게요
        let query = CreateUserQuery(
            name: "박당근",
            major: "designer",
            clubs: ["nexters"],
            bloodType: "A",
            subwayStationName: ["건대입구"],
            mbti: "ISTP"
        )
        
        let result = repository?.createProfile(query: query)
        
        result?.sink { completion in
            if case .failure = completion {
                XCTFail("completion.userCode")
            }
            expectation.fulfill()
        } receiveValue: { profile in
            XCTAssertEqual(expectationData.userCode, profile.userCode)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    /// 유저 삭제
    func test_deleteProfile() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        let expectationData: Profile = .init(
            userId: "65ccd1bcffc89209ea09ce40",
            userCode: "GRTK",
            userNickname: "",
            majors: [],
            clubs: [],
            mbti: "",
            bloodType: "",
            subwayInfos: [],
            viewerShip: ""
        )
        
        /// createProfile 로 생성된 id로 삭제 테스트
        let query = DeleteProfileQuery(profileId: "65d61fcf1cd2ab69d9f3f69e")
        
        let result = repository?.deleteProfile(query: query)
        result?.sink { completion in
            if case let .failure(error) = completion {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        } receiveValue: { profile in
            XCTAssert(true, "삭제 성공")
            expectation.fulfill()
        }.store(in: &cancellables)
    }

}
