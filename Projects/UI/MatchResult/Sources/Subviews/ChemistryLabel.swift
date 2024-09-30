import Entity
import SwiftUI
import DesignSystem
import MatchingFeature

struct ChemistryLabel: View {
    
    private let chemistryData: MatchingInfo.ChemistryInfo
    
    init(info chemistryData: MatchingInfo.ChemistryInfo) {
        self.chemistryData = chemistryData
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            findChemistryImageResource(from: chemistryData.title)
                .resizable()
                .frame(width: 24, height: 24)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(chemistryData.title)
                    .font(.Funch.subtitle1)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 2)
                
                Text(chemistryData.description)
                    .font(.Funch.body)
                    .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
            }
            
            Spacer()
        }
    }
    
    private func findChemistryImageResource(from text: String) -> Image {
        typealias Asset = DesignSystemAsset.Image
        switch text {
        case "찾았다, 내 소울메이트!": return Asset.mbti1.swiftUIImage
        case "기막힌 타이밍에 등장한 너!": return Asset.mbti2.swiftUIImage
        case "끈끈한 사이로 발전할 수 있어요!": return Asset.mbti3.swiftUIImage
        case "서로를 알아가 볼까요?": return Asset.mbti4.swiftUIImage
        case "펀치가 아니면 몰랐을 사이": return Asset.mbti5.swiftUIImage
            
        case "서로 다른 점을 찾는 재미": return Asset.bloodBad.swiftUIImage
        case "안정적인 관계인 우리": return Asset.bloodSoso.swiftUIImage
        case "우리는 최강의 콤비!": return Asset.bloodGood.swiftUIImage
        case "쿵짝 쿵짜작~이 잘 맞아요": return Asset.bloodGreat.swiftUIImage
            
        default: return Asset.look.swiftUIImage
        }
    }
}

