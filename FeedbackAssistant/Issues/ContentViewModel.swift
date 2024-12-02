//
//  ContentViewModel.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 22/11/24.
//

import Foundation

extension ContentView {
    class ViewModel: ObservableObject {
        var dataController: DataController

        init(dataController: DataController) {
            self.dataController = dataController
        }

        func delete(_ offsets: IndexSet) {
            let issues = dataController.issuesForSeletedFilter()
            for offset in offsets {
                let item = issues[offset]
                dataController.delete(item)
            }
        } 
    }
}