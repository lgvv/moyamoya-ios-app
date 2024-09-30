import HomeUI
import SwiftUI
import ProfileUI
import Coordinator
import EasterEggUI
import MBTIBoardUI
import OnboardingUI
import ProfileEditUI
import MatchResultUI
import MultiProfileUI
import MatchingFeature

struct PresentationView {
    @ObservedObject var viewModel: FunchAppViewModel

    @ViewBuilder
    var home: some View {
        switch viewModel.coordinator.presnetation.home {
        case .profileEdit:
            NavigationStack {
                ProfileEditorViewBuilder(
                    inject: .init(
                        useCase: .init(
                            searchSubway: container.makeSearchSubwayUseCase(),
                            createProfile: container.makeCreateProfileUseCase()
                        ),
                        shared: .init(
                            userDefault: container.makeUserDefaultClient(),
                            openURL: container.makeOpenURLClient()
                        ),
                        coordinator: viewModel
                    )
                ) { delegateAction in
                    //
                }
                .body
            }
            
        case let .matchingResult(matchingInfo):
            NavigationStack {
                MatchResultViewBuilder(
                    inject: .init(),
                    matchingInfo: matchingInfo
                )
                .body
            }
            
        case .mbtiCollection:
            NavigationStack {
                MBTIBoardViewBuilder(
                    inject: .init(
                        useCase: .init(
                            mbtiBoard: container.makeMBTIBoardUseCase()
                        ),
                        shared: .init(
                            userDefault: container.makeUserDefaultClient()
                        )
                    )
                )
                .body
            }
            
        case .easterEgg:
            NavigationStack {
                EasterEggViewBuilder(
                    inject: .init(
                        shared: .init(
                            openURL: container.makeOpenURLClient()
                        )
                    )
                )
                .body
            }
            
        case .multiProfile:
            NavigationStack(path: $viewModel.coordinator.destination.multiProfile) {
                MultiProfileListViewBuilder(
                    inject: .init(
                        useCase: .init(
                            delegateProfile: container.makeDelegateProfileUseCase()
                        ),
                        shared: .init(
                            userDefault: container.makeUserDefaultClient()
                        ),
                        coordinator: viewModel
                    ),
                    delegate: { delegateAction in
                        viewModel.send(action: .multiProfileListDelegate(delegateAction))
                    }
                )
                .body
                .fullScreenCover(item: $viewModel.coordinator.presnetation.multiProfile) { _ in
                    PresentationView(viewModel: viewModel)
                        .multiProfile
                }
                .navigationDestination(for: MultiProfileNavigationDestination.self) {
                    NavigationDestintationView(viewModel: viewModel)
                        .multiProfile(destination: $0)
                        .navigationBarBackButtonHidden()
                }
            }
         
        case .onboarding:
            NavigationStack {
                OnboardingViewBuilder(
                    inject: .init(
                        coordinator: viewModel
                    )) { delegateAction in
                        viewModel.send(action: .onboardinDelgate(delegateAction))
                    }
                    .body
            }
            
        case .home:
            NavigationStack {
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
                        coordinator: viewModel
                    )) { delegateAction in
                        viewModel.send(action: .homeDelegate(delegateAction))
                    }
                    .body
            }
            
        case .myProfile:
            NavigationStack {
                ProfileViewBuilder(
                    inject: .init(
                        useCase: .init(
                            deleteProfile: container.makeDelegateProfileUseCase()
                        ),
                        shared: .init(
                            userDefault: container.makeUserDefaultClient(),
                            openURL: container.makeOpenURLClient()
                        ),
                        coordinator: viewModel
                    )) { delegateAction in
                        viewModel.send(action: .profileDelegate(delegateAction))
                    }
                    .body
            }
            
        case .none:
            EmptyView()
        }
    }
    
    
    @ViewBuilder
    var profile: some View {
        switch viewModel.coordinator.presnetation.profile {
        case .onboarding:
            NavigationStack {
                OnboardingViewBuilder(
                    inject: .init(
                        coordinator: viewModel
                    )) { delegateAction in
                        viewModel.send(action: .onboardinDelgate(delegateAction))
                    }
                    .body
            }
            
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    var profileEdit: some View {
        switch viewModel.coordinator.presnetation.profileEdit {
        case .home:
            // 예전에 썼지만 이제 안쓰는 경로
            EmptyView()
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    var onboarding: some View {
        switch viewModel.coordinator.presnetation.multiProfile {
        case .profileEdit:
            NavigationStack {
                ProfileEditorViewBuilder(
                    inject: .init(
                        useCase: .init(
                            searchSubway: container.makeSearchSubwayUseCase(),
                            createProfile: container.makeCreateProfileUseCase()
                        ),
                        shared: .init(
                            userDefault: container.makeUserDefaultClient(),
                            openURL: container.makeOpenURLClient()
                        ),
                        coordinator: viewModel
                    )
                ) { delegateAction in
                    viewModel.send(action: .profileEditDelegate(delegateAction))
                }
                .body
            }
            
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    var multiProfile: some View {
        switch viewModel.coordinator.presnetation.multiProfile {
        case .profileEdit:
            ProfileEditorViewBuilder(
                inject: .init(
                    useCase: .init(
                        searchSubway: container.makeSearchSubwayUseCase(),
                        createProfile: container.makeCreateProfileUseCase()
                    ),
                    shared: .init(
                        userDefault: container.makeUserDefaultClient(),
                        openURL: container.makeOpenURLClient()
                    ),
                    coordinator: viewModel
                ),
                delegate: { delegateAction in
                    viewModel.send(action: .profileEditDelegate(delegateAction))
                }
            )
            .body
            
        default:
            EmptyView()
            
        }
    }
}
