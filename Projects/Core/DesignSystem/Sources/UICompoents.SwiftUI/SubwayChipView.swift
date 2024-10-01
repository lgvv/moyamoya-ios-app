import SwiftUI

public struct SubwayChipView: View {
    
    let name: String
    let lines: [String]
    
    public init(name: String, lines: [String]) {
        self.name = name
        self.lines = lines
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(name)
                .font(.Funch.body)
                .foregroundColor(.white)
            
            Spacer()
                .frame(width: 4)
            
            HStack(spacing: 2) {
                ForEach(lines, id: \.self) { line in
                    Image.findSubwayImageResource(from: line)
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 16)
        .background(DesignSystemAsset.Color.gray500.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}


