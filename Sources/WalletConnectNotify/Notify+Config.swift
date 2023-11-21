import Foundation

extension Notify {
    struct Config {
        let pushHost: String
        let groupIdentifier: String
        let environment: PushEnvironment
        let crypto: CryptoProvider
        let notifyHost: String
        let explorerHost: String
    }
}
