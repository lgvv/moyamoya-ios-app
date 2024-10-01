import ProjectDescription

let project = Project(
    name: "MBTIBoardUI",
    targets: [
        .target(
            name: "MBTIBoardUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.MBTIBoardUI",
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
                .project(target: "MBTIBoardFeature", path: "../../Features/MBTIBoard"),
                .project(target: "Coordinator", path: "../Coordinator")
            ]
        ),
        .target(
            name: "MBTIBoardUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.MBTIBoardUITests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "MBTIBoardUI")]
        ),
    ]
)
