import Foundation

public struct MatchingUserQuery: Hashable {
    /// 나의 id
    var requestId: String
    /// 상대방 userCode
    var targetUserCode: String
    
    public init(requestId: String, targetUserCode: String) {
        self.requestId = requestId
        self.targetUserCode = targetUserCode
    }
}
