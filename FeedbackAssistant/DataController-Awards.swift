//
//  DataController-Awards.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 26/12/24.
//

import Foundation

extension DataController {
    func hasEarned(award: Award) -> Bool {
        switch award.criterion {
        case "issues":
            let fetchRequest = Issue.fetchRequest()
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        case "closed":
            let fetchRequest = Issue.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "completed = true")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        case "tags":
            let fetchRequest = Tag.fetchRequest()
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        case "unlock":
            return fullVersionUnlocked

        default:
            //            fatalError("Unknown award criterion: \(award.criterion)")
            return false
        }
    }
}
