//
//  MacStore.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 06/01/25.
//

import SwiftUI

struct MacStore: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(
                colors: [
                    colorScheme == .dark ? .black.opacity(0.5) : .white, .purple
                ]), startPoint: .bottom, endPoint: .top
            )
            Image(systemName: "lock.open.rotation")
                .resizable()
                .scaledToFit()
                .padding(50)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.purple, .primary], startPoint: .top, endPoint: .bottomTrailing
                    )
                )
        }
    }
}

#Preview {
    MacStore()
}
