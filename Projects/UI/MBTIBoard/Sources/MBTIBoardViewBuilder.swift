import SwiftUI
import MBTIBoardFeature
import UserDefaultClient

public struct MBTIBoardViewBuilder {
    
    private var inject: DependecyInject
    
    public init(inject: DependecyInject) {
        self.inject = inject
    }
    
    public var body: some View {
        let viewModel = MBTIBoardViewModel(inject: inject)
        let view = MBTIBoardView(viewModel: viewModel)
        
        return view
    }
    
    public struct DependecyInject {

        let useCase: UseCase
        let shared: Shared
        
        public init(useCase: UseCase, shared: Shared) {
            self.useCase = useCase
            self.shared = shared
        }
        
        public struct UseCase {
            let mbtiBoard: MBTIBoardUseCase
            
            public init(mbtiBoard: MBTIBoardUseCase) {
                self.mbtiBoard = mbtiBoard
            }
        }
        
        public struct Shared {
            let userDefault: UserDefaultManager
            
            public init(userDefault: UserDefaultManager) {
                self.userDefault = userDefault
            }
        }
    }
}
