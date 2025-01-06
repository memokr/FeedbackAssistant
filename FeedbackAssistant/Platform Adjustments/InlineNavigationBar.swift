//
//  InlineNavigationBar.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 06/01/25.
//

import SwiftUI

extension View {
    func inlineNavigationBar() -> some View {
        #if os(macOS)
        self
        #else
        self.navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
