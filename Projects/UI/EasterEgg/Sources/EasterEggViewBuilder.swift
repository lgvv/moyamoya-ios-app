import SwiftUI
import DesignSystem
import OpenURLClient

public struct EasterEggViewBuilder {
    public var inject: DependecyInject
    
    public init(inject: DependecyInject) {
        self.inject = inject
    }
    
    public var body: some View {
        let viewModel = EasterEggViewModel(inject: inject)
        let view = EasterEggView(viewModel: viewModel)
        
        return view
    }
    
    public struct DependecyInject {
        
        let shared: Shared
        
        public init(shared: Shared) {
            self.shared = shared
        }
        
        public struct Shared {
            let openURL: OpenURLClientInterface
            
            public init(openURL: OpenURLClientInterface) {
                self.openURL = openURL
            }
        }
    }
}
