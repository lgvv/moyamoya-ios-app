import Foundation

enum APIEnvironment {
    case develop
    case production
    case staging
    
    /// api base url
    var urlString: String {
        switch self {
        case .develop:
            return Bundle.findStringFromObject(ofDictionaryKey: "develop") + "api"
        case .production:
            return Bundle.findStringFromObject(ofDictionaryKey: "production") + "api"
        case .staging:
            return Bundle.findStringFromObject(ofDictionaryKey: "staging") + "api"
        }
    }
}

extension Bundle {
    class CurrentModuleHelper {}
    
    static func findStringFromObject(ofDictionaryKey key: String) -> String {
        let bundle = Bundle(for: CurrentModuleHelper.self).object(forInfoDictionaryKey: key)
        guard let domain = bundle as? String else {
            return ""
        }
        return domain
    }
}
