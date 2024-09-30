import Entity
import SwiftUI
import Combine
import Coordinator
import OpenURLClient
import ProfileFeature
import MatchingFeature
import UserDefaultClient

final class HomeViewModel: ObservableObject {
    
    enum Action {
        case load
        case matching
        case saveMBTI(String)
        
        case feedback
        case appstore
        case releaseNote
        case update
        
        case presentation(Coordinator.HomePresentationAction)
        case alert(AlertAction)
        
        public enum PresentationAction: Hashable, Identifiable {
            public var id: Int { hashValue }
            
            case profile
            case matchResult(MatchingInfo)
            case mbtiCollection
            case easterEgg
            case multiProfile
        }
        
        enum AlertAction {
            case failedMatchingProfile(String)
            case failedFeedback(String)
        }
    }
    
    /// 코드 검색 텍스트 필드
    @Published var searchCodeText: String = ""
    /// 내 프로필
    @Published var profile: Profile?
    
    // MARK: - Alert
    @Published var showsAlert: Bool = false
    
    private(set) var alertMessage: Action.AlertAction?
    private(set) var shareLink = ShareLink()
    
    /// 외부에 공유하기 기능
    struct ShareLink {
        var item = OpenURLStringSet.appstore.rawValue
        
        func message(userCode: String) -> Text {
            let string = """
            
            너랑나랑 펀치할래?
            
            🌱 초대코드: \(userCode)
            """
            
            return Text(string)
        }
    }
   
    private var inject: HomeViewBuilder.DependecyInject
    private var delegate: (HomeViewBuilder.DelegateAction) -> ()
    private var cancellables = Set<AnyCancellable>()
    
    init(
        inject: HomeViewBuilder.DependecyInject,
        delegate: @escaping (HomeViewBuilder.DelegateAction) -> ()
    ) {
        self.inject = inject
        self.delegate = delegate
        
        bind()
    }
    
    private func bind() {
        inject.sideEffect?
            .sink { [weak self] effect in
                guard let self else { return }
                
                switch effect {
                case .didChange:
                    self.send(action: .load)
                    
                case .delete:
                    self.send(action: .load)
                }
                
            }.store(in: &cancellables)
    }

    func send(action: Action) {
        switch action {
        case .load:
            if !inject.shared.userDefault.profiles.isEmpty {
                // 멀티 프로필이 하나라도 존재한다면
                
                if inject.shared.userDefault.selectionProfile == nil {
                    // 프로필이 삭제되었다면
                    let random = inject.shared.userDefault.profiles.randomElement()
                    inject.shared.userDefault.selectionProfile = random
                    
                    self.profile = DataModelConverter.shared.convert(dao: random!)
                    
                } else if inject.shared.userDefault.selectionProfile?.userCode != profile?.userCode {
                    // 유저코드가 변경되었다면
                    let dao = inject.shared.userDefault.selectionProfile
                    self.profile = DataModelConverter.shared.convert(dao: dao!)
                    
                    fetchProfile()
                }
            } else {
                fetchProfile()
            }
            
        case .matching:
            guard let profile else { return }
            guard searchCodeText.count == 4 else { return }
            
            guard searchCodeText != profile.userCode else {
                self.send(action: .presentation(.easterEgg))
                return
            }
            
            let query = MatchingUserQuery(
                requestId: "profile.userId",
                targetUserCode: searchCodeText
            )
            
            Task { [weak self] in
                guard let self else { return }
                let result = await inject.useCase.matching.load(query: query)
                
                switch result {
                case let .success(matchingInfo):
                    self.inject.coordinator.present(.matchingResult(matchingInfo))
                    self.send(action: .saveMBTI(matchingInfo.profile.mbti))
                    
                case .failure:
                    self.send(action: .alert(.failedMatchingProfile("프로필 조회에 실패했어요.")))
                }
            }
            
        case let .saveMBTI(mbti):
            inject.useCase.mbtiBoard.save(mbti: mbti)
            
        case .feedback:
            do {
                try inject.shared.openURL.feedback()
            } catch let error {
                self.send(action: .alert(.failedFeedback(error.localizedDescription)))
            }
            
        case .appstore:
            do {
                try inject.shared.openURL.appstore()
            } catch {
                
            }
            
        case .releaseNote:
            do {
                try inject.shared.openURL.releaseNote()
            } catch {
                
            }
            
        case .update:
            
            break
            
        case let .presentation(presentation):
            self.inject.coordinator.present(presentation)
            
        case let .alert(type):
            showsAlert = true
            alertMessage = type
            
        }
    }
    
    private func fetchProfile() {
        let query: FetchUserQuery = .init(
            id: inject.shared.userDefault.selectionProfile?.userId ?? ""
        )
        inject.useCase.fetchProfile.fetchProfileFromId(query: query)
            .sink { _ in

            } receiveValue: { [weak self] profile in
                guard let self else { return }
                self.profile = profile
            }.store(in: &cancellables)
    }
}

//
//extension HomeViewModel: ProfileViewDelegate {
//    func delete(profile: Profile) {
//        self.send(action: .load)
//    }
//}
//
//extension HomeViewModel: MultiProfileListDelegate {
//    func change(profile: Profile) {
//        self.send(action: .load)
//    }
//}
//
