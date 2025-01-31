import SwiftUI

public struct ChipButton: View {
    
    enum ViewType {
        /// 텍스트
        case text
        /// 이미지 + 텍스트
        case image
        
        /// 어떤 view인지에 따른 가로 padding
        var verticalPadding: CGFloat {
            switch self {
            case .text: 12
            case .image: 8
            }
        }
        
        /// 어떤 view인지에 따른 세로 padding
        var horizontalPadding: CGFloat {
            switch self {
            case .text: 16
            case .image: 8
            }
        }
    }
    
    
    /// 칩 뷰 타입
    private(set) var type: ViewType
    
    public init(action: @escaping () -> Void,
         title: String,
         imageName: String? = nil,
         isSelected: Bool
    ) {
        self.action = action
        self.title = title
        self.isSelected = isSelected
        
        if let imageName = imageName {
            self.type = .image
            self.imageName = imageName
        } else {
            self.type = .text
            self.imageName = ""
        }
    }
    
    /// 터치 액션
    var action: () -> Void
    /// 선택됐는지를 나타내는 State
    var isSelected: Bool
    /// 타이틀
    var title: String = ""
    /// 리소스 이름
    var imageName: String = ""
    
    
    public var body: some View {
        Button {
            action()
        } label: {
            buttonInnerView
        }
        .buttonStyle(NoTapEffectButtonStyle())
        .tint(.white)
        .padding(.vertical, type.verticalPadding)
        .padding(.horizontal, type.horizontalPadding)
        .padding(.trailing, type == .image ? 8 : 0)
        .background(
            isSelected
            ? DesignSystemAsset.Color.gray500.swiftUIColor
            : DesignSystemAsset.Color.gray800.swiftUIColor
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder
    private var buttonInnerView: some View {
        switch type {
        case .text:
            Text(title)
                .foregroundColor(
                    isSelected
                    ? .white
                    : DesignSystemAsset.Color.gray400.swiftUIColor
                )
                .customFont(.subtitle2)
                .frame(width: 16, height: 24)
            
        case .image:
            HStack {
                VStack {
                    Image.findProfileImageResource(from: imageName)
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                .frame(width: 32, height: 32)
                .background(DesignSystemAsset.Color.gray900.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(title)
                    .foregroundColor(isSelected ? .white : DesignSystemAsset.Color.gray400.swiftUIColor)
                    .customFont(.body)
            }
        }
    }
}
