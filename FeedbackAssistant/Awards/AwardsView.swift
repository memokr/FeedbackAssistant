//
//  AwardsView.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 17/10/24.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss

    @State private var selectedAward = Award.example
    @State private var showingAwardDetails = false

    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            selectedAward = award
                            showingAwardDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(color(for: award))
                        }
                        .buttonStyle(.borderless)
                        .accessibilityLabel(label(for: award))
                        .accessibilityHint(award.description)
                    }
                }
            }
            .navigationTitle("Awards")
            #if !os(watchOS)
            .toolbar {
                ToolbarItem(placement: customToolBar()) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Close")
                    .help("Close")
                }
            }
            #endif
        }
        .macFrame(minWidth: 600, maxHeight: 500)
        .alert(awardsTitle, isPresented: $showingAwardDetails) {
        } message: {
            Text(selectedAward.description)
        }
    }

    var awardsTitle: String {
        if dataController.hasEarned(award: selectedAward) {
            return String(format: NSLocalizedString("Unlocked: %@", comment: ""), selectedAward.name)
        } else {
            return NSLocalizedString("Locked", comment: "")
        }
    }

    func color(for award: Award) -> Color {
        dataController.hasEarned(award: award) ? Color(award.color) : .secondary.opacity(0.5)
    }

    func label(for award: Award) -> LocalizedStringKey {
        dataController.hasEarned(award: award) ? "Unlocked \(award.name)" : "Locked"
    }
    func customToolBar () -> ToolbarItemPlacement {
        #if os(macOS)
        .cancellationAction
        #else
        .topBarTrailing
        #endif
    }
}

#Preview {
    AwardsView()
}
