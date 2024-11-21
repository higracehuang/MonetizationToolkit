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
    
    override func setUp() {
        super.setUp()
        sut = PaywallPromptManager.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Feature Usage Limit Tests
    
    func testShouldNotPromptPaywallForFeatureLimitWhenUserHasActivePurchase() {
        let result = sut.shouldPromptPaywallForFeatureLimit(
            hasActivePurchase: true,
            usageCount: 10,
            usageLimit: 5
        )
        XCTAssertFalse(result, "Should not show paywall when user has active purchase, regardless of usage count")
    }
    
    func testShouldPromptPaywallWhenFeatureUsageLimitReached() {
        let result = sut.shouldPromptPaywallForFeatureLimit(
            hasActivePurchase: false,
            usageCount: 5,
            usageLimit: 5
        )
        XCTAssertTrue(result, "Should show paywall when usage limit is reached")
    }
    
    func testShouldPromptPaywallWhenFeatureUsageLimitExceeded() {
        let result = sut.shouldPromptPaywallForFeatureLimit(
            hasActivePurchase: false,
            usageCount: 6,
            usageLimit: 5
        )
        XCTAssertTrue(result, "Should show paywall when usage limit is exceeded")
    }
    
    func testShouldNotPromptPaywallWhenUnderFeatureUsageLimit() {
        let result = sut.shouldPromptPaywallForFeatureLimit(
            hasActivePurchase: false,
            usageCount: 4,
            usageLimit: 5
        )
        XCTAssertFalse(result, "Should not show paywall when under usage limit")
    }
}
