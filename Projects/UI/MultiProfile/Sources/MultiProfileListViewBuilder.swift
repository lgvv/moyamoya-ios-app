import Entity
import SwiftUI
import ProfileFeature
import UserDefaultClient
import Coordinator

public struct MultiProfileListViewBuilder {
    
    private var inject: DependencyInject
    private let delegate: ((DelegateAction) -> ())
    
    public init(
        inject: DependencyInject,
        delegate: @escaping ((DelegateAction) -> ())
    ) {
        self.inject = inject
        self.delegate = delegate
    }
    
    public var body: some View {
        let viewModel = MultiProfileListViewModel(
            inject: inject,
            delegate: delegate
        )
        let view = MultiProfileListView(viewModel: viewModel)
        
        return view
    }
    
    public struct DependencyInject {
        
        let useCase: UseCase
        let shared: Shared
        let coordinator: MultiProfileCoordinatorInterface
        
        public init(
            useCase: UseCase,
            shared: Shared,
            coordinator: MultiProfileCoordinatorInterface
        ) {
            self.useCase = useCase
            self.shared = shared
            self.coordinator = coordinator
        }
        
        public struct UseCase {
            let delegateProfile: DeleteProfileUseCase
            
            public init(
                delegateProfile: DeleteProfileUseCase
            ) {
                self.delegateProfile = delegateProfile
            }
        }
        
        public struct Shared {
            let userDefault: UserDefaultManager
            
            public init(
                userDefault: UserDefaultManager
            ) {
                self.userDefault = userDefault
            }
        }
    }
    
    public enum DelegateAction {
        /// 프로필 변경 되었을 때
        case didChange(profile: Profile)
    }
}
