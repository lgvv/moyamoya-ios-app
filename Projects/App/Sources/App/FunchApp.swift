import HomeUI
import Combine
import SwiftUI
import SplashUI
import ProfileUI
import Coordinator
import OnboardingUI
import DesignSystem
import ProfileEditUI
import MultiProfileUI
import UserDefaultClient

final class FunchAppViewModel: ObservableObject,
                               OnboardingCoordinatorInterface,
                               MultiProfileCoordinatorInterface,
                               HomeCoordinatorInterface,
                               ProfileEditCoordinatorInterface,
                               ProfileCoordinatorInterface {
    /// 스플래시 뷰 노출 여부
    @Published var isSplashing: Bool = true
    /// 화면전환 `CoordinatorAction`
    @Published var coordinator: CoordinatorAction = .init()
    
    struct CoordinatorAction {
        var presnetation = Presentation()
        
        struct Presentation {
            var multiProfile: MultiProfilePresentationAction?
            var home: HomePresentationAction?
            var profileEdit: ProfileEditPresentationAction?
            var profile: ProfilePresentationAction?
        }
        
        var destination: Destination = .init()
        
        struct Destination {
            var home: [HomeNavigationDestination] = []
            var multiProfile: [MultiProfileNavigationDestination] = []
            var onboarding: [OnboardingNavigationDestination] = []
        }
    }
    
    var userDefaultClient = UserDefaultManager.shared
    
    private(set) var sideEffect = SideEffect()
    
    struct SideEffect {
        var home = PassthroughSubject<HomeViewBuilder.DependecyInject.SideEffect, Never>()
    }
    
    enum Action {
        case onboardinDelgate(OnboardingViewBuilder.DelegateAction)
        case homeDelegate(HomeViewBuilder.DelegateAction)
        case profileDelegate(ProfileViewBuilder.DelegateAction)
        case multiProfileListDelegate(MultiProfileListViewBuilder.DelegateAction)
        case profileEditDelegate(ProfileEditorViewBuilder.DelegateAction)
    }
    
    func send(action: Action) {
        switch action {
        case let.onboardinDelgate(delegateAction):
            break
            
        case let .homeDelegate(delegateAction):
            break
            
        case let .profileDelegate(delegateAction):
            switch delegateAction {
            case let .delete(profile):
                sideEffect.home.send(.delete(profile: profile))
                
            }
            
        case let .multiProfileListDelegate(delegateAction):
            switch delegateAction {
            case .didChange(let profile):
                sideEffect.home.send(.didChange(profile: profile))
                
            }
            
        case let .profileEditDelegate(delegateAction):
            break
            
        }
    }
    
    func present(_ action: Coordinator.MultiProfilePresentationAction) {
        self.coordinator.presnetation.multiProfile = action
    }
    
    func push(_ action: Coordinator.MultiProfileNavigationDestination) {
        self.coordinator.destination.multiProfile.append(action)
    }
    
    func push(_ action: Coordinator.OnboardingNavigationDestination) {
        self.coordinator.destination.onboarding.append(action)
    }
    
    func present(_ action: Coordinator.HomePresentationAction) {
        self.coordinator.presnetation.home = action
    }
    
    func present(_ action: Coordinator.ProfileEditPresentationAction) {
        self.coordinator.presnetation.profileEdit = action
    }
    
    func present(_ action: Coordinator.ProfilePresentationAction) {
        self.coordinator.presnetation.profile = action
    }
    
    func push(_ action: Coordinator.HomeNavigationDestination) {
        self.coordinator.destination.home.append(action)
    }
    
}

@main
struct FunchApp: App {
    @StateObject private var viewModel = FunchAppViewModel()
    
    init() {
        setupNavigationBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    Group {
                        if viewModel.userDefaultClient.profiles.isEmpty {
                            HomeViewBuilder(
                                inject: .init(
                                    useCase: .init(
                                        mbtiBoard: container.makeMBTIBoardUseCase(),
                                        fetchProfile: container.makeFetchProfileUseCase(),
                                        matching: container.makeMatchResultUseCase()
                                    ),
                                    shared: .init(
                                        openURL: container.makeOpenURLClient(),
                                        userDefault: container.makeUserDefaultClient()
                                    ),
                                    coordinator: viewModel,
                                    sideEffect: viewModel.sideEffect.home
                                )) { delegateAction in
                                    viewModel.send(action: .homeDelegate(delegateAction))
                                }
                                .body
                                .fullScreenCover(item: $viewModel.coordinator.presnetation.home) { _ in 
                                    PresentationView(viewModel: viewModel)
                                        .home
                                }
                                .navigationDestination(for: HomeNavigationDestination.self) {
                                    NavigationDestintationView(viewModel: viewModel)
                                        .home(destination: $0)
                                        .navigationBarBackButtonHidden()
                                }
                            
                        } else {
                            OnboardingViewBuilder(
                                inject: .init(
                                    coordinator: viewModel
                                )) { delegateAction in
                                    viewModel.send(action: .onboardinDelgate(delegateAction))
                                }
                                .body
                                .navigationDestination(for: OnboardingNavigationDestination.self) {
                                    NavigationDestintationView(viewModel: viewModel)
                                        .onboarding(destination: $0)
                                        .navigationBarBackButtonHidden()
                                }
                        }
                    }
                }
                .overlay {
                    if viewModel.isSplashing {
                        SplashViewBuilder()
                            .body
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.35) {
                    withAnimation(.easeInOut) {
                        viewModel.isSplashing.toggle()
                    }
                }
            }
        }
    }
}

extension FunchApp {
    private func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: DesignSystemAsset.Color.gray900
        ]
        navigationBarAppearance.backgroundColor = DesignSystemAsset.Color.gray900.color
        navigationBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
