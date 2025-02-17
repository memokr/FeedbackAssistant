//
//  SideBarView+Toolbar.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 21/10/24.
//

import SwiftUI

struct SideBarViewToolbar: ToolbarContent {
    @EnvironmentObject var dataController: DataController
    @State private var showingAwards = false
    @State private var showStore = false

    var body: some ToolbarContent {
        ToolbarItem(placement: .automaticOrTrailing) {
            Button(action: tryNewTag) {
                Label("Add Tag", systemImage: "plus")
            }
            .sheet(isPresented: $showStore, content: StoreView.init)
            .help("Add tag")
        }

        ToolbarItem(placement: .automaticOrLeading) {
            Button {
                showingAwards.toggle()
            } label: {
                Label("Showing Awards", systemImage: "rosette")
            }
            .sheet(isPresented: $showingAwards, content: AwardsView.init)
            .help("Show awards")
        }

//        #if DEBUG
//        ToolbarItem(placement: .automatic){
//            Button {
//                dataController.deleteAll()
//            } label: {
//                Label("Add samples", systemImage: "cross")
//            }
//
//            Button {
//                dataController.createSampleData()
//
//            } label: {
//                Label("Add samples", systemImage: "flame")
//            }
//        }
//        #endif
    }

    func tryNewTag() {
        if dataController.newTag() == false {
            showStore = true
        }
    }
}
