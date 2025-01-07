# Feedback Assistant Clone 
<img src="https://github.com/user-attachments/assets/1019f3fe-e90f-4ad1-b81c-8155d55b3c2d" alt="FeedbackAssistant" width="100"/> 
<br>
This project is a clone of Apple's Feedback Assistant native app. Built with SwiftUI and Core Data, it incorporates powerful features like CloudKit synchronization, advanced filtering, sorting, and widgets. 
<br>
<br>
The app is optimized for multiple platforms, including macOS, watchOS, and visionOS, ensuring a consistent experience across all Apple devices.
<br>

## Technologies

|  <img src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png" alt="SwiftUI" width="50"/>|  <img src="https://miro.medium.com/v2/resize:fit:300/1*nm4j_6GfwWpqhuSPlbO-sg.png" alt="Core Data" width="49"/>|<img src="https://developer.apple.com/assets/elements/icons/cloudkit/cloudkit-96x96_2x.png" alt="CloudKit" width="50"/> |<img src="https://developer.apple.com/assets/elements/icons/accessibility/accessibility-96x96_2x.png" alt="Accessibility" width="50"/>|<img src="https://developer.apple.com/assets/elements/icons/swift-testing/swift-testing-96x96_2x.png" alt="Testing" width="50"/>|<img src="https://developer.apple.com/assets/elements/icons/spotlight/spotlight-96x96_2x.png" alt="Spotlight" width="50"/>|<img src="https://developer.apple.com/assets/elements/icons/storekit/storekit-96x96_2x.png" alt="Store Kit" width="50"/>|<img src="https://developer.apple.com/assets/elements/icons/widgetkit/widgetkit-96x96_2x.png" alt="Widgets" width="50"/>| 
| :---------------- | ------ | :------: | :------ |:---------------- | ------ | :------: | :------ |
| SwiftUI        | CoreData  |   CloudKit   | Accessibility   | SwiftTesting | Spotlight  |   StoreKit   | WidgetKit   |

## Features

- **Issues Management:** Create, update, and delete issues entries with ease.
- **Core Data:** Persistent storage of feedback data using Apple's Core Data framework.
- **CloudKit Integration:** Synchronize issues data across devices with iCloud support.
- **Advanced Filtering and Sorting:** Powerful tools to filter and sort feedback entries.
- **JSON File Reading:** Load and process external JSON files for importing/exporting data.
- **Localization:** Support for multiple languages (English, Spanish, Italian).
- **Accessibility:** Fully optimized for accessibility with VoiceOver and Dynamic Type support.
- **Testing:** Comprehensive Unit and UI tests for ensuring app reliability and stability.
- **MVC and MVVM Architecture:** Combines Model-View-Controller and Model-View-ViewModel architectures for robust and scalable code.
- **Spotlight Integration:** Search feedback entries directly from macOS or iOS Spotlight.
- **Local Notifications:** Reminders and updates via local notifications.
- **StoreKit and In-App Purchases:** Support for app monetization through in-app purchases.
- **Widgets:** Interactive widgets for quick access to feedback data.
- **Optimized for macOS, watchOS, and visionOS:** A seamless experience across Apple platforms.
- **SwiftLint:** Ensure consistent coding style and adherence to best practices with SwiftLint.

## Installation

### Prerequisites
- Xcode 14.0 or newer
- Swift 5.5 or newer
- iOS 15.0 or later (can be modified if targeting earlier versions)
- SwiftLint installed via Homebrew or CocoaPods

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/FeedbackAssistantClone.git
   ```
2. Navigate to the project directory:
   ```bash
   cd FeedbackAssistantClone
   ```
3. Open the `.xcodeproj` or `.xcworkspace` file in Xcode:
   ```bash
   open FeedbackAssistantClone.xcodeproj
   ```
4. Install SwiftLint if it's not already installed:
   ```bash
   brew install swiftlint
   ```
5. Build and run the project in Xcode.

## Usage

- Launch the app to start managing feedbacks.
- Use the app in different languages by changing your device's language in Settings.
- Review the code documentation directly in Xcode (via Quick Help or Documentation popup).

## Code Structure

- **Model**: Core Data models that represent feedbacks and other entities.
- **View**: SwiftUI views that provide the user interface.
- **ViewModel**: State management using observable objects and bindings.
- **Localization**: `.strings` files for each supported language.
- **SwiftLint Configuration**: `.swiftlint.yml` file for linting rules.

## Localization

To add support for a new language:
1. Go to the project navigator in Xcode.
2. Select the `Localizable.strings` file.
3. Add new translations for the new language.
4. Update the app’s user interface strings to use `NSLocalizedString` for dynamic translations.

## SwiftLint

To ensure that the code follows best practices and styling conventions, SwiftLint is integrated into the project. To run SwiftLint, execute:
```bash
swiftlint
```

You can modify the linting rules by editing the `.swiftlint.yml` file.

## Documentation

This project uses Swift's built-in documentation system. Code comments and documentation can be found by holding `Option` and clicking on a symbol or by viewing Quick Help in Xcode.

To add or edit documentation:
1. Use the `///` syntax to add documentation to methods, classes, structs, etc.
2. Follow Apple's [Documentation Guidelines](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html).
