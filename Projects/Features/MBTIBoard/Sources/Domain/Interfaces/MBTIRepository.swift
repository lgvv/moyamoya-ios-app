import Foundation

public protocol MBTIRepository {
    func count(mbti: String) -> Int
    func save(mbti: String)
}
