//
//  NavigationDestination.swift
//  App
//
//  Created by Geon Woo lee on 9/16/24.
//

import SwiftUI
import OnboardingUI
import HomeUI
import ProfileEditUI
import Coordinator

struct NavigationDestintationView {
    
    private let viewModel: FunchAppViewModel
    
    init(viewModel: FunchAppViewModel) {
        self.viewModel = viewModel
    }
    
    @ViewBuilder
    func onboarding(destination: OnboardingNavigationDestination) -> some View {
        switch destination {
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
        }
    }
    
    @ViewBuilder
    func home(destination: HomeNavigationDestination) -> some View {
        switch destination {
        case .onboarding:
            OnboardingViewBuilder(
                inject: .init(
                    coordinator: viewModel
                )) { delegateAction in
                    viewModel.send(action: .onboardinDelgate(delegateAction))
                }
                .body
            
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
        }
    }
    
    @ViewBuilder
    func multiProfile(destination: MultiProfileNavigationDestination) -> some View {
        switch destination {
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
        }
    }
}
