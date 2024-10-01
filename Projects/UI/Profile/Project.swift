import ProjectDescription

let project = Project(
    name: "ProfileUI",
    targets: [
        .target(
            name: "ProfileUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.ProfileUI",
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
                .project(target: "ProfileFeature", path: "../../Features/Profile"),
                .project(target: "Coordinator", path: "../Coordinator")
            ]
        ),
        .target(
            name: "ProfileUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.ProfileUITests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "ProfileUI")]
        ),
    ]
)
