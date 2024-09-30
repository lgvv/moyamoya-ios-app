import Foundation

public struct MatchingInfo: Identifiable, Hashable {
    public var id = UUID()
    
    /// 매칭된 유저의 프로필 정보
    public var profile: MatchProfile
    /// 매칭된 유저와 나의 닮은 정도
    public var similarity: Int
    /// 시너지 정보
    public var chemistryInfos: [ChemistryInfo]
    /// 추천정보
    public var recommendInfos: [RecommendInfo]
    /// 지하철 정보
    public var subwayChemistryInfo: ChemistryInfo?
    
    /// 매칭된 상대 프로필
    public struct MatchProfile: Hashable, Codable {
        /// 이름
        public let name: String
        /// 전공
        public let major: String
        /// 동아리
        public let clubs: [String]
        /// mbti
        public let mbti: String
        /// 혈액형
        public let bloodType: String
        /// 지하철 정보
        public let subwayInfos: [SubwayInfo]
        
        public init(name: String, major: String, clubs: [String], mbti: String, bloodType: String, subwayInfos: [SubwayInfo]) {
            self.name = name
            self.major = major
            self.clubs = clubs
            self.mbti = mbti
            self.bloodType = bloodType
            self.subwayInfos = subwayInfos
        }
    }
    
    public struct ChemistryInfo: Hashable, Codable {
        public let title: String
        public let description: String
        
        public init(title: String, description: String) {
            self.title = title
            self.description = description
        }
    }
    
    /// 추천 정보
    public struct RecommendInfo: Hashable, Codable {
        /// 추천 내용
        public var title: String
        
        public init(title: String) {
            self.title = title
        }
    }

    public static func == (lhs: MatchingInfo, rhs: MatchingInfo) -> Bool {
        lhs.id == rhs.id
    }
    
    public init(id: UUID = UUID(), profile: MatchProfile, similarity: Int, chemistryInfos: [ChemistryInfo], recommendInfos: [RecommendInfo], subwayChemistryInfo: ChemistryInfo? = nil) {
        self.id = id
        self.profile = profile
        self.similarity = similarity
        self.chemistryInfos = chemistryInfos
        self.recommendInfos = recommendInfos
        self.subwayChemistryInfo = subwayChemistryInfo
    }
}
