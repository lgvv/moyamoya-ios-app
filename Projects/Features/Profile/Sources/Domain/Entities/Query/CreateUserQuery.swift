import Foundation

public struct CreateUserQuery {
    /// 이름
    var name: String
    /// 전공
    var major: String
    /// 동아리
    var clubs: [String]
    /// 혈액형
    var bloodType: String
    /// 지하철역
    var subwayStationName: [String]
    /// mbti
    var mbti: String
    
    public init(
        name: String,
        major: String,
        clubs: [String],
        bloodType: String,
        subwayStationName: [String],
        mbti: String
    ) {
        self.name = name
        self.major = major
        self.clubs = clubs
        self.bloodType = bloodType
        self.subwayStationName = subwayStationName
        self.mbti = mbti
    }
}
