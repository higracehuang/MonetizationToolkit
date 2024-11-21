//
//  File.swift
//  
//
//  Created by Le Huang on 11/21/24.
//

import Foundation
import XCTest
@testable import MonetizationToolkit

final class PaywallPromptManagerTests: XCTestCase {
    var sut: PaywallPromptManager!
    var mockUserDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        sut = PaywallPromptManager.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Feature Limit Tests
    
    func testShouldNotPromptPaywallForFeatureLimitWhenUserHasIAP() {
        let result = sut.shouldPromptPaywallForFeatureLimit(hasIAP: true, currentCount: 10, limit: 5)
        XCTAssertFalse(result, "Should not show paywall when user has IAP, regardless of count")
    }
    
    func testShouldPromptPaywallWhenFeatureLimitReached() {
        let result = sut.shouldPromptPaywallForFeatureLimit(hasIAP: false, currentCount: 5, limit: 5)
        XCTAssertTrue(result, "Should show paywall when limit is reached")
    }
    
    func testShouldPromptPaywallWhenFeatureLimitExceeded() {
        let result = sut.shouldPromptPaywallForFeatureLimit(hasIAP: false, currentCount: 6, limit: 5)
        XCTAssertTrue(result, "Should show paywall when limit is exceeded")
    }
    
    func testShouldNotPromptPaywallWhenUnderFeatureLimit() {
        let result = sut.shouldPromptPaywallForFeatureLimit(hasIAP: false, currentCount: 4, limit: 5)
        XCTAssertFalse(result, "Should not show paywall when under limit")
    }
}
