import Foundation

extension DAO {
    public struct MatchingInfo: Codable, Identifiable, Hashable {
        public static func == (lhs: MatchingInfo, rhs: MatchingInfo) -> Bool {
            lhs.id == rhs.id
        }
        
        public var id = UUID()
        
        /// 매칭된 유저의 프로필 정보
        var profile: MatchProfile
        /// 매칭된 유저와 나의 닮은 정도
        var similarity: Int
        /// 시너지 정보
        var chemistryInfos: [ChemistryInfo]
        /// 추천정보
        var recommendInfos: [RecommendInfo]
        /// 지하철 정보
        var subwayChemistryInfo: ChemistryInfo?
        
        /// 매칭된 상대 프로필
        struct MatchProfile: Hashable, Codable {
            /// 이름
            let name: String
            /// 전공
            let major: String
            /// 동아리
            let clubs: [String]
            /// mbti
            let mbti: String
            /// 혈액형
            let bloodType: String
            /// 지하철 정보
            let subwayInfos: [SubwayInfo]
        }
        
        struct ChemistryInfo: Hashable, Codable {
            let title: String
            let description: String
        }
        
        /// 추천 정보
        struct RecommendInfo: Hashable, Codable {
            /// 추천 내용
            var title: String
        }
        
        /// 지하철 역 정보
        struct SubwayInfo: Hashable, Codable {
            /// 지하철 이름
            var name: String
            /// 호선 정보
            var lines: [String]
        }
    }
}
