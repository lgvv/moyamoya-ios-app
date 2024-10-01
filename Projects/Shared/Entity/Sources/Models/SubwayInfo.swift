import Foundation

/// 지하철 역 정보
public struct SubwayInfo: Hashable, Codable {
    /// 지하철 이름
    public var name: String
    /// 호선 정보
    public var lines: [String]
    
    public init(name: String, lines: [String]) {
        self.name = name
        self.lines = lines
    }
}
