//
//  IssueView.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 07/10/24.
//

import SwiftUI

struct IssueView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading){
                    TextField("Title", text: $issue.issueTitle, prompt: Text("Enter the issue title here"))
                        .font(.title)
                    
                    Text("**Modified:** \(issue.issueModificationDate.formatted(date: .long, time: .shortened))")
                    
                    Text("**Status:** \(issue.issueStatus)")
                        .foregroundStyle(.secondary)
                }
                Picker("Priority", selection: $issue.priority){
                    Text("Low").tag(Int16(0))
                    Text("Medium").tag(Int16(1))
                    Text("High").tag(Int16(2))
                }
                
                Menu {
                    
                    //show selected tags
                    ForEach(issue.issueTags){ tag in
                        Button {
                            issue.removeFromTags(tag)
                        } label: {
                            Label(tag.tagName, systemImage: "checkmark")
                        }
                    }
                    
                    //now show unselected tags
                    let otherTags = dataController.missingTags(from: issue)
                    
                    if otherTags.isEmpty == false {
                        Divider()
                        
                        Section("Add tags"){
                            ForEach(otherTags){ tag in
                                Button(tag.tagName){
                                    issue.addToTags(tag)
                                }
                            }
                        }
                    }
                } label: {
                    Text(issue.issueTagsList)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .animation(nil, value: issue.issueTagsList)
                }
            }
            
            Section{
                VStack(alignment: .leading){
                    Text("Basic Information") 
                        .font(.title)
                        .foregroundStyle(.secondary)
                    
                    TextField("Description", text: $issue.issueContent, prompt: Text("Enter the issue description here"), axis: .vertical)
                }
            }
        }
        .disabled(issue.isDeleted)
        .onReceive(issue.objectWillChange) { _ in
            dataController.queueSave()
        }
        .onSubmit(dataController.save)
        .toolbar {
            Menu {
                Button {
                    UIPasteboard.general.string = issue.title
                } label: {
                    Label("Copy Issue Title", systemImage: "doc.on.doc")
                }
                
                Button {
                    issue.completed.toggle()
                    dataController.save()
                } label: {
                    Label(issue.completed ? "Re-open Issue" : "Close Issue" , systemImage: "bubble.left.and.exclamationmark.bubble.right")
                }
            } label: {
                Label("Actions", systemImage: "ellipsis.circle")
            }
        }
    }
}

#Preview {
    IssueView(issue: .example)
}