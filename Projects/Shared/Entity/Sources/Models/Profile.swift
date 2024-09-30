import Foundation

public struct Profile: Hashable, Codable, Equatable {
    /// 유저 고유 아이디
    public var userId: String
    /// 유저코드
    public var userCode: String
    /// 유저 닉네임
    public var userNickname: String
    
    /// 직군
    public var majors: [Major]
    /// 동아리
    public var clubs: [Club]
    /// mbti
    public var mbti: String
    /// 혈액형 타입
    public var bloodType: String
    /// 지하철 역
    public var subwayInfos: [SubwayInfo]
    /// 조회수
    public var viewerShip: String
    
    /// 프로필 생성 시각
    public var createAt = Date.now
    
    /// 전공
    public struct Major: Hashable, Codable {
        /// 전공 이름
        public var name: String
        /// 전공 이미지
        public var imageName: String
        
        public init(name: String, imageName: String) {
            self.name = name
            self.imageName = imageName
        }
    }
    
    /// 동아리
    public struct Club: Hashable, Codable {
        /// 동아리 이름
        public var name: String
        /// 동아리 이미지
        public var imageName: String
        
        public init(name: String, imageName: String) {
            self.name = name
            self.imageName = imageName
        }
    }
    
    /// 지하철 역 정보
    public struct SubwayInfo: Hashable, Codable {
        /// 지하철 이름
        public var name: String
        /// 호선 정보
        public var lines: [String]
        
        public init(name: String, lines: [String]) {
            self.name = name
            self.lines = lines
        }
    }
    
    public init(userId: String, userCode: String, userNickname: String, majors: [Major], clubs: [Club], mbti: String, bloodType: String, subwayInfos: [SubwayInfo], viewerShip: String, createAt: Date = Date.now) {
        self.userId = userId
        self.userCode = userCode
        self.userNickname = userNickname
        self.majors = majors
        self.clubs = clubs
        self.mbti = mbti
        self.bloodType = bloodType
        self.subwayInfos = subwayInfos
        self.viewerShip = viewerShip
        self.createAt = createAt
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.userCode)
    }
}

extension Profile {
    public static let mbtiPair: [[String]] = [
        ["E", "I"],
        ["N", "S"],
        ["F", "T"],
        ["P", "J"]
    ]
}
