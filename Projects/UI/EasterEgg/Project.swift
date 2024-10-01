import ProjectDescription

let project = Project(
    name: "EasterEggUI",
    targets: [
        .target(
            name: "EasterEggUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.EasterEggUI",
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
                .project(target: "Coordinator", path: "../Coordinator")
            ]
        ),
        .target(
            name: "EasterEggUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.EasterEggUITests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "EasterEggUI")]
        ),
    ]
)
