import SwiftUI

extension String {
    public func applyColorToText(target: String, color: Color) -> AttributedString? {
        var attributedString = AttributedString(self)
        guard let range = attributedString.range(of: target) else { return nil }
        attributedString[range].foregroundColor = color
        return attributedString
    }
}
