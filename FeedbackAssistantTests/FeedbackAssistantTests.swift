//
//  FeedbackAssistantTests.swift
//  FeedbackAssistantTests
//
//  Created by Guillermo Kramsky on 22/10/24.
//

import Testing
@testable import FeedbackAssistant


@Test func colorsExists() {
    let allColors = ["Dark Blue", "Dark Gray", "Gold", "Gray", "Green", "Light Blue", "Midnight", "Orange", "Pink", "Purple", "Red", "Teal"]

    for color in allColors {
        #expect(color != nil)
    }
}

@Test func awardsLoadCorrectly() {
    #expect(Award.allAwards.isEmpty == false,"Failed to load awards from JSON")
}
