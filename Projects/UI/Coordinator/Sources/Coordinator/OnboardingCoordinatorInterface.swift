
public protocol OnboardingCoordinatorInterface {
    /// navigation 방식으로 화면전환
    func push(_ action: OnboardingNavigationDestination)
}

public enum OnboardingNavigationDestination: Identifiable, Hashable {
    public var id: Int { hashValue }
    
    /// 프로필 생성
    case profileEdit
}
