public protocol ProfileEditCoordinatorInterface {
    /// presnet 방식으로 화면전환
    func present(_ action: ProfileEditPresentationAction)
}

public enum ProfileEditPresentationAction: Identifiable, Hashable {
    public var id: Int { hashValue }
    
    case home
}
