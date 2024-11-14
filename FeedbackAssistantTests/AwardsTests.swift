//
//  AwardsTests.swift
//  FeedbackAssistantTests
//
//  Created by Guillermo Kramsky on 12/11/24.
//

import Testing
import CoreData
@testable import FeedbackAssistant

struct AwardsTests {
    let awards = Award.allAwards

    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    init() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }

    @Test func awardIDMatchesName() {
        for award in awards {
            #expect(award.id == award.name, "Award ID should always match name")
        }
    }

    @Test func newUserHasNoAwards() {
        for award in awards {
            #expect(!dataController.hasEarned(award: award), "New users should have no earned awards")
        }
    }
}
