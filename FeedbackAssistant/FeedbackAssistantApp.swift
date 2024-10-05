//
//  FeedbackAssistantApp.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 24/08/24.
//

import SwiftUI

@main
struct FeedbackAssistantApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            NavigationSplitView{
                SideBarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
