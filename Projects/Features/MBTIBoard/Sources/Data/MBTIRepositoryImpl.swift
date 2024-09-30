import UserDefaultClient

/// 유저가 mbti board를 확인할 때의 repository
public final class MBTIRepositoryImpl: MBTIRepository {
    
    private let userDefault: UserDefaultManager
    private var mbtiBoardDictionary: [String: Int]
    
    public init(
        userDefault: UserDefaultManager
    ) {
        self.userDefault = userDefault
        self.mbtiBoardDictionary = userDefault.mbtiBoard
    }
    
    public func count(mbti: String) -> Int {
        return mbtiBoardDictionary[mbti] ?? 0
    }
    
    public func save(mbti: String) {
        if let count = mbtiBoardDictionary[mbti] {
            mbtiBoardDictionary.updateValue(count + 1, forKey: mbti)
        } else {
            mbtiBoardDictionary[mbti] = 1
        }
        
        userDefault.mbtiBoard = mbtiBoardDictionary
    }
}
