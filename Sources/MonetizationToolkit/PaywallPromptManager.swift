import Foundation
class PaywallPromptManager {
    private let userDefaults: UserDefaults = .standard
    

    static let shared = PaywallPromptManager()

    private init() {}

    func shouldPromptForPaywall(hasIAP: Bool) -> Bool {
        guard !hasIAP else { return false }

        let lastVersionPrompted = userDefaults.string(forKey: Constants.StorageKeys.lastVersionPromptedForPaywallKey)
        
        Logger.log("lastVersionPrompted: \(lastVersionPrompted ?? "nil")")
        Logger.log("currentVersion: \(currentVersion)")
        
        if lastVersionPrompted == currentVersion {
            Logger.log("Not showing paywall. Paywall already shown for current version")
            return false
        }

        userDefaults.set(currentVersion, forKey: Constants.StorageKeys.lastVersionPromptedForPaywallKey)

        return true
    }

    private var currentVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
}
