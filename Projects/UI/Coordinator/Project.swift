import ProjectDescription

let project = Project(
    name: "Coordinator",
    targets: [
        .target(
            name: "Coordinator",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.Coordinator",
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
                .project(target: "Entity", path: "../../Shared/Entity")
            ]
        ),
        .target(
            name: "CoordinatorTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.CoordinatorTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Coordinator")]
        ),
    ]
)
