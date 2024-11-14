//
//  TagTests.swift
//  FeedbackAssistantTests
//
//  Created by Guillermo Kramsky on 30/10/24.
//

import Testing
import CoreData
@testable import FeedbackAssistant

struct TagTests {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    init() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }

    @Test func creatingTagsAndIssues() {
        let count = 10

        for _ in 0..<count {
            let tag = Tag(context: managedObjectContext)

            for _ in 0..<count {
                let issue = Issue(context: managedObjectContext)
                tag.addToIssues(issue)
            }
        }

        #expect(dataController.count(for: Tag.fetchRequest()) == count, "There should be \(count) tags.")
        #expect(dataController.count(for: Issue.fetchRequest()) == count * count, "There should be \(count * count) issues.")
    }
}
