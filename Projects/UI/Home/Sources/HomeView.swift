import SwiftUI
import FunchCore
import DesignSystem
import OpenURLClient
import ProfileFeature
import MatchingFeature
import MBTIBoardFeature
import UserDefaultClient

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            DesignSystemAsset.Color.gray900.swiftUIColor
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                codeSearchView
                    .padding(.top, 8)
                
                Spacer()
                    .frame(height: 8)
                
                HStack(spacing: 0) {
                    myCodeView
                    Spacer()
                        .frame(width: 8)
                    Button {
                        viewModel.send(action: .presentation(.myProfile))
                    } label: {
                        myProfileView
                    }
                }
                
                Spacer()
                    .frame(height: 8)
                
                lookupCountView
                
                Spacer()
                    .frame(height: 8)
                
                HStack(spacing: 0) {
                    Button {
                        viewModel.send(action: .presentation(.mbtiCollection))
                    } label: {
                        mbtiBoardView
                    }
                    .padding(.trailing, 8)
                    
                    Button {
                        viewModel.send(action: .appstore)
                    } label: {
                        appstoreView
                    }
                    .padding(.trailing, 8)
                    
                    Button {
                        viewModel.send(action: .releaseNote)
                    } label: {
                        releaseNoteView
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .alert("", isPresented: $viewModel.showsAlert, actions: {
            switch viewModel.alertMessage {
            case .failedMatchingProfile(_):
                Button(role: .cancel) {
                } label: {
                    Text("OK")
                }
            case .failedFeedback(_):
                Button(role: .cancel) {
                } label: {
                    Text("OK")
                }
            case .none:
                EmptyView()
            }
        }, message: {
            switch viewModel.alertMessage {
            case let .failedMatchingProfile(message):
                Text(message)
            case let .failedFeedback(message):
                Text(message)
            case .none:
                EmptyView()
            }
        })
        .onAppear {
            viewModel.send(action: .load)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    viewModel.send(action: .presentation(.multiProfile))
                } label: {
                    Image(systemName: "person.2")
                        .resizable()
                        .foregroundColor(DesignSystemAsset.Color.lemon500.swiftUIColor)
                }
                
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
        }
    }
    
    /// 코드 검색영역
    private var codeSearchView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("우리는 잘 맞을까?")
                .font(.Funch.title2)
                .foregroundColor(.white)
            
            Spacer()
                .frame(height: 2)
            
            Text("궁합부터 공통점까지 다양한 정보가 기다려요!")
                .font(.Funch.body)
                .foregroundColor(DesignSystemAsset.Color.gray300.swiftUIColor)
            
            Spacer()
                .frame(height: 16)
            
            FunchTextField(
                text: $viewModel.searchCodeText,
                placeholderText: "친구 코드를 입력하고 매칭하기",
                backgroundColor: DesignSystemAsset.Color.gray700.swiftUIColor,
                trailingButtonImage: DesignSystemAsset.Image.iconSearchYellow.swiftUIImage,
                onTapButton: {
                    viewModel.send(action: .matching)
                }
            )
        }
        .padding(.horizontal, 16)
        .frame(height: 178)
        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Gradient.funchGradient(type: .lemon500), lineWidth: 1.0)
        }
    }
    
    /// 내 코드가 나타나는 영역
    private var myCodeView: some View {
        HStack(spacing: 0) {
            DesignSystemAsset.Image.homeCode.swiftUIImage
                .resizable()
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("나의 코드")
                    .font(.Funch.body)
                    .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
                
                Text(viewModel.profile?.userCode ?? "----")
                    .font(.Funch.subtitle2)
                    .overlay {
                        Gradient.funchGradient(type: .lemon500)
                            .mask {
                                Text(viewModel.profile?.userCode ?? "----")
                                    .font(.Funch.subtitle2)
                            }
                    }
            }
            
            Spacer()
            
            ShareLink(
                item: viewModel.shareLink.item,
                message: viewModel.shareLink.message(userCode: viewModel.profile?.userCode ?? "")
            ) {
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(DesignSystemAsset.Color.lemon500.swiftUIColor)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 92)
        .frame(maxWidth: .infinity)
        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    /// 내 프로필 영역
    private var myProfileView: some View {
        VStack(spacing: 0) {
            DesignSystemAsset.Image.profile.swiftUIImage
                .resizable()
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(height: 8)
            
            Text("내 프로필")
                .font(.Funch.body)
                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
        }
        .frame(width: 101, height: 92)
        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    /// 프로필 조회수 영역
    private var lookupCountView: some View {
        HStack(spacing: 0) {
            DesignSystemAsset.Image.look.swiftUIImage
                .resizable()
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("내 프로필을")
                    .font(.Funch.body)
                    .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
                
                Text("\(viewModel.profile?.viewerShip ?? "00")명이 조회했어요.")
                    .font(.Funch.subtitle2)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 92)
        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .frame(maxWidth: .infinity)
    }
    
    private var mbtiBoardView: some View {
        VStack(spacing: 0) {
            DesignSystemAsset.Image.iconMatching.swiftUIImage
                .resizable()
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(height: 8)
            
            Text("MBTI 컬렉션")
                .font(.Funch.body)
                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
        }
        .frame(width: 101, height: 92)
        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    private var appstoreView: some View {
        VStack(spacing: 0) {
            Text("🌐")
                .font(.system(size: 40))
            
            Spacer()
                .frame(height: 8)
            
            Text("리뷰 남기러가기")
                .font(.Funch.body)
                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
        }
        .frame(height: 92)
        .frame(maxWidth: .infinity)
        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    private var releaseNoteView: some View {
        VStack(spacing: 0) {
            Text("🚀")
                .font(.system(size: 40))
            
            Spacer()
                .frame(height: 8)
            
            Text("릴리즈노트")
                .font(.Funch.body)
                .foregroundColor(DesignSystemAsset.Color.gray400.swiftUIColor)
        }
        .frame(width: 101, height: 92)
        .background(DesignSystemAsset.Color.gray800.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
}
