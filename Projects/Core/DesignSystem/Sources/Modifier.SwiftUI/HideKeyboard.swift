import SwiftUI

extension View {
    /// 레퍼런스 `https://huniroom.tistory.com/entry/SwiftUI-실전형-TextField-사용하기-예제-MVVM-FocusState-ScrollView-movemunt`
    public func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}
