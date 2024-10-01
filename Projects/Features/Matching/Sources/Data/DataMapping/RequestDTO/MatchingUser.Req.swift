import FunchCore
import FunchNetworking

extension RequestDTO {
    struct MatchingUser: Requestable {
        
        /// 나의 요청 id
        var requestId: String
        /// 내가 입력한 상대방 유저 코드
        var targetUserCode: String
        
        init(query: MatchingUserQuery) {
            requestId = query.requestId
            targetUserCode = query.targetUserCode
        }
        
        var toDitionary: DictionaryType {
            [
                "requestMemberId": requestId,
                "targetMemberCode": targetUserCode,
            ]
        }
    }
}
