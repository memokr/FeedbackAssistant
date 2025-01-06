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
    @State private var showStore = false

    var body: some View {
        Button(action: tryNewTag) {
            Label("Add Tag", systemImage: "plus")
        }
        .sheet(isPresented: $showStore, content: StoreView.init)
        .help("Add tag")

        Button {
            showingAwards.toggle()
        } label: {
            Label("Showing Awards", systemImage: "rosette")
        }
        .sheet(isPresented: $showingAwards, content: AwardsView.init)
        .help("Show awards")

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

    func tryNewTag() {
        if dataController.newTag() == false {
            showStore = true
        }
    }
}

#Preview {
    SideBarViewToolbar()
}
