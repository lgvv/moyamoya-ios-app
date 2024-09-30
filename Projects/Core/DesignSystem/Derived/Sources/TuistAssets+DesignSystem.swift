// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum DesignSystemAsset: Sendable {
  public enum Color {
  public static let coral500 = DesignSystemColors(name: "coral500")
    public static let gradientBlack1 = DesignSystemColors(name: "gradientBlack_1")
    public static let gradientBlack2 = DesignSystemColors(name: "gradientBlack_2")
    public static let gradientGray3001 = DesignSystemColors(name: "gradientGray300_1")
    public static let gradientGray3002 = DesignSystemColors(name: "gradientGray300_2")
    public static let gradientGray9001 = DesignSystemColors(name: "gradientGray900_1")
    public static let gradientGray9002 = DesignSystemColors(name: "gradientGray900_2")
    public static let gradientLemon5001 = DesignSystemColors(name: "gradientLemon500_1")
    public static let gradientLemon5002 = DesignSystemColors(name: "gradientLemon500_2")
    public static let gradientLemon6001 = DesignSystemColors(name: "gradientLemon600_1")
    public static let gradientLemon6002 = DesignSystemColors(name: "gradientLemon600_2")
    public static let gradientLemon9001 = DesignSystemColors(name: "gradientLemon900_1")
    public static let gradientLemon9002 = DesignSystemColors(name: "gradientLemon900_2")
    public static let gray300 = DesignSystemColors(name: "gray300")
    public static let gray400 = DesignSystemColors(name: "gray400")
    public static let gray500 = DesignSystemColors(name: "gray500")
    public static let gray600 = DesignSystemColors(name: "gray600")
    public static let gray700 = DesignSystemColors(name: "gray700")
    public static let gray800 = DesignSystemColors(name: "gray800")
    public static let gray900 = DesignSystemColors(name: "gray900")
    public static let lemon500 = DesignSystemColors(name: "lemon500")
    public static let lemon600 = DesignSystemColors(name: "lemon600")
    public static let lemon900 = DesignSystemColors(name: "lemon900")
    public static let yellow500 = DesignSystemColors(name: "yellow500")
    public static let yellow600 = DesignSystemColors(name: "yellow600")
  }
  public enum Image {
  public static let depromeet = DesignSystemImages(name: "depromeet")
    public static let nexters = DesignSystemImages(name: "nexters")
    public static let sopt = DesignSystemImages(name: "sopt")
    public static let iconArrowBack = DesignSystemImages(name: "icon_arrow_back")
    public static let iconArrowDiagonal = DesignSystemImages(name: "icon_arrow_diagonal")
    public static let iconArrowDown = DesignSystemImages(name: "icon_arrow_down")
    public static let iconArrowLeftRight = DesignSystemImages(name: "icon_arrow_left_right")
    public static let iconArrowLeftSmall = DesignSystemImages(name: "icon_arrow_left_small")
    public static let iconArrowRight = DesignSystemImages(name: "icon_arrow_right")
    public static let iconArrowRightSmall = DesignSystemImages(name: "icon_arrow_right_small")
    public static let iconArrowUp = DesignSystemImages(name: "icon_arrow_up")
    public static let iconArrowUpLimit = DesignSystemImages(name: "icon_arrow_up_limit")
    public static let iconExclamationCircleRed = DesignSystemImages(name: "icon_exclamation_circle_red")
    public static let iconInformation = DesignSystemImages(name: "icon_information")
    public static let iconMatching = DesignSystemImages(name: "icon_matching")
    public static let iconMinus = DesignSystemImages(name: "icon_minus")
    public static let iconSearch = DesignSystemImages(name: "icon_search")
    public static let iconSearchYellow = DesignSystemImages(name: "icon_search_yellow")
    public static let iconX = DesignSystemImages(name: "icon_x")
    public static let bloodBad = DesignSystemImages(name: "blood_bad")
    public static let bloodGood = DesignSystemImages(name: "blood_good")
    public static let bloodGreat = DesignSystemImages(name: "blood_great")
    public static let bloodSoso = DesignSystemImages(name: "blood_soso")
    public static let homeCode = DesignSystemImages(name: "home.code")
    public static let homeDesigner = DesignSystemImages(name: "home.designer")
    public static let homeDeveloper = DesignSystemImages(name: "home.developer")
    public static let look = DesignSystemImages(name: "look")
    public static let mbti1 = DesignSystemImages(name: "mbti_1")
    public static let mbti2 = DesignSystemImages(name: "mbti_2")
    public static let mbti3 = DesignSystemImages(name: "mbti_3")
    public static let mbti4 = DesignSystemImages(name: "mbti_4")
    public static let mbti5 = DesignSystemImages(name: "mbti_5")
    public static let onboarding = DesignSystemImages(name: "onboarding")
    public static let percent1 = DesignSystemImages(name: "percent_1")
    public static let percent2 = DesignSystemImages(name: "percent_2")
    public static let percent3 = DesignSystemImages(name: "percent_3")
    public static let percent4 = DesignSystemImages(name: "percent_4")
    public static let percent5 = DesignSystemImages(name: "percent_5")
    public static let profile = DesignSystemImages(name: "profile")
    public static let splashBgBottom = DesignSystemImages(name: "splash_bg_bottom")
    public static let splashBgTop = DesignSystemImages(name: "splash_bg_top")
    public static let designer = DesignSystemImages(name: "designer")
    public static let developer = DesignSystemImages(name: "developer")
    public static let enfjActive = DesignSystemImages(name: "ENFJ_active")
    public static let enfjDisabled = DesignSystemImages(name: "ENFJ_disabled")
    public static let enfpActive = DesignSystemImages(name: "ENFP_active")
    public static let enfpDisabled = DesignSystemImages(name: "ENFP_disabled")
    public static let entjActive = DesignSystemImages(name: "ENTJ_active")
    public static let entjDisabled = DesignSystemImages(name: "ENTJ_disabled")
    public static let entpActive = DesignSystemImages(name: "ENTP_active")
    public static let entpDisabled = DesignSystemImages(name: "ENTP_disabled")
    public static let esfjActive = DesignSystemImages(name: "ESFJ_active")
    public static let esfjDisabled = DesignSystemImages(name: "ESFJ_disabled")
    public static let esfpActive = DesignSystemImages(name: "ESFP_active")
    public static let esfpDisabled = DesignSystemImages(name: "ESFP_disabled")
    public static let estjActive = DesignSystemImages(name: "ESTJ_active")
    public static let estjDisabled = DesignSystemImages(name: "ESTJ_disabled")
    public static let estpActive = DesignSystemImages(name: "ESTP_active")
    public static let estpDisabled = DesignSystemImages(name: "ESTP_disabled")
    public static let infjActive = DesignSystemImages(name: "INFJ_active")
    public static let infjDisabled = DesignSystemImages(name: "INFJ_disabled")
    public static let infpActive = DesignSystemImages(name: "INFP_active")
    public static let infpDisabled = DesignSystemImages(name: "INFP_disabled")
    public static let intjActive = DesignSystemImages(name: "INTJ_active")
    public static let intjDisabled = DesignSystemImages(name: "INTJ_disabled")
    public static let intpActive = DesignSystemImages(name: "INTP_active")
    public static let intpDisabled = DesignSystemImages(name: "INTP_disabled")
    public static let isfjActive = DesignSystemImages(name: "ISFJ_active")
    public static let isfjDisabled = DesignSystemImages(name: "ISFJ_disabled")
    public static let isfpActive = DesignSystemImages(name: "ISFP_active")
    public static let isfpDisabled = DesignSystemImages(name: "ISFP_disabled")
    public static let istjActive = DesignSystemImages(name: "ISTJ_active")
    public static let istjDisabled = DesignSystemImages(name: "ISTJ_disabled")
    public static let istpActive = DesignSystemImages(name: "ISTP_active")
    public static let istpDisabled = DesignSystemImages(name: "ISTP_disabled")
    public static let onboardingCard = DesignSystemImages(name: "onboarding_card")
    public static let subway1 = DesignSystemImages(name: "subway_1")
    public static let subway2 = DesignSystemImages(name: "subway_2")
    public static let subway3 = DesignSystemImages(name: "subway_3")
    public static let subway4 = DesignSystemImages(name: "subway_4")
    public static let subway5 = DesignSystemImages(name: "subway_5")
    public static let subway6 = DesignSystemImages(name: "subway_6")
    public static let subway7 = DesignSystemImages(name: "subway_7")
    public static let subway8 = DesignSystemImages(name: "subway_8")
    public static let subway9 = DesignSystemImages(name: "subway_9")
    public static let subwayAirport = DesignSystemImages(name: "subway_airport")
    public static let subwayGeonggang = DesignSystemImages(name: "subway_geonggang")
    public static let subwayGimpoGoldline = DesignSystemImages(name: "subway_gimpo_goldline")
    public static let subwayGyeongchun = DesignSystemImages(name: "subway_gyeongchun")
    public static let subwayGyeonguiJungang = DesignSystemImages(name: "subway_gyeongui_jungang")
    public static let subwayIncheon1 = DesignSystemImages(name: "subway_incheon1")
    public static let subwayIncheon2 = DesignSystemImages(name: "subway_incheon2")
    public static let subwaySeohae = DesignSystemImages(name: "subway_seohae")
    public static let subwayShinbundang = DesignSystemImages(name: "subway_shinbundang")
    public static let subwaySillim = DesignSystemImages(name: "subway_sillim")
    public static let subwaySuinbundang = DesignSystemImages(name: "subway_suinbundang")
    public static let subwayUiSinseol = DesignSystemImages(name: "subway_ui_sinseol")
    public static let subwayUijeongbu = DesignSystemImages(name: "subway_uijeongbu")
    public static let subwayYounginEver = DesignSystemImages(name: "subway_youngin_ever")
    public static let easterEgg = DesignSystemImages(name: "easter_egg")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class DesignSystemColors: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public var color: Color {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIColor: SwiftUI.Color {
      return SwiftUI.Color(asset: self)
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension DesignSystemColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: DesignSystemColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: DesignSystemColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct DesignSystemImages: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: DesignSystemImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: DesignSystemImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: DesignSystemImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
