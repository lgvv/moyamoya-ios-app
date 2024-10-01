import Entity
import SwiftUI
import DesignSystem
import MBTIBoardFeature
import UserDefaultClient

struct MBTIBoardView: View {
    @StateObject var viewModel: MBTIBoardViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            DesignSystemAsset.Color.gray900.swiftUIColor
                .ignoresSafeArea(.all)
            
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: 8)
                    
                    Text("수집 도감")
                        .font(.Funch.title2)
                        .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Text("해당 기기에서 매칭한 친구들이에요!")
                        .font(.Funch.body)
                        .foregroundColor(DesignSystemAsset.Color.gray300.swiftUIColor)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Text("MBTI")
                        .font(.Funch.subtitle2)
                        .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
                    
                    Spacer()
                        .frame(height: 12)
                    
                    LazyVGrid(columns: [.init(.adaptive(minimum: 74))]) {
                        ForEach(viewModel.mbtiTiles, id: \.0) { (mbti, opacity) in
                            boardCell(mbti, opacity: opacity)
                                .frame(width: (geometry.size.width - 40 - 24) / 4,
                                       height: (geometry.size.width - 40 - 24) / 4)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    DesignSystemAsset.Image.iconX.swiftUIImage
                        .foregroundColor(.black)
                }
            }
        }
        .toolbarBackground(
            DesignSystemAsset.Color.gray900.swiftUIColor,
            for: .navigationBar
        )
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            viewModel.send(action: .load)
        }
    }
    
    private func boardCell(_ mbti: String, opacity: CGFloat) -> some View {
        let asset = MBTI(rawValue: mbti.lowercased())?.image
        
        return VStack {
            if opacity == 0 {
                asset?.disabled
            } else {
                asset?.active
                    .opacity(opacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
    }
}
