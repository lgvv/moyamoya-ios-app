import Foundation

public protocol Respondable: Decodable {
    var status: String { get set }
    var message: String { get set }
}
