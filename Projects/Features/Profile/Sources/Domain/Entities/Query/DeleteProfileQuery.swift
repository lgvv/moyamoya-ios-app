import Foundation

public struct DeleteProfileQuery {
    /// 삭제할 프로필 id
    var profileId: String
    
    public init(profileId: String) {
        self.profileId = profileId
    }
}
