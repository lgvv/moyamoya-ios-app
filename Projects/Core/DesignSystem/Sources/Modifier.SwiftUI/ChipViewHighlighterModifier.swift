import SwiftUI

extension View {
    public func highlight(_ isHighlighted: Bool) -> some View {
        modifier(ChipViewHighlighterModifier(isHighlighted: isHighlighted))
    }
}

struct ChipViewHighlighterModifier: ViewModifier {
    /// highlight 여부
    private(set) var isHighlighted: Bool
    
    func body(content: Content) -> some View {
        if isHighlighted {
            content
                .shadow(color: DesignSystemAsset.Color.lemon500.swiftUIColor.opacity(0.5), radius: 2.5, x: 0, y: 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .inset(by: 0.5)
                        .stroke(Gradient.funchGradient(type: .lemon500), lineWidth: 1)
                )
        } else {
            content
        }
    }
}
