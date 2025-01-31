import UIKit
import Entity
import SwiftUI
import Combine
import FunchCore
import FunchNetworking

/// User 본인을 기준으로 하는 repository
public final class ProfileRepositoryImpl: ProfileRepository {
    
    private let apiClient: APIClient
    
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    /// 내 프로필 디바이스 기반 정보 조회
    public func fetchProfile() -> AnyPublisher<Profile, RepositoryError> {
        let query: DictionaryType = ["deviceNumber": UIDevice.uuidString]
        return Future { promise in
            self.apiClient.request(
                ResponseDTO.GetProfile.self,
                target: .getUserProfileFromDeviceId(parameters: query)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
                    promise(.failure(.message("프로필 정보 조회를 실패했어요.")))
                    break
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 내 프로필 코드 기반 정보 조회
    public func fetchProfile(query: FetchUserQuery) -> AnyPublisher<Profile, RepositoryError> {
        return Future { promise in
            self.apiClient.request(
                ResponseDTO.GetProfile.self,
                target: .getUserProfileFromId(path: query.path)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
                    promise(.failure(.message("프로필 조회 실패")))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 프로필 생성
    public func createProfile(query: CreateUserQuery) -> AnyPublisher<Profile, RepositoryError> {
        return Future { promise in
            let requestDTO = RequestDTO.CreateUserProfileDTO(query: query)
            self.apiClient.request(
                ResponseDTO.CreateProfile.self,
                target: .createUserProfile(parameters: requestDTO.toDitionary)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
                    promise(.failure(.message("프로필 생성 실패")))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 프로필 삭제
    public func deleteProfile(query: DeleteProfileQuery) -> AnyPublisher<String, RepositoryError> {
        let requestDTO = RequestDTO.DeleteProfile(query: query)
        return Future { promise in
            self.apiClient.request(
                ResponseDTO.DeleteProfile.self,
                target: .deleteUserProfile(path: requestDTO.path)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
                    promise(.failure(.message("프로필 삭제 실패")))
                }
            }
        }.eraseToAnyPublisher()
    }
}
