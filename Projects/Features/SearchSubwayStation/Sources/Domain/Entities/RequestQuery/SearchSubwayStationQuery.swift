import Foundation

public struct SearchSubwayStationQuery: Hashable {
    /// 검색어
    var searchText: String
    
    public init(searchText: String) {
        self.searchText = searchText
    }
}
