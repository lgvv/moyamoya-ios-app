import UIKit
import Lottie
import SwiftUI
import DesignSystem

struct SplashView: View {
    var body: some View {
        ZStack {
            Gradient.funchGradient(type: .black)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    DesignSystemAsset.Image.splashBgTop.swiftUIImage
                        .resizable()
                        .frame(width: 375, height: 323)
                        .offset(x: -180)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    Spacer()
                    
                    DesignSystemAsset.Image.splashBgBottom.swiftUIImage
                        .resizable()
                        .frame(width: 353, height: 303)
                        .offset(x: 135)
                }
            }
            
            LottieView(animation: .named("Funch_splash_background_ani"))
                .playing(loopMode: .playOnce)
            LottieView(animation: .named("Funch_splash_logo"))
                .playing(loopMode: .playOnce)
        }
    }
}

#Preview {
    SplashView()
}
