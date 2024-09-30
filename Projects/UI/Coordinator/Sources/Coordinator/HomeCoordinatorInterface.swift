import Entity

public protocol HomeCoordinatorInterface {
    func present(_ action: HomePresentationAction)
    func push(_ action: HomeNavigationDestination)
}

public enum HomePresentationAction: Identifiable, Hashable {
    public var id: Int {
        switch self {
        case .matchingResult:
            return 1
        case .mbtiCollection:
            return 2
        case .multiProfile:
            return 3
        case .easterEgg:
            return 4
        case .myProfile:
            return 5
        case .profileEdit:
            return 6
        case .onboarding:
            return 7
        case .home:
            return 8
        }
    }
    
    case matchingResult(MatchingInfo)
    case mbtiCollection
    case multiProfile
    case easterEgg
    case myProfile
    case profileEdit
    case onboarding
    case home
}

public enum HomeNavigationDestination: Identifiable, Hashable {
    public var id: Int {
        switch self {
        case .onboarding:
            return 1
        case .profileEdit:
            return 2
        }
    }
    
    case onboarding
    case profileEdit
}
