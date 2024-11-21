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

    /// Determines if a paywall prompt should be shown to the user at app launch
    /// - Parameter hasActivePurchase: Boolean indicating if the user has an active purchase
    /// - Returns: Boolean indicating if the paywall should be shown
    public func shouldPromptPaywallAtLaunch(hasActivePurchase: Bool) -> Bool {
        guard !hasActivePurchase else { return false }

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

    /// Determines if a paywall should be shown based on feature usage limits
    /// - Parameters:
    ///   - hasActivePurchase: Boolean indicating if the user has an active purchase
    ///   - usageCount: Current count of feature usage
    ///   - usageLimit: Maximum allowed usage before showing paywall
    /// - Returns: Boolean indicating if the paywall should be shown
    public func shouldPromptPaywallForFeatureLimit(
        hasActivePurchase: Bool,
        usageCount: Int,
        usageLimit: Int
    ) -> Bool {
        if hasActivePurchase { return false }
        
        return usageCount >= usageLimit
    }
}
