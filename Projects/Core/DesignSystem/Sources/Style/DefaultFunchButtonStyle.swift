import SwiftUI

extension ButtonStyle where Self == DefaultFunchButtonStyle {
    /// 앱 내에서 사용하는 기본 펀치 스타일
    public static func funch(isEnabled: Bool) -> Self {
        return DefaultFunchButtonStyle(isEnabled: isEnabled)
    }
}

/// 우리 앱에서 사용하는  `기본` 버튼 스타일
public struct DefaultFunchButtonStyle: ButtonStyle {
    /// 버튼 클릭 여부에 따른 fade 여부
    var fadeOnPress = true
    var isEnabled = false
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                isEnabled
                ? DesignSystemAsset.Color.lemon500.swiftUIColor
                : DesignSystemAsset.Color.lemon900.swiftUIColor
            )
            .opacity(configuration.isPressed && fadeOnPress ? 0.75 : 1)
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
