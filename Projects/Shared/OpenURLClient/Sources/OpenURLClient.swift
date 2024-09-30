import UIKit

public protocol OpenURLClientInterface {
    func feedback() throws
    func appstore() throws
    func releaseNote() throws
}

public enum OpenURLError: Error {
    case error(String)
}

public struct OpenURLClient: OpenURLClientInterface {
    public init() { }
    
    public func feedback() throws {
        try execute(urlString: OpenURLStringSet.feedback.rawValue)
    }
    
    public func appstore() throws {
        try execute(urlString: OpenURLStringSet.appstore.rawValue)
    }
    
    public func releaseNote() throws {
        try execute(urlString: OpenURLStringSet.releaseNote.rawValue)
    }
    
    private func execute(urlString: String) throws {
        guard let url = URL(string: urlString) else {
            throw OpenURLError.error("Failed to convert string to URL")
        }
        guard UIApplication.shared.canOpenURL(url) else {
            throw OpenURLError.error("Failed to open URL")
        }
        UIApplication.shared.open(url)
    }
}

public enum OpenURLStringSet: String {
    case feedback = "https://docs.google.com/forms/d/e/1FAIpQLSeA-PMJNkLe2mENodWYuPASMaLUBZk_4LSV9MfzyZCHxvBNzw/viewform"
    case appstore = "https://apps.apple.com/kr/app/%ED%99%A9%EA%B8%88%ED%8E%80%EC%B9%98/id6478166971"
    case releaseNote = "https://github.com/Nexters/moyamoya-ios-app/releases"
}
