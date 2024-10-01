import SwiftUI
import Coordinator
import OpenURLClient
import ProfileFeature
import UserDefaultClient
import SearchSubwayStationFeature

public struct ProfileEditorViewBuilder {
    
    let inject: DependencyInject
    let delegate: ((DelegateAction) -> ())
    
    public init(
        inject: DependencyInject,
        delegate: @escaping (DelegateAction) -> ()
    ) {
        self.inject = inject
        self.delegate = delegate
    }
    
    public var body: some View {
        let viewModel = ProfileEditorViewModel(
            inject: inject,
            delegate: delegate
        )
        let view = ProfileEditorView(viewModel: viewModel)
        
        return view
    }

    public struct DependencyInject {
        
        let useCase: UseCase
        let shared: Shared
        let coordinator: ProfileEditCoordinatorInterface
        
        public init(
            useCase: UseCase,
            shared: Shared,
            coordinator: ProfileEditCoordinatorInterface
        ) {
            self.useCase = useCase
            self.shared = shared
            self.coordinator = coordinator
        }
        
        public struct UseCase {
            let searchSubway: SearchSubwayUseCase
            let createProfile: CreateProfileUseCase
            
            public init(searchSubway: SearchSubwayUseCase, createProfile: CreateProfileUseCase) {
                self.searchSubway = searchSubway
                self.createProfile = createProfile
            }
        }
        
        public struct Shared {
            let userDefault: UserDefaultManager
            let openURL: OpenURLClientInterface
            
            public init(userDefault: UserDefaultManager, openURL: OpenURLClientInterface) {
                self.userDefault = userDefault
                self.openURL = openURL
            }
        }
    }
    
    public struct DelegateAction {
        
    }
    
}
