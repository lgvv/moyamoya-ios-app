import Entity
import SwiftUI
import Coordinator
import DesignSystem
import ProfileFeature
import UserDefaultClient

final class MultiProfileListViewModel: ObservableObject {
    
    enum Action {
        case load
        case selection(Profile)
        case presentation(Coordinator.MultiProfilePresentationAction)
        case push(Coordinator.MultiProfileNavigationDestination)
        case dismiss
    }
    
    /// 프로필 목록
    @Published var profiles: [Profile] = []
    /// 유저가 선택한 프로필
    @Published var selection: Profile?
    @Published var dismiss: Bool = false
    
    private var inject: MultiProfileListViewBuilder.DependencyInject
    private var delegate: ((MultiProfileListViewBuilder.DelegateAction) -> ())
    
    init(
        inject: MultiProfileListViewBuilder.DependencyInject,
        delegate: @escaping ((MultiProfileListViewBuilder.DelegateAction) -> ())
    ) {
        self.inject = inject
        self.delegate = delegate
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            let daos = inject.shared.userDefault.profiles.sorted { $0.createAt > $1.createAt }
            self.profiles = daos.map { dao in
                DataModelConverter.shared.convert(dao: dao)
            }
            
            if let selectionProfile = inject.shared.userDefault.selectionProfile {
                self.selection = DataModelConverter.shared.convert(dao: selectionProfile)
            } else {
                self.selection = self.profiles.first
            }
            
        case let .selection(profile):
            inject.shared.userDefault.selectionProfile = DataModelConverter.shared.convert(model: profile)
            self.selection = profile
        
        case let .presentation(presentation):
            inject.coordinator.present(presentation)
            
        case let .push(destination):
            inject.coordinator.push(destination)
            
        case .dismiss:
            guard let profile = self.selection else { return }
            delegate(.didChange(profile: profile))
            dismiss = true
            
        }
    }
}
