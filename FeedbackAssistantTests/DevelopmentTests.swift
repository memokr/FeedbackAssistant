//
//  DevelopmentTests.swift
//  FeedbackAssistantTests
//
//  Created by Guillermo Kramsky on 13/11/24.
//

import CoreData
import Testing
@testable import FeedbackAssistant

struct DevelopmentTests {

    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    init() {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }

    @Test func dataCreationWorks() {
        dataController.createSampleData()

        #expect(dataController.count(for: Tag.fetchRequest()) == 5, "There should be 5 sample tags")
        #expect(dataController.count(for: Issue.fetchRequest()) == 50, "There should be 50 sample tags")
    }

    @Test func deleteAllDataIndeedDeletesAll() {
        dataController.createSampleData()
        dataController.deleteAll()
        
        #expect(dataController.count(for: Tag.fetchRequest()) == 0, "There should be no tags")
        #expect(dataController.count(for: Issue.fetchRequest()) == 0, "There should be no issues")
    }

    @Test func exampleTagHasNoIssues() {
        let tag = Tag.example

        #expect(tag.issues?.count == 0, "The example tag should have no issues")
    }

    @Test func exampleIssueIsHighPriority() {
        let issue = Issue.example

        #expect(issue.priority == 2, "The example tag should have no issues")
    }


}
