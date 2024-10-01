import FunchCore
import FunchNetworking

extension RequestDTO {
    struct SearchSubwayStation: Requestable {
        
        var searchText: String
        
        init(query: SearchSubwayStationQuery) {
            searchText = query.searchText
        }
        
        var toDitionary: DictionaryType {
            [
                "query": searchText,
            ]
        }
    }
}
