import Foundation
import WalletConnectNotify

class BuildConfiguration {
    enum Environment: String {
        case debug = "Debug"
        case release = "Release"
    }

    static let shared = BuildConfiguration()

    var environment: Environment

    var pushEnvironment: PushEnvironment {
        switch environment {
        case .debug:
            return .apnsSandbox
        case .release:
            return .apnsProduction
        }
    }

    init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "CONFIGURATION") as! String
        environment = Environment(rawValue: currentConfiguration)!
    }
}
