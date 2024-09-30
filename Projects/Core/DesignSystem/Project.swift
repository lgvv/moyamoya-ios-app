import ProjectDescription

let project = Project(
    name: "DesignSystem",
    targets: [
        .target(
            name: "DesignSystem",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.DesignSystem",
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
            dependencies: []
        ),
        .target(
            name: "DesignSystemTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.DesignSystemTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "DesignSystem")]
        ),
    ]
)
