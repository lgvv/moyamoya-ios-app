import Foundation

public final class DataModelConverter {
    public static let shared = DataModelConverter()
    
    private init() {}
    
    public func convert(dao: DAO.Profile) -> Profile {
        
        let majors: [Profile.Major] = dao.majors.map {
            return .init(name: $0.name, imageName: $0.imageName)
        }
        let clubs: [Profile.Club] = dao.clubs.map {
            return .init(name: $0.name, imageName: $0.imageName)
        }
        let subwayInfos: [Profile.SubwayInfo] = dao.subwayInfos.map {
            return .init(name: $0.name, lines: $0.lines)
        }
        
        return .init(
            userId: dao.userId,
            userCode: dao.userCode,
            userNickname: dao.userNickname,
            majors: majors,
            clubs: clubs,
            mbti: dao.mbti,
            bloodType: dao.bloodType,
            subwayInfos: subwayInfos,
            viewerShip: dao.viewerShip
        )
    }
    
    public func convert(model: Profile) -> DAO.Profile {
        
        let majors: [DAO.Profile.Major] = model.majors.map {
            return .init(name: $0.name, imageName: $0.imageName)
        }
        let clubs: [DAO.Profile.Club] = model.clubs.map {
            return .init(name: $0.name, imageName: $0.imageName)
        }
        let subwayInfos: [DAO.Profile.SubwayInfo] = model.subwayInfos.map {
            return .init(name: $0.name, lines: $0.lines)
        }
        
        return .init(
            userId: model.userId,
            userCode: model.userCode,
            userNickname: model.userNickname,
            majors: majors,
            clubs: clubs,
            mbti: model.mbti,
            bloodType: model.bloodType,
            subwayInfos: subwayInfos,
            viewerShip: model.viewerShip
        )
    }
}
