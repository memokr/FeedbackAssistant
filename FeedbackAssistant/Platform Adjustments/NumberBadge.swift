//
//  NumberBadge.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 06/01/25.
//

import SwiftUI

extension View {
    func numberBadge(_ number: Int) -> some View {
        #if os(watchOS)
        self
        #else
        self.badge(number)
        #endif
    }
}
