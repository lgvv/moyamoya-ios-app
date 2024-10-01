import ProjectDescription

let project = Project(
    name: "MultiProfileUI",
    targets: [
        .target(
            name: "MultiProfileUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.MultiProfileUI",
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
                .project(target: "OpenURLClient", path: "../../Shared/OpenURLClient"),
                .project(target: "UserDefaultClient", path: "../../Shared/UserDefaultClient"),
                .project(target: "ProfileFeature", path: "../../Features/Profile"),
                .project(target: "Coordinator", path: "../Coordinator")
            ]
        ),
        .target(
            name: "MultiProfileUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.MultiProfileUITests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "MultiProfileUI")]
        ),
    ]
)
