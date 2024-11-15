//
//  PerformanceTest.swift
//  FeedbackAssistantTests
//
//  Created by Guillermo Kramsky on 15/11/24.
//

import XCTest
@testable import FeedbackAssistant

final class PerformanceTest: BaseTestCase {

    func testAwardCalculationPerformance() {
        dataController.createSampleData()
        let awards = Award.allAwards
        XCTAssertEqual(awards.count, 20, "This check the awards count is constant. Change this if you add awards")

        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
