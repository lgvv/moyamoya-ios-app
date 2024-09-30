import Entity
import SwiftUI
import MatchingFeature

public struct MatchResultViewBuilder {
    
    private var inject: DependecyInject
    
    /// 매칭된 타인의 프로필
    private var matchingInfo: MatchingInfo
    
    public init(
        inject: DependecyInject,
        matchingInfo: MatchingInfo
    ) {
        self.inject = inject
        self.matchingInfo = matchingInfo
    }
    
    public var body: some View {
        let viewModel = MatchResultViewModel(
            inject: inject,
            matchingInfo: matchingInfo
        )
        let view = MatchResultView(viewModel: viewModel)
        
        return view
    }
    
    public struct DependecyInject {
        public init() {}
    }
}
