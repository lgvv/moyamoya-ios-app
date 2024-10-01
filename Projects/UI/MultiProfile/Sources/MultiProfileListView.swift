import SwiftUI
import DesignSystem

struct MultiProfileListView: View {
    @StateObject var viewModel: MultiProfileListViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            DesignSystemAsset.Color.gray900.swiftUIColor
                .ignoresSafeArea()
            
            if viewModel.profiles.isEmpty {
                Text("아직 프로필이 없어요.")
                    .font(.Funch.title1)
                    .foregroundStyle(.white)
            } else {
                List(viewModel.profiles, id: \.userCode) { profile in
                    HStack {
                        VStack(alignment: .leading,
                               spacing: 0) {
                            
                            Text(profile.userCode)
                                .font(.Funch.title1)
                                .foregroundStyle(.white)
                                .padding(.bottom, 8)
                            
                            Text("닉네임 " + profile.userNickname)
                                .font(.Funch.body)
                                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
                                .padding(.bottom, 4)
                            
                            Text("조회수 " + profile.viewerShip)
                                .font(.Funch.body)
                                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
                        }
                        
                        Spacer()
                        
                        if viewModel.selection == profile {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.send(action: .selection(profile))
                    }
                    .listRowBackground(
                        viewModel.selection == profile
                        ? DesignSystemAsset.Color.lemon500.swiftUIColor
                        : DesignSystemAsset.Color.gray800.swiftUIColor
                    )
                }
                .scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            viewModel.send(action: .load)
        }
        .onReceive(viewModel.$dismiss) { isDismiss in
            if isDismiss { dismiss() }
        }
        .toolbarBackground(
            DesignSystemAsset.Color.gray900.swiftUIColor,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.send(action: .dismiss)
                } label: {
                    DesignSystemAsset.Image.iconX.swiftUIImage
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.send(action: .push(.profileEdit))
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(DesignSystemAsset.Color.lemon500.swiftUIColor)
                }
            }
        }
    }
}
