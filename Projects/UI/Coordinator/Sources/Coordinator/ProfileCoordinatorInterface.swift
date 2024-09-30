import Entity

public protocol ProfileCoordinatorInterface {
    /// presnet 방식으로 화면전환
    func present(_ action: ProfilePresentationAction)
}

public enum ProfilePresentationAction: Identifiable, Hashable {
    public var id: Int { hashValue }
    
    case onboarding
}

