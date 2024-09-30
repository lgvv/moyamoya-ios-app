import ProjectDescription

let project = Project(
    name: "OnboardingUI",
    targets: [
        .target(
            name: "OnboardingUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.OnboardingUI",
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
                .project(target: "DesignSystem", path: "../../Core/DesignSystem"),
                .project(target: "Coordinator", path: "../Coordinator")
            ]
        ),
        .target(
            name: "OnboardingUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.OnboardingUITests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "OnboardingUI")]
        ),
    ]
)
