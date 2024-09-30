import SwiftUI

/// Funch 앱에서 사용하는 Gradient 모음
///
/// 사용하기 위해서는 `Gradient.funchGradient(type:)` 메소드 사용
public enum FunchGradient {
    case lemon500
    case lemon600
    case lemon900
    case gray300
    case gray900
    case black
    
    /// 들어가는 색상들
    public var stops: [Gradient.Stop] {
        switch self {
        case .lemon500:
            return [.init(color: DesignSystemAsset.Color.gradientLemon5001.swiftUIColor, location: 0.00),
                    .init(color: DesignSystemAsset.Color.gradientLemon5002.swiftUIColor, location: 1.00)]
        case .lemon600:
            return [.init(color: DesignSystemAsset.Color.gradientLemon6001.swiftUIColor, location: 0.00),
                    .init(color: DesignSystemAsset.Color.gradientLemon6001.swiftUIColor, location: 1.00)]
        case .lemon900:
            return [.init(color: DesignSystemAsset.Color.gradientLemon9001.swiftUIColor, location: 0.00),
                    .init(color: DesignSystemAsset.Color.gradientLemon9002.swiftUIColor, location: 1.00)]
        case .gray300:
            return [.init(color: DesignSystemAsset.Color.gradientGray3001.swiftUIColor, location: 0.00),
                    .init(color: DesignSystemAsset.Color.gradientGray3002.swiftUIColor, location: 1.00)]
        case .gray900:
            return [.init(color: DesignSystemAsset.Color.gradientGray9001.swiftUIColor, location: 0.00),
                    .init(color: DesignSystemAsset.Color.gradientGray9002.swiftUIColor, location: 1.00)]
        case .black:
            return [.init(color: DesignSystemAsset.Color.gradientBlack1.swiftUIColor, location: 0.61),
                    .init(color: DesignSystemAsset.Color.gradientBlack2.swiftUIColor, location: 1.00)]
        }
    }
    
    /// 시작 지점
    public var startPoint: UnitPoint {
        switch self {
        case .lemon500: return .init(x: 0, y: 0.5)
        case .lemon600: return .init(x: 0, y: 0.5)
        case .lemon900: return .init(x: 0.5, y: 0)
        case .gray300: return .init(x: 0.5, y: 0.97)
        case .gray900: return .init(x: 0.5, y: 0)
        case .black: return .init(x: 0.5, y: 0)
        }
    }
    
    /// 끝나는 지점
    public var endPoint: UnitPoint {
        switch self {
        case .lemon500: return .init(x: 1, y: 0.5)
        case .lemon600: return .init(x: 1, y: 0.5)
        case .lemon900: return .init(x: 0.5, y: 0.86)
        case .gray300: return .init(x: 0.5, y: 1)
        case .gray900: return .init(x: 0.5, y: 0.06)
        case .black: return .init(x: 0.5, y: 1)
        }
    }
}

extension Gradient {
    /// funch gradient를 return 하는 함수
    ///
    /// 새로운 gradient를 만들기 위해서는 `FunchGradient` 에 값들 추가 필요
    public static func funchGradient(type: FunchGradient) -> LinearGradient {
        .init(stops: type.stops,
              startPoint: type.startPoint,
              endPoint: type.endPoint)
    }
}
