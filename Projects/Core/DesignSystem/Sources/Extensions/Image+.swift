import SwiftUI

extension Image {
    public static func findSubwayImageResource(from text: String) -> Image {
        switch text.lowercased() {
        case SubwayLines.one.rawValue: return DesignSystemAsset.Image.subway1.swiftUIImage
        case SubwayLines.two.rawValue: return DesignSystemAsset.Image.subway2.swiftUIImage
        case SubwayLines.three.rawValue: return DesignSystemAsset.Image.subway3.swiftUIImage
        case SubwayLines.four.rawValue: return DesignSystemAsset.Image.subway4.swiftUIImage
        case SubwayLines.five.rawValue: return DesignSystemAsset.Image.subway5.swiftUIImage
        case SubwayLines.six.rawValue: return DesignSystemAsset.Image.subway6.swiftUIImage
        case SubwayLines.seven.rawValue: return DesignSystemAsset.Image.subway7.swiftUIImage
        case SubwayLines.eight.rawValue: return DesignSystemAsset.Image.subway8.swiftUIImage
        case SubwayLines.nine.rawValue: return DesignSystemAsset.Image.subway9.swiftUIImage
        case SubwayLines.seohae.rawValue: return DesignSystemAsset.Image.subwaySeohae.swiftUIImage
        case SubwayLines.airport.rawValue: return DesignSystemAsset.Image.subwayAirport.swiftUIImage
        case SubwayLines.gimpo.rawValue: return DesignSystemAsset.Image.subwayGimpoGoldline.swiftUIImage
        case SubwayLines.ui_sinseol.rawValue: return DesignSystemAsset.Image.subwayUiSinseol.swiftUIImage
        case SubwayLines.sillim.rawValue: return DesignSystemAsset.Image.subwaySillim.swiftUIImage
        case SubwayLines.youngin.rawValue: return DesignSystemAsset.Image.subwayYounginEver.swiftUIImage
        case SubwayLines.uijeongbu.rawValue: return DesignSystemAsset.Image.subwayUijeongbu.swiftUIImage
        case SubwayLines.bundang.rawValue: return DesignSystemAsset.Image.subwaySuinbundang.swiftUIImage
        case SubwayLines.gyeongchun.rawValue: return DesignSystemAsset.Image.subwayGyeongchun.swiftUIImage
        case SubwayLines.gyeongui.rawValue: return DesignSystemAsset.Image.subwayGyeonguiJungang.swiftUIImage
        case SubwayLines.gyeonggang.rawValue: return DesignSystemAsset.Image.subwayGeonggang.swiftUIImage
        case SubwayLines.incheon.rawValue: return DesignSystemAsset.Image.subwayIncheon1.swiftUIImage
        case SubwayLines.incheon_two.rawValue: return DesignSystemAsset.Image.subwayIncheon2.swiftUIImage
        case SubwayLines.sinbundang.rawValue: return DesignSystemAsset.Image.subwayShinbundang.swiftUIImage

        default: return DesignSystemAsset.Image.iconX.swiftUIImage
        }
    }
    
    public enum SubwayLines: String, RawRepresentable, CaseIterable {
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case seohae
        case airport
        case gimpo
        case ui_sinseol
        case sillim
        case youngin
        case uijeongbu
        case bundang
        case gyeongchun
        case gyeongui
        case gyeonggang
        case incheon
        case incheon_two
        case sinbundang
    }

    public static func findProfileImageResource(from text: String) -> Image {
        switch text.lowercased() {
        case "nexters": return DesignSystemAsset.Image.nexters.swiftUIImage
        case "sopt": return DesignSystemAsset.Image.sopt.swiftUIImage
        case "depromeet": return DesignSystemAsset.Image.depromeet.swiftUIImage
        case "developer": return DesignSystemAsset.Image.developer.swiftUIImage
        case "designer": return DesignSystemAsset.Image.designer.swiftUIImage
        default: return DesignSystemAsset.Image.percent1.swiftUIImage
        }
    }
}
