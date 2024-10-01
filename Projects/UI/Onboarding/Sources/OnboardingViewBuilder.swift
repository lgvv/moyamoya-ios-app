import SwiftUI
import Coordinator

public struct OnboardingViewBuilder {
    let inject: DependecyInject
    let delegate: ((DelegateAction) -> ())
    
    public init(
        inject: DependecyInject,
        delegate: @escaping (DelegateAction) -> Void
    ) {
        self.inject = inject
        self.delegate = delegate
    }
    
    public var body: some View {
        OnboardingView(inject: inject)
    }
    
    public struct DependecyInject {
        let coordinator: OnboardingCoordinatorInterface
        
        public init(
            coordinator: OnboardingCoordinatorInterface
        ) {
            self.coordinator = coordinator
        }
    }
    
    public enum DelegateAction {
        
    }
}
