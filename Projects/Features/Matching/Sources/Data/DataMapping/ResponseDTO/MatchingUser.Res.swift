import Entity
import FunchNetworking

extension ResponseDTO {
    struct MatchingUser: Respondable {
        var status: String
        var message: String
        var data: DataClass
        
        struct DataClass: Decodable {
            let profile: Profile
            let similarity: Int
            let chemistryInfos: [ChemistryInfo]
            let matchedInfos: [MatchedInfo]
            let subwayChemistryInfo: ChemistryInfo?
            
            struct Profile: Decodable {
                let name: String
                let jobGroup: String
                let clubs: [String]
                let mbti: String
                let bloodType: String
                let subwayInfos: [SubwayInfo]
            }
            
            struct SubwayInfo: Decodable {
                let name: String
                let lines: [String]
            }
            
            struct ChemistryInfo: Decodable {
                let title: String
                let description: String
            }
            
            struct MatchedInfo: Decodable {
                let title: String
            }
        }
    }
}

extension ResponseDTO.MatchingUser {
    func toDomain() -> MatchingInfo {
        
        let subwayInfos: [SubwayInfo] = data.profile.subwayInfos.map { subwayInfo in
            .init(name: subwayInfo.name, lines: subwayInfo.lines)
        }
        let profile = MatchingInfo.MatchProfile(
            name: data.profile.name,
            major: data.profile.jobGroup,
            clubs: data.profile.clubs,
            mbti: data.profile.mbti,
            bloodType: data.profile.bloodType,
            subwayInfos: subwayInfos
        )
        
        let chemistryInfos = data.chemistryInfos.map { info -> MatchingInfo.ChemistryInfo in
                .init(title: info.title, description: info.description)
        }
        
        let recommendInfos = data.matchedInfos.map { info -> MatchingInfo.RecommendInfo in
                .init(title: info.title)
        }
        
        var subwayChemistryInfo: MatchingInfo.ChemistryInfo?
        if let subwayInfo = data.subwayChemistryInfo {
            subwayChemistryInfo = .init(
                title: subwayInfo.title,
                description: subwayInfo.description
            )
        } else { subwayChemistryInfo = nil }
        
        return .init(
            profile: profile,
            similarity: data.similarity,
            chemistryInfos: chemistryInfos,
            recommendInfos: recommendInfos,
            subwayChemistryInfo: subwayChemistryInfo
        )
    }
}
