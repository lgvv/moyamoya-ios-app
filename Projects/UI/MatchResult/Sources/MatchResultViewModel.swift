import Entity
import SwiftUI
import Combine
import DesignSystem
import MatchingFeature

final class MatchResultViewModel: ObservableObject {
    
    @Published var similarity: Int = 0
    @Published var chemistryInfos: [MatchingInfo.ChemistryInfo] = []
    @Published var subwayChemistryInfo: MatchingInfo.ChemistryInfo?
    @Published var otherProfile: MatchingInfo.MatchProfile? = nil
    
    @Published var isEqualMajor: Bool = false
    @Published var isEqualClubs: [Bool] = [false, false]
    @Published var isEqualMBTI: Bool = false
    @Published var isEqualBloodType: Bool = false
    @Published var isEqualSubway: Bool = false
    
    enum Action {
        case distributeMatchingInfos
        case distributeOtherProfile(RowType)
        
        enum RowType {
            case major
            case clubs
            case mbti
            case bloodType
            case subway
        }
    }
    
    private let matchingInfo: MatchingInfo
    private var inject: MatchResultViewBuilder.DependecyInject
    
    init(
        inject: MatchResultViewBuilder.DependecyInject,
        matchingInfo: MatchingInfo
    ) {
        self.inject = inject
        self.matchingInfo = matchingInfo
    }
    
    func send(action: Action) {
        switch action {
        case .distributeMatchingInfos:
            similarity = matchingInfo.similarity
            chemistryInfos = matchingInfo.chemistryInfos
            subwayChemistryInfo = matchingInfo.subwayChemistryInfo
            otherProfile = matchingInfo.profile
            
            send(action: .distributeOtherProfile(.major))
            send(action: .distributeOtherProfile(.clubs))
            send(action: .distributeOtherProfile(.mbti))
            send(action: .distributeOtherProfile(.bloodType))
            send(action: .distributeOtherProfile(.subway))
            
        case let .distributeOtherProfile(type):
            let equalInfo = matchingInfo.recommendInfos.map { $0.title }
            let otherProfile = matchingInfo.profile
            
            switch type {
            case .major:
                let major = otherProfile.major
                isEqualMajor = equalInfo.contains(major)
                
            case .clubs:
                let clubs = otherProfile.clubs
                isEqualClubs = clubs.map { club in
                    equalInfo.contains(club)
                }
                
            case .mbti:
                let mbti = otherProfile.mbti
                isEqualMBTI = equalInfo.contains(mbti)
                
            case .bloodType:
                let bloodType = otherProfile.bloodType + "형"
                isEqualBloodType = equalInfo.contains(bloodType)
                
            case .subway:
                let subway = otherProfile.subwayInfos.first?.name ?? ""
                isEqualSubway = equalInfo.contains(subway)
                
            }
        }
    }
}
