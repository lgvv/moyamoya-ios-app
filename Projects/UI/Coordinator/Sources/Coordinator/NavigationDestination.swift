import Foundation

public enum NavigationDestination: Identifiable, Hashable {
    public var id: Int { hashValue }
    
    /// 홈
    case home
    /// 온보딩
    case onboarding
    /// 프로필 생성
    case profileEdit
}

