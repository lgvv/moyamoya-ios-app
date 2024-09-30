import Entity
import SwiftUI
import Combine
import ProfileFeature
import UserDefaultClient

final class ProfileViewModel: ObservableObject {
    
    enum Action {
        case load
        case loadFailed
        case deleteProfile
        case feedback
        case alert(AlertAction)
        
        enum AlertAction {
            case deleteProile
            case feedbackFailed(String)
        }
    }

    @Published var profile: Profile?
    @Published var dismiss: Bool = false

    // MAKR: - Alert
    @Published var showsAlert: Bool = false
    private(set) var alertFeedbackFailed: Bool = false
    private(set) var alertMessage: Action.AlertAction?
    
    private var inject: ProfileViewBuilder.DependecyInject
    private var delegate: ((ProfileViewBuilder.DelegateAction) -> ())
    private var cancellables = Set<AnyCancellable>()
    
    init(
        inject: ProfileViewBuilder.DependecyInject,
        delegate: @escaping ((ProfileViewBuilder.DelegateAction) -> ())
    ) {
        self.inject = inject
        self.delegate = delegate
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            guard let profile = inject.shared.userDefault.selectionProfile else {
                self.send(action: .loadFailed)
                return
            }
            
            self.profile = DataModelConverter.shared.convert(dao: profile)
            
        case .loadFailed:
            dismiss = true
            
        case .deleteProfile:
            guard let userId = profile?.userId else { return }
            inject.useCase.deleteProfile.execute(requestId: userId)
                .sink { _ in
                    
                } receiveValue: { [weak self] _ in
                    guard let self else { return }
                    guard let profile else { return }
                    
                    let dao = DataModelConverter.shared.convert(model: profile)
                    self.inject.shared.userDefault.profiles.remove(dao)
                    self.inject.shared.userDefault.selectionProfile = nil
                    
                    if self.inject.shared.userDefault.profiles.count == 0 {
                        self.inject.coordinator.present(.onboarding)
                        
                    } else {
                        dismiss = true
                        self.delegate(.delete(profile: profile))
                        
                    }
                }
                .store(in: &cancellables)
            
        case .feedback:
            do {
                try inject.shared.openURL.feedback()
            } catch let error {
                showsAlert = true
                send(action: .alert(.feedbackFailed(error.localizedDescription)))
                alertMessage = .feedbackFailed(error.localizedDescription)
            }
            
        case let .alert(type):
            showsAlert = true
            alertMessage = type
            
        }
    }
}
