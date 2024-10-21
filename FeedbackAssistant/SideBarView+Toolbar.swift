//
//  SideBarView+Toolbar.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 21/10/24.
//

import SwiftUI

struct SideBarViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @State private var showingAwards = false

    var body: some View {
        Button(action: dataController.newTag) {
            Label("Add Tag", systemImage: "plus")
        }

        Button {
            showingAwards.toggle()
        } label: {
            Label("Showing Awards", systemImage: "rosette")
        }
        .sheet(isPresented: $showingAwards, content: AwardsView.init)

        #if DEBUG

        Button {
            dataController.deleteAll()
        } label: {
            Label("Add samples", systemImage: "cross")
        }

        Button {
            dataController.createSampleData()

        } label: {
            Label("Add samples", systemImage: "flame")
        }
        #endif
    }
}

#Preview {
    SideBarViewToolbar()
}
