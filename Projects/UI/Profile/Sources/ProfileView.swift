import Entity
import SwiftUI
import DesignSystem
import ProfileFeature

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            DesignSystemAsset.Color.gray900.swiftUIColor
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: 8)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        if let profile = viewModel.profile {
                            profileView(profile)
                        } else {
                            Text("프로필을 불러오는 중이에요.")
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                    .background(DesignSystemAsset.Color.gray800.swiftUIColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 24)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    deleteUserButton
                    
                    Spacer()
                        .frame(height: 30)
                }
            }
        }
        .alert("", isPresented: $viewModel.showsAlert) {
            switch viewModel.alertMessage {
            case .deleteProile:
                Button(role: .cancel) {
                    
                } label: {
                    Text("취소하기")
                }
                
                Button(role: .destructive) {
                    viewModel.send(action: .deleteProfile)
                } label: {
                    Text("삭제하기")
                }
                
            case .feedbackFailed(_):
                Button(role: .cancel) {
                    
                } label: {
                    Text("OK")
                }
                
            case .none:
                EmptyView()
            }
            
        } message: {
            switch viewModel.alertMessage {
            case .deleteProile:
                Text("기존 프로필이 삭제되고 복구가 불가능해요.\n정말 삭제하실 건가요?")
            case let .feedbackFailed(message):
                Text(message)
            case .none:
                EmptyView()
            }
        }
        .onAppear {
            viewModel.send(action: .load)
        }
        .onReceive(viewModel.$dismiss) { boolean in
            if boolean {
                dismiss()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.send(action: .feedback)
                } label: {
                    Text("피드백 보내기")
                        .foregroundColor(.white)
                        .customFont(.body)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    DesignSystemAsset.Image.iconX.swiftUIImage
                        .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
                }
            }
        }
        .toolbarBackground(
            DesignSystemAsset.Color.gray900.swiftUIColor,
            for: .navigationBar
        )
    }
    
    private func profileView(_ profile: Profile) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(profile.userCode)
                .font(.Funch.body)
                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
            
            Spacer()
                .frame(height: 2)
            
            Text(profile.userNickname)
                .font(.Funch.title2)
                .foregroundColor(.white)
            
            Spacer()
                .frame(height: 20)
            
            VStack(alignment: .leading, spacing: 16) {
                profileRow("직군") {
                    ChipView(title: profile.majors[0].name,
                             imageName: profile.majors[0].imageName)
                }
                
                profileRow("동아리") {
                    DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
                        ForEach(profile.clubs, id: \.self) { club in
                            ChipView(title: club.name, imageName: club.imageName)
                        }
                    }
                }
                
                profileRow("MBTI") {
                    ChipView(title: profile.mbti)
                }
                
                profileRow("혈액형") {
                    ChipView(title: profile.bloodType + "형")
                }
                
                profileRow("지하철") {
                    SubwayChipView(
                        name: profile.subwayInfos.first?.name ?? "",
                        lines: profile.subwayInfos.first?.lines ?? []
                    )
                }
            }
        }
    }
    
    private func profileRow(_ label: String, row profileRow: () -> some View) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(label)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
                .font(.Funch.body)
                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
                .frame(width: 52, height: 48, alignment: .leading)
            
            profileRow()
            
            Spacer()
        }
    }
    
    private var deleteUserButton: some View {
        Button {
            viewModel.send(action: .alert(.deleteProile))
        } label: {
            Text("프로필 삭제하기")
                .font(.Funch.body)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity)
        }
        .padding(.horizontal, 12)
        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
        .frame(height: 36)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
