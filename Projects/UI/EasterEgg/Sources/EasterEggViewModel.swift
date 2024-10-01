import Foundation

final class EasterEggViewModel: ObservableObject {
    
    enum Action {
        case feedback
    }
    
    init(inject: EasterEggViewBuilder.DependecyInject) {
        self.inject = inject
    }
    
    private var inject: EasterEggViewBuilder.DependecyInject

    func send(action: Action) {
        switch action {
        case .feedback:
            do {
                try inject.shared.openURL.feedback()
            } catch {
                // TODO: Error Handling
            }
        }
    }
}
