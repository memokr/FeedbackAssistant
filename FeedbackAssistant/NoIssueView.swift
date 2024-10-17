//
//  NoIssueView.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 07/10/24.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        Text("No issue selected")
            .font(.title)
            .foregroundStyle(.secondary)
        
        Button("New issue", action: dataController.newIssue)
    }
}

#Preview {
    NoIssueView()
}
