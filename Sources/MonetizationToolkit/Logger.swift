import Foundation

/// Simple logging utility for MonetizationToolkit
public enum Logger {
    /// Logs a message to the console
    /// - Parameter message: The message to log
    public static func log(_ message: String) {
        #if DEBUG
        print("[MonetizationToolkit] \(message)")
        #endif
    }
}
