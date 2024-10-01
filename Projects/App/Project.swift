import ProjectDescription

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "funch.App",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "DesignSystem", path: "../Core/DesignSystem"),
                .project(target: "Coordinator", path: "../UI/Coordinator"),
                .project(target: "UserDefaultClient", path: "../Shared/UserDefaultClient"),
                .project(target: "SplashUI", path: "../UI/Splash"),
                .project(target: "OnboardingUI", path: "../UI/Onboarding"),
                .project(target: "HomeUI", path: "../UI/Home"),
                .project(target: "ProfileEditUI", path: "../UI/ProfileEdit"),
                .project(target: "ProfileUI", path: "../UI/Profile"),
                .project(target: "MatchResultUI", path: "../UI/MatchResult"),
                .project(target: "MBTIBoardUI", path: "../UI/MBTIBoard"),
                .project(target: "EasterEggUI", path: "../UI/EasterEgg"),
                .project(target: "MultiProfileUI", path: "../UI/MultiProfile"),
            ]
        ),
        .target(
            name: "AppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.AppTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "App")]
        ),
    ]
)
