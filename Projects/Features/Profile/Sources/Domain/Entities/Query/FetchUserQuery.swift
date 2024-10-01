import Foundation

/// id를 기반으로 유저 조회
public struct FetchUserQuery {
    
    /// 프로필 아이디
    let id: String
    
    public init(id: String) {
        self.id = id
    }
    
    var path: String {
        "\(id)"
    }
}
