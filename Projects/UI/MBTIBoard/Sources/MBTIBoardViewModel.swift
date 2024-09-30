import Entity
import SwiftUI
import DesignSystem
import MBTIBoardFeature
import UserDefaultClient

final class MBTIBoardViewModel: ObservableObject {
    
    enum Action {
        case load
        case loadFailed
    }
    
    @Published var profile: Profile? = nil
    @Published var mbtiTiles: [(String, CGFloat)] = []
    
    private var inject: MBTIBoardViewBuilder.DependecyInject
    
    init(inject: MBTIBoardViewBuilder.DependecyInject) {
        self.inject = inject
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            guard let selectionProfile = inject.shared.userDefault.selectionProfile else {
                send(action: .loadFailed)
                return
            }
            
            self.profile = DataModelConverter.shared.convert(dao: selectionProfile)
            
            mbtiTiles = MBTI.allCases.map { mbti in
                let mbti = mbti.rawValue.uppercased()
                let opacity = CGFloat(inject.useCase.mbtiBoard.count(mbti: mbti)) * 0.5
                return (mbti, opacity)
            }
            
            print(mbtiTiles)
            
        case .loadFailed:
            mbtiTiles = MBTI.allCases.map { mbti in
                let mbti = mbti.rawValue.uppercased()
                return (mbti, 0)
            }
        }
    }
}
