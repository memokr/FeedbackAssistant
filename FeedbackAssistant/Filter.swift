//
//  Filter.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 24/08/24.
//

import Foundation
import SwiftUI


struct Filter: Identifiable, Hashable {
    var id: UUID
    var name: String
    var icon: String
    var minModificationDate = Date.distantPast
    var tag: Tag?
    
    var activeIssuesCount : Int {
       tag?.tagActiveIssues.count ?? 0
    }
    
    static var all = Filter(id: UUID(), name: String(localized:"All Issues"), icon: "tray")
    static var recent = Filter(id: UUID(), name: String(localized:"Recent Issues"), icon: "clock", minModificationDate: .now.addingTimeInterval(86400 * -7))
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}


