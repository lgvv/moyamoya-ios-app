import Entity
import SwiftUI
import FunchCore

public final class UserDefaultManager {
    
    public static let shared = UserDefaultManager()
    
    private init() {}

    /// 멀티프로필 중 사용자가 선택한 프로필
    @AppStorage(UserDefaultKeyCase.selectionProfile.rawValue)
    public var selectionProfile: DAO.Profile? = nil
    
    /// 유저의 프로필
    @AppStorage(UserDefaultKeyCase.profiles.rawValue)
    public var profiles: Set<DAO.Profile> = []
    
    /// 유저가 매칭한 결과물
    @AppStorage(UserDefaultKeyCase.matchedResults.rawValue)
    public var matchedResults: [DAO.MatchingInfo] = []
    
    /// 빙고보드 딕셔너리
    /// - e.g ["istp": 4, "enfj": 1]
    public var mbtiBoard: [String: Int] {
        get {
            UserDefaults.standard.dictionary(
                forKey: UserDefaultKeyCase.mbtiBoard.rawValue
            ) as? [String: Int] ?? [:]
        }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultKeyCase.mbtiBoard.rawValue) }
    }
}

/// `UserDefaultKeyCase`키 값 정보
enum UserDefaultKeyCase: String {
    case selectionProfile
    case profiles
    case matchedResults
    case mbtiBoard
}
