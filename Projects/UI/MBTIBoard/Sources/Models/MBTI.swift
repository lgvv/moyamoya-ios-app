import Entity
import SwiftUI
import DesignSystem
import MBTIBoardFeature

extension MBTI {
    var image: (disabled: Image, active: Image) {
        typealias Asset = DesignSystemAsset.Image
        switch self {
        case MBTI.infp: return (Asset.infpDisabled.swiftUIImage, Asset.infpActive.swiftUIImage)
        case MBTI.infj: return (Asset.infjDisabled.swiftUIImage, Asset.infjActive.swiftUIImage)
        case MBTI.intp: return (Asset.intpDisabled.swiftUIImage, Asset.intpActive.swiftUIImage)
        case MBTI.intj: return (Asset.intjDisabled.swiftUIImage, Asset.intjActive.swiftUIImage)
        case MBTI.istp: return (Asset.istpDisabled.swiftUIImage, Asset.istpActive.swiftUIImage)
        case MBTI.istj: return (Asset.istjDisabled.swiftUIImage, Asset.istjActive.swiftUIImage)
        case MBTI.isfp: return (Asset.isfpDisabled.swiftUIImage, Asset.isfpActive.swiftUIImage)
        case MBTI.isfj: return (Asset.isfjDisabled.swiftUIImage, Asset.isfjActive.swiftUIImage)
        case MBTI.enfp: return (Asset.enfpDisabled.swiftUIImage, Asset.enfpActive.swiftUIImage)
        case MBTI.enfj: return (Asset.enfjDisabled.swiftUIImage, Asset.enfjActive.swiftUIImage)
        case MBTI.entp: return (Asset.entpDisabled.swiftUIImage, Asset.entpActive.swiftUIImage)
        case MBTI.entj: return (Asset.entjDisabled.swiftUIImage, Asset.entjActive.swiftUIImage)
        case MBTI.estp: return (Asset.estpDisabled.swiftUIImage, Asset.estpActive.swiftUIImage)
        case MBTI.estj: return (Asset.estjDisabled.swiftUIImage, Asset.estjActive.swiftUIImage)
        case MBTI.esfp: return (Asset.esfpDisabled.swiftUIImage, Asset.esfpActive.swiftUIImage)
        case MBTI.esfj: return (Asset.esfjDisabled.swiftUIImage, Asset.esfjActive.swiftUIImage)
        }
    }
}
