import Moya
import FunchCore

public protocol APIClientInterface {
    func request<T: Respondable>(
        _ T: T.Type,
        target: DefaultTargetType,
        completion: @escaping (Result<T, MoyaError>) -> Void
    )
}
