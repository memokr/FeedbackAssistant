//
//  SideBarView.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 24/08/24.
//

import SwiftUI

struct SideBarView: View {
    @EnvironmentObject var dataController: DataController
    let smartFilters: [Filter] = [.all, .recent]
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag>
    
    @State private var tagToRename: Tag?
    @State private var renamingTag = false
    @State private var tagName = ""
    
    @State private var showingAwards = false
    
 
    
    var tagFilters: [Filter] {
        tags.map { tag in
            Filter(id: tag.tagID, name: tag.tagName, icon: "tag", tag: tag)
        }
    }
    
    var body: some View {
        List(selection: $dataController.selectedFilter){
            Section("Smart Filters"){
                ForEach(smartFilters){ filter in
                    NavigationLink(value: filter){
                        Label(filter.name, systemImage: filter.icon)
                    }
                }
            }
            Section("Tags"){
                ForEach(tagFilters){ filter in
                    NavigationLink(value: filter){
                        Label(filter.name, systemImage: filter.icon)
                            .badge(filter.activeIssuesCount)
                            .contextMenu{
                                Button {
                                    rename(filter)
                                } label: {
                                    Label("Rename", systemImage: "pencil")
                                }
                                Button(role: .destructive ){
                                    delete(filter)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .accessibilityElement()
                            .accessibilityLabel(filter.name)
                            .accessibilityHint("^[\(filter.activeIssuesCount) issue](inflect: true)")
                    }
                }
                .onDelete(perform: delete)
            }
            
        }
        .toolbar{
            Button(action: dataController.newTag){
                Label("Add Tag", systemImage: "plus")
            }
            
            Button{
                showingAwards.toggle()
            } label: {
                Label("Showing Awards", systemImage: "rosette")
            }
            
            #if DEBUG
            
            Button{
                dataController.deleteAll()
            } label: {
                Label("Add samples", systemImage: "cross")
            }
            
            Button{
                dataController.createSampleData()
                
            } label: {
                Label("Add samples", systemImage: "flame")
            }
            #endif
        }
        .alert("Rename tag", isPresented: $renamingTag){
            Button("OK", action: completeRename)
            Button("Cancel", role: .cancel){}
            TextField("New Name", text: $tagName)
            
        }
        .sheet(isPresented: $showingAwards, content: AwardsView.init)
        .navigationTitle("Filters")
    }
    
    func delete(_ offsets: IndexSet){
        for offset in offsets{
            let item = tags[offset]
            dataController.delete(item)
        }
    }
    
    func delete(_ filter: Filter){
        guard let tag = filter.tag else { return }
        dataController.delete(tag)
        dataController.save()
    }
    func rename(_ filter: Filter){
        tagToRename = filter.tag
        tagName = filter.name
        renamingTag = true
    }
    
    func completeRename(){
        tagToRename?.name = tagName
        dataController.save()
    }
}

//#Preview {
//    SideBarView()
//        .environmentObject(DataController.preview)
//}
