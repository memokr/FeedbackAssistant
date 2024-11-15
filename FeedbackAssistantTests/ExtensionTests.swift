//
//  ExtensionTests.swift
//  FeedbackAssistantTests
//
//  Created by Guillermo Kramsky on 13/11/24.
//

import Testing
import CoreData
@testable import FeedbackAssistant

struct ExtensionTests {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    init() {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }

    @Test func issueTitleUnwrap() {
        let issue = Issue(context: managedObjectContext)

        issue.title = "Example issue"
        #expect(issue.issueTitle == "Example issue", "Changing title should update the issue title")

        issue.issueTitle = "Updated issue"
        #expect(issue.title == "Updated issue", "Changing issueTitle should update title")
    }

    @Test func issueContentUnwrap() {
        let issue = Issue(context: managedObjectContext)

        issue.content = "Example issue"
        #expect(issue.issueContent == "Example issue", "Changing content should also change issueContent")

        issue.issueContent = "Updated issue"
        #expect(issue.content == "Updated issue", "Changing issueContent should also change content")
    }

    @Test func issueCreationDateUnwrap() {
        let issue = Issue(context: managedObjectContext)

        let testDate = Date.now

        issue.creationDate = testDate
        #expect(issue.issueCreationDate == testDate, "Changing creationDate should also change issueCreationDate")
    }

    @Test func issueTagsUnwrap() {
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        #expect(issue.issueTags.count == 0, "A new issue should have no tags")

        issue.addToTags(tag)
        #expect(issue.issueTags.count == 1, "Adding 1 tag to an issue should result in issueTags having count 1.")
    }

    @Test func issueTagsLists() {
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        tag.name = "My Tag"
        issue.addToTags(tag)

        #expect(issue.issueTagsList == "My Tag", "Adding 1 tag should make issueTagsLists be My Tag")
    }

    @Test func issueSortingIsStable() {
        let issue1 = Issue(context: managedObjectContext)
        issue1.title = "B Issue"
        issue1.creationDate = .now

        let issue2 = Issue(context: managedObjectContext)
        issue2.title = "B Issue"
        issue2.creationDate = .now.addingTimeInterval(1)

        let issue3 = Issue(context: managedObjectContext)
        issue3.title = "A Issue"
        issue3.creationDate = .now.addingTimeInterval(100)

        let allIssues = [issue1, issue2, issue3]
        let sorted = allIssues.sorted()

        #expect([issue3, issue1, issue2] == sorted, "Sorting issue arrays should use name then creation date")
    }

    @Test func tagIdUnwrap() {
        let tag = Tag(context: managedObjectContext)

        tag.id = UUID()
        #expect(tag.tagID == tag.id, "Changing id should also change tagID")
    }

    @Test func tagNameUnwrap() {
        let tag = Tag(context: managedObjectContext)

        tag.name = "Example tag"
        #expect(tag.tagName == tag.name, "Changing name should also change tagName")
    }

    @Test func tagActiveIssues() {
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        #expect(tag.tagActiveIssues.count == 0, "A new tag should have 0 active issues.")

        tag.addToIssues(issue)
        #expect(tag.tagActiveIssues.count == 1, "Adding an issue to a tag should increase the active issue count.")

        issue.completed = true

        #expect(tag.tagActiveIssues.count == 0, "A new tag with 1 completed issue should have 0 active issues.")
    }

    @Test func tagSortingIsStable() {
        let tag1 = Tag(context: managedObjectContext)
        tag1.name = "B tag"
        tag1.id = UUID()

        let tag2 = Tag(context: managedObjectContext)
        tag2.name = "B tag"
        tag2.id = UUID(uuidString: "FFFFFFFF-FFFF-4526-B53A-55F1B0B895A1")

        let tag3 = Tag(context: managedObjectContext)
        tag3.name = "A tag"
        tag3.id = UUID()

        let allTags = [tag1, tag2, tag3]
        let sortedTags = allTags.sorted()

        #expect([tag3, tag1, tag2] == sortedTags, "Sorting tag array should use name then UUID string.")
    }

    @Test func bundleDecodingAwards() {
        let awards = Bundle.main.decode("Awards.json", as: [Award].self)
        #expect(!awards.isEmpty, "Awards.json should decode to a non empty array")
    }
    
}
