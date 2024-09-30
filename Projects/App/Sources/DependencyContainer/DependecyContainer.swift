import OpenURLClient
import ProfileEditUI
import ProfileFeature
import MatchingFeature
import FunchNetworking
import MBTIBoardFeature
import UserDefaultClient
import SearchSubwayStationFeature

let container = DependecyContainer()

final class DependecyContainer {
    private var apiClient: APIClient?
    
    private var repository = Repository()
    private var useCase = UseCase()
    private var shared = Shared()
    
    struct Repository {
        var mbti: MBTIRepository?
        var profile: ProfileRepository?
        var matching: MatchingRepository?
        var searchSubway: SearchSubwayStationRepository?
    }
    
    struct UseCase {
        var mbtiBoard: MBTIBoardUseCase?
        var fetchProfile: DefaultFetchProfileUseCase?
        var createProfile: CreateProfileUseCase?
        var matching: MatchingUseCase?
        var searchSubway :SearchSubwayUseCase?
        var deleteProfile: DeleteProfileUseCase?
    }
    
    struct Shared {
        var userDefaultClient: UserDefaultManager?
        var openURLClient: OpenURLClient?
    }
    
    init() {}
    
    private func makeAPIClient() -> APIClient {
        if let apiClient = apiClient {
            return apiClient
        } else {
            let apiClient = APIClient()
            self.apiClient = apiClient
            return apiClient
        }
    }
    
    // MARK: - Shared
    
    func makeOpenURLClient() -> OpenURLClient {
        if let openURLClient = shared.openURLClient {
            return openURLClient
        } else {
            let openURLClient = OpenURLClient()
            self.shared.openURLClient = OpenURLClient()
            return openURLClient
        }
    }
    
    func makeUserDefaultClient() -> UserDefaultManager {
        return .shared
    }
    
    // MARK: - Repository
    
    private func makeMBTIRepository() -> MBTIRepository {
        if let repository = repository.mbti {
            return repository
        } else {
            let repository = MBTIRepositoryImpl(userDefault: makeUserDefaultClient())
            self.repository.mbti = repository
            return repository
        }
    }
    
    private func makeProfileRepository() -> ProfileRepository {
        if let repository = repository.profile {
            return repository
        } else {
            let repository = ProfileRepositoryImpl(apiClient: makeAPIClient())
            self.repository.profile = repository
            return repository
        }
    }
    
    private func makeMatchingRepository() -> MatchingRepository {
        if let repository = repository.matching {
            return repository
        } else {
            let repository = MatchingRepositoryImpl(apiClient: makeAPIClient())
            self.repository.matching = repository
            return repository
        }
    }
    
    private func makeSearchSubwayRepository() -> SearchSubwayStationRepository {
        if let repository = repository.searchSubway {
            return repository
        } else {
            let repository = SearchSubwayStationRepositoryImpl(apiClient: makeAPIClient())
            self.repository.searchSubway = repository
            return repository
        }
    }
    
    // MARK: - UseCase
    
    func makeMBTIBoardUseCase() -> MBTIBoardUseCase {
        if let useCase = useCase.mbtiBoard {
            return useCase
        } else {
            let useCase: MBTIBoardUseCase = useCase.mbtiBoard ?? DefaultMBTIBoardUseCase(repository: makeMBTIRepository())
            self.useCase.mbtiBoard = useCase
            return useCase
        }
    }
    
    func makeFetchProfileUseCase() -> FetchProfileUseCase {
        if let useCase = useCase.fetchProfile {
            return useCase
        } else {
            let useCase = DefaultFetchProfileUseCase(repository: makeProfileRepository())
            self.useCase.fetchProfile = useCase
            return useCase
        }
    }
    
    func makeCreateProfileUseCase() -> CreateProfileUseCase {
        if let useCase = useCase.createProfile {
            return useCase
        } else {
            let useCase: CreateProfileUseCase = DefaultCreateProfileUseCase(repository: makeProfileRepository())
            self.useCase.createProfile = useCase
            return useCase
        }
    }
    
    func makeDelegateProfileUseCase() -> DeleteProfileUseCase {
        if let useCase = useCase.deleteProfile {
            return useCase
        } else {
            let useCase: DeleteProfileUseCase = DefaultDeleteProfileUseCase(repository: makeProfileRepository())
            self.useCase.deleteProfile = useCase
            return useCase
        }
    }
    
    func makeMatchResultUseCase() -> MatchingUseCase {
        if let useCase = useCase.matching {
            return useCase
        } else {
            let useCase: MatchingUseCase = DefaultMatchingUseCase(repository: makeMatchingRepository())
            self.useCase.matching = useCase
            return useCase
        }
    }
    
    func makeSearchSubwayUseCase() -> SearchSubwayUseCase {
        if let useCase = useCase.searchSubway {
            return useCase
        } else {
            let useCase: SearchSubwayUseCase = DefaultSearchSubwayUseCase(repository: makeSearchSubwayRepository())
            self.useCase.searchSubway = useCase
            return useCase
        }
    }
}
