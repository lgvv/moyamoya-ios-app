import ProjectDescription

let project = Project(
    name: "MatchResultUI",
    targets: [
        .target(
            name: "MatchResultUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.MatchResultUI",
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
                .package(product: "SwiftUIPager"),
                .project(target: "DesignSystem", path: "../../Core/DesignSystem"),
                .project(target: "OpenURLClient", path: "../../Shared/OpenURLClient"),
                .project(target: "MatchingFeature", path: "../../Features/Matching"),
                .project(target: "Coordinator", path: "../Coordinator")
            ]
        ),
        .target(
            name: "MatchResultUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.MatchResultUITests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "MatchResultUI")]
        ),
    ]
)
