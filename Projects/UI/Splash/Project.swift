import ProjectDescription

let project = Project(
    name: "SplashUI",
    targets: [
        .target(
            name: "SplashUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.SplashUI",
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
                .package(product: "Lottie"),
                .project(target: "Coordinator", path: "../Coordinator")
            ]
        ),
        .target(
            name: "SplashUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.SplashUITests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "SplashUI")]
        ),
    ]
)
