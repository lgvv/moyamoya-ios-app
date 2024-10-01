import SwiftUI

/// `Funch` 서비스에서 주로 사용할 폰트 모음
public enum FunchFontFamily {
    /// `SpoqaHanSans` 폰트 모음
    public enum SpoqaHanSans {
        static let bold = "SpoqaHanSansNeo-Bold"
        static let medium = "SpoqaHanSansNeo-Medium"
        static let regular = "SpoqaHanSansNeo-Regular"
    }
}

public extension Font {
    /// 사용할 폰트 모음
    public enum Funch {
        /// weight: bold, size: 22
        public static let title1: Font = .custom(FunchFontFamily.SpoqaHanSans.bold, size: 22)
        /// weight: bold, size: 20
        public static let title2: Font = .custom(FunchFontFamily.SpoqaHanSans.bold, size: 20)
        /// weight: medium, size: 18
        public static let subtitle1: Font = .custom(FunchFontFamily.SpoqaHanSans.bold, size: 18)
        /// weight: medium, size: 16
        public static let subtitle2: Font = .custom(FunchFontFamily.SpoqaHanSans.bold, size: 16)
        /// weight: regular, size: 14
        public static let body: Font = .custom(FunchFontFamily.SpoqaHanSans.regular, size: 14)
        /// weight: regular, size: 12
        public static let caption: Font = .custom(FunchFontFamily.SpoqaHanSans.regular, size: 12)
    }
    
    /// kening 및 line height를 적용하기 위한 enum
    enum FunchDesign {
        /// weight: bold, size: 22
        case title1
        /// weight: bold, size: 20
        case title2
        /// weight: medium, size: 18
        case subtitle1
        /// weight: medium, size: 16
        case subtitle2
        /// weight: regular, size: 14
        case body
        /// weight: regular, size: 12
        case caption
        
        /// 사용하는 폰트의 `Font` 타입
        public var value: Font {
            switch self {
            case .title1:
                return .custom(FunchFontFamily.SpoqaHanSans.bold, size: 22)
            case .title2:
                return .custom(FunchFontFamily.SpoqaHanSans.bold, size: 20)
            case .subtitle1:
                return .custom(FunchFontFamily.SpoqaHanSans.bold, size: 18)
            case .subtitle2:
                return .custom(FunchFontFamily.SpoqaHanSans.bold, size: 16)
            case .body:
                return .custom(FunchFontFamily.SpoqaHanSans.regular, size: 14)
            case .caption:
                return .custom(FunchFontFamily.SpoqaHanSans.regular, size: 12)
            }
        }
        
        /// 사용하는 폰트의 size
        public var size: CGFloat {
            switch self {
            case .title1:
                return 22
            case .title2:
                return 20
            case .subtitle1:
                return 18
            case .subtitle2:
                return 16
            case .body:
                return 14
            case .caption:
                return 12
            }
        }
        
        /// 사용하는 폰트의 line height (소수점 단위)
        public var lineHeight: CGFloat {
            switch self {
            case .title1, .title2, .subtitle1, .subtitle2:
                return 1.3
            case .body, .caption:
                return 1.5
            }
        }
        
        public var kerning: CGFloat {
            switch self {
            case .title1, .title2, .subtitle1, .subtitle2:
                return -2
            case .body, .caption:
                return -3
            }
        }
    }
    
}
