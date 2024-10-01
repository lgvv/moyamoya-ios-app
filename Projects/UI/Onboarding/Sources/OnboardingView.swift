import SwiftUI
import Coordinator
import DesignSystem

struct OnboardingView: View {
    
    var inject: OnboardingViewBuilder.DependecyInject
    
    init(inject: OnboardingViewBuilder.DependecyInject) {
        self.inject = inject
    }
    
    var body: some View {
        ZStack {
            DesignSystemAsset.Color.gray900.swiftUIColor
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("친구와 프로필 매칭하기")
                    .font(.Funch.body)
                    .foregroundColor(DesignSystemAsset.Color.gray300.swiftUIColor)
                
                Spacer()
                    .frame(height: 2)
                
                Text("우리 사이의 공통점을 찾아요")
                    .font(.Funch.title1)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 28)
                
                DesignSystemAsset.Image.onboarding.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 76)
                
                Spacer()
                    .frame(height: 28)
                
                Text("1분만에 프로필 만들고 매칭해보기")
                    .font(.Funch.body)
                    .foregroundColor(DesignSystemAsset.Color.gray300.swiftUIColor)
                
                Spacer()
                    .frame(height: 8)
                
                Button {
                    inject.coordinator.push(.profileEdit)
                } label: {
                    Text("프로필 생성 시작🚀")
                        .font(.Funch.subtitle2)
                        .foregroundColor(DesignSystemAsset.Color.gray900.swiftUIColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 172, height: 52)
                .background(Gradient.funchGradient(type: .lemon500))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(
                    color: DesignSystemAsset.Color.lemon500.swiftUIColor.opacity(0.7),
                    radius: 4, x: 0, y: 4
                )
            }
        }
        .ignoresSafeArea(.all)
    }
}
