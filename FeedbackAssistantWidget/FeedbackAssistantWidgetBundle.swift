//
//  FeedbackAssistantWidgetBundle.swift
//  FeedbackAssistantWidget
//
//  Created by Guillermo Kramsky on 26/12/24.
//

import WidgetKit
import SwiftUI

@main
struct FeedbackAssistantWidgetBundle: WidgetBundle {
    var body: some Widget {
        FeedbackAssistantWidget()
        ComplexFeedbackAssistantWidget()
    }
}
