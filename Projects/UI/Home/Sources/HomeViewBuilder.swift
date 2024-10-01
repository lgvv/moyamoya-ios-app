import Entity
import SwiftUI
import Combine
import Coordinator
import OpenURLClient
import ProfileFeature
import MatchingFeature
import MBTIBoardFeature
import UserDefaultClient

public struct HomeViewBuilder {
    
    private var inject: DependecyInject
    private var delegate: (DelegateAction) -> ()
    
    public init(
        inject: DependecyInject,
        delegate: @escaping (DelegateAction) -> ()
    ) {
        self.inject = inject
        self.delegate = delegate
    }
    
    public var body: some View {
        let viewModel = HomeViewModel(inject: inject, delegate: delegate)
        let view = HomeView(viewModel: viewModel)
        
        return view
    }
    
    public struct DependecyInject {
        
        public let coordinator: HomeCoordinatorInterface
        public let useCase: UseCase
        public let shared: Shared
        public let sideEffect: PassthroughSubject<SideEffect, Never>?
        
        public init(
            useCase: UseCase,
            shared: Shared,
            coordinator: HomeCoordinatorInterface,
            sideEffect: PassthroughSubject<SideEffect, Never>? = nil
        ) {
            self.useCase = useCase
            self.shared = shared
            self.coordinator = coordinator
            self.sideEffect = sideEffect
        }
        
        public struct UseCase {
            let mbtiBoard: MBTIBoardUseCase
            let fetchProfile: FetchProfileUseCase
            let matching: MatchingUseCase
            
            public init(mbtiBoard: MBTIBoardUseCase, fetchProfile: FetchProfileUseCase, matching: MatchingUseCase) {
                self.mbtiBoard = mbtiBoard
                self.fetchProfile = fetchProfile
                self.matching = matching
            }
        }
        
        public struct Shared {
            let openURL: OpenURLClient
            let userDefault: UserDefaultManager
            
            public init(openURL: OpenURLClient, userDefault: UserDefaultManager) {
                self.openURL = openURL
                self.userDefault = userDefault
            }
        }
        
        /// 외부 환경 변환
        public enum SideEffect {
            /// 프로필 변경
            case didChange(profile: Profile)
            /// 프로필 삭제
            case delete(profile: Profile)
        }
    }
    
    public enum DelegateAction {}
}

