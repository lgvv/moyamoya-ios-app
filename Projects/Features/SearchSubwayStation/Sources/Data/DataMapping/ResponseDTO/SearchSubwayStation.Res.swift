import Entity
import FunchNetworking

extension ResponseDTO {
    struct SearchSubwayStation: Respondable {
        var status: String
        var message: String
        var data: [DataClass]
        
        enum CodingKeys: CodingKey {
            case status
            case message
            case data
        }
        
        struct DataClass: Decodable {
            /// 지하철 역
            let name: String
            /// 지하철 호선
            let lines: [String]
            /// 좌표
            let location: Location
            
            enum CodingKeys: CodingKey {
                case name
                case lines
                case location
            }
            
            struct Location: Decodable {
                var latitude: String
                var longitude: String
                
                enum CodingKeys: CodingKey {
                    case latitude
                    case longitude
                }
            }
        }
    }
}

extension ResponseDTO.SearchSubwayStation {
    func toDomain() -> [SubwayInfo] {
        let subwayInfoList: [SubwayInfo] = data.map { subwayInfo in
                .init(name: subwayInfo.name, lines: subwayInfo.lines)
        }
        return subwayInfoList
    }
}
