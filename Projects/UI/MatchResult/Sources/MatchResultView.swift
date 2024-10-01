import SwiftUI
import SwiftUIPager
import DesignSystem

struct MatchResultView: View {
    @StateObject var viewModel: MatchResultViewModel
    @StateObject var page: Page = .first()
    
    @Environment(\.dismiss) var dismiss
    
    var viewSize: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            DesignSystemAsset.Color.gray900.swiftUIColor
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Pager(page: page, data: 0..<3, id: \.self) { pageIndex in
                    ZStack {
                        DesignSystemAsset.Color.gray800.swiftUIColor
                        
                        VStack(spacing: 0) {
                            pageIndexLabel(pageIndex)
                            
                            Spacer()
                                .frame(height: 8)
                            
                            resultView(pageIndex)
                            
                            Spacer()
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 28)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .horizontal()
                .singlePagination(ratio: 0.33, sensitivity: .custom(0.2))
                .preferredItemSize(.init(width: viewSize.width * 0.92, height: viewSize.height))
                .itemSpacing(8)
            }
            .padding(.bottom, 32)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.dismiss()
                } label: {
                    DesignSystemAsset.Image.iconX.swiftUIImage
                        .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
                }
            }
        }
        .onAppear {
            viewModel.send(action: .distributeMatchingInfos)
        }
    }
    
    /// pageIndex에 따른 결과 View
    @ViewBuilder
    private func resultView(_ pageIndex: Int) -> some View {
        switch pageIndex {
        case 0: chemistryView
        case 1: recommendationView
        case 2: matchedProfileView
        default: EmptyView()
        }
    }
    
    /// 몇 번째 페이지인지 나타내는 index label
    private func pageIndexLabel(_ index: Int) -> some View {
        HStack(spacing: 0) {
            Text("\(index + 1)")
                .foregroundColor(.white)
            Text("/3")
                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
        }
        .font(.Funch.caption)
        .padding(.vertical, 2)
        .padding(.horizontal, 8)
        .background(DesignSystemAsset.Color.gray500.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    /// 시너지 정보를 보여주는 View
    private var chemistryView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("우리는 ")
                    .foregroundColor(.white)
                Text("\(viewModel.similarity)%")
                    .foregroundStyle(Gradient.funchGradient(type: .lemon500))
                    .overlay {
                        Gradient.funchGradient(type: .lemon500)
                            .mask {
                                Text("\(viewModel.similarity)%")
                                    .foregroundStyle(Gradient.funchGradient(type: .lemon500))
                            }
                    }
                Text(" 닮았어요")
                    .foregroundColor(.white)
            }
            .font(.Funch.title2)
            
            Spacer()
                .frame(height: 16)
            
            findSynergyImageResource(from: viewModel.similarity)
                .resizable()
                .frame(minWidth: 136, maxWidth: 200, minHeight: 136, maxHeight: 200)
            
            Spacer()
                .frame(height: 16)
            
            VStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.chemistryInfos, id: \.self) { info in
                    ChemistryLabel(info: info)
                }
                
                if let subwayChemistryInfo = viewModel.subwayChemistryInfo {
                    SubwayChemistryLabel(
                        targetName: viewModel.otherProfile?.name ?? "",
                        info: subwayChemistryInfo
                    )
                }
            }
        }
    }
    
    // FIXME: 나중에 옮기면 좋을듯
    /// 추천 대화 주제 리스트
    private let recommendationList: [String] = [
        "어느 팀이세요?",
        "팀에서 어떤 서비스를 만드나요?",
        "서로의 첫인상은?",
        "가장 인상 깊었던 여행지는?",
        "취미를 소개해주세요!"
    ]
    
    /// 대화 주제 추천해주는 View
    private var recommendationView: some View {
        VStack(spacing: 0) {
            Text("우리 이런 주제로 대화해봐요")
                .font(.Funch.title2)
                .foregroundColor(.white)
            
            Spacer()
                .frame(height: 4)
            
            Text("지금부터 서로에게 집중하는 시간!")
                .font(.Funch.body)
                .foregroundColor(DesignSystemAsset.Color.gray300.swiftUIColor)
            
            VStack(spacing: 8) {
                ForEach(recommendationList, id: \.self) { recommendationText in
                    ChipView(title: recommendationText)
                }
            }
            .frame(maxHeight: .infinity)
            
            Spacer()
                .frame(height: 16)
        }
    }
    
    private var matchedProfileView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.otherProfile?.name ?? "")
                .font(.Funch.title2)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
                .frame(height: 20)
            
            VStack(alignment: .leading, spacing: 16) {
                resultRow("직군", profileRow: majorRow)
                resultRow("동아리", profileRow: clubsRow)
                resultRow("MBTI", profileRow: mbtiRow)
                resultRow("혈액형", profileRow: bloodTypeRow)
                resultRow("지하철", profileRow: subwayRow)
            }
        }
    }
    
    
    private func resultRow(_ label: String, profileRow: some View) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(label)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
                .font(.Funch.body)
                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
                .frame(width: 52, height: 48, alignment: .leading)
            
            profileRow
            
            Spacer()
        }
    }
    
    private var majorRow: some View {
        ChipView(
            title: viewModel.otherProfile?.major ?? "",
            imageName: viewModel.otherProfile?.major
        )
            .highlight(viewModel.isEqualMajor)
    }
    
    private var clubsRow: some View {
        let otherClubs = viewModel.otherProfile?.clubs
        let isEqualClub: [Bool] = viewModel.isEqualClubs
        
        return DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
            ForEach(otherClubs!.indices, id: \.self) { index in
                ChipView(
                    title: otherClubs?[index] ?? "",
                    imageName: otherClubs?[index] ?? ""
                )
                .highlight(isEqualClub[index])
            }
        }
    }
    
    private var mbtiRow: some View {
        ChipView(title: viewModel.otherProfile?.mbti ?? "")
            .highlight(viewModel.isEqualMBTI)
    }
    
    private var bloodTypeRow: some View {
        ChipView(title: viewModel.otherProfile?.bloodType ?? "" + "형")
            .highlight(viewModel.isEqualBloodType)
    }
    
    private var subwayRow: some View {
        HStack(spacing: 8) {
            ForEach(viewModel.otherProfile?.subwayInfos ?? [], id: \.self) { subway in
                SubwayChipView(name: subway.name, lines: subway.lines)
                    .highlight(viewModel.isEqualSubway)
            }
        }
    }
    
    private func findSynergyImageResource(from percentage: Int) -> Image {
        typealias Asset = DesignSystemAsset.Image
        switch percentage {
        case 0...20: return Asset.percent5.swiftUIImage
        case 21...40: return Asset.percent4.swiftUIImage
        case 41...60: return Asset.percent3.swiftUIImage
        case 61...80: return Asset.percent2.swiftUIImage
        case 81...100: return Asset.percent1.swiftUIImage
        default: return Asset.percent3.swiftUIImage
        }
    }
}
