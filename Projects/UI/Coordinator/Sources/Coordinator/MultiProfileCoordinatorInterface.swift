import Entity

public protocol MultiProfileCoordinatorInterface {
    /// navigation 방식으로 화면전환
    func push(_ action: MultiProfileNavigationDestination)
    /// presnet 방식으로 화면전환
    func present(_ action: MultiProfilePresentationAction)
}

public enum MultiProfileNavigationDestination: Identifiable, Hashable {
    public var id: Int { hashValue }
    
    /// 프로필 생성
    case profileEdit
}

public enum MultiProfilePresentationAction: Identifiable, Hashable {
    public var id: Int { hashValue }
    
    case profileEdit
}
