import Entity
import SwiftUI
import Coordinator
import OpenURLClient
import ProfileFeature
import UserDefaultClient

public struct ProfileViewBuilder {
    
    private let inject: DependecyInject
    private let delegate: ((DelegateAction) -> ())
    
    public init(
        inject: DependecyInject,
        delegate: @escaping ((DelegateAction) -> ())
    ) {
        self.inject = inject
        self.delegate = delegate
    }
    
    public var body: some View {
        let viewModel = ProfileViewModel(
            inject: inject,
            delegate: delegate
        )
        let view = ProfileView(viewModel: viewModel)
        
        return view
    }
    
    public struct DependecyInject {
        
        let useCase: UseCase
        let shared: Shared
        let coordinator: ProfileCoordinatorInterface
        
        public struct UseCase {
            let deleteProfile: DeleteProfileUseCase
            
            public init(deleteProfile: DeleteProfileUseCase) {
                self.deleteProfile = deleteProfile
            }
        }
        
        public struct Shared {
            let userDefault: UserDefaultManager
            let openURL: OpenURLClient
            
            public init(userDefault: UserDefaultManager, openURL: OpenURLClient) {
                self.userDefault = userDefault
                self.openURL = openURL
            }
        }
        
        public init(
            useCase: UseCase,
            shared: Shared,
            coordinator: ProfileCoordinatorInterface
        ) {
            self.useCase = useCase
            self.shared = shared
            self.coordinator = coordinator
        }
    }
    
    public enum DelegateAction {
        case delete(profile: Profile)
    }
}
