import Foundation

/// Manages the logic for when to show paywall prompts to users
public class PaywallPromptManager {
    private let userDefaults: UserDefaults
    
    /// Shared instance of PaywallPromptManager
    public static let shared = PaywallPromptManager()

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    // For testing purposes
    internal static func createForTesting(userDefaults: UserDefaults) -> PaywallPromptManager {
        return PaywallPromptManager(userDefaults: userDefaults)
    }

    /// Determines if a paywall prompt should be shown to the user
    /// - Parameter hasIAP: Boolean indicating if the user has already purchased
    /// - Returns: Boolean indicating if the paywall should be shown
    public func shouldPromptPaywallAtLaunch(hasIAP: Bool) -> Bool {
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

    public func shouldPromptPaywallForFeatureLimit(hasIAP: Bool, currentCount: Int, limit: Int) -> Bool {
        if hasIAP { return false }

        if currentCount >= limit {
            return true
        }

        return false
    }
}
