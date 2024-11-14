//
//  FeedbackAssistantTests.swift
//  FeedbackAssistantTests
//
//  Created by Guillermo Kramsky on 22/10/24.
//

import CoreData
import XCTest
@testable import FeedbackAssistant


class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}


