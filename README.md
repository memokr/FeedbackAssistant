# Feedback Assistant Clone 
<img src="https://github.com/user-attachments/assets/1019f3fe-e90f-4ad1-b81c-8155d55b3c2d" alt="FeedbackAssistant" width="100"/> 
<br>
This project is a clone of Apple's Feedback Assistant native app, built using SwiftUI, Core Data for persistence, with support for localization, comprehensive code documentation, and adherence to SwiftLint for clean, maintainable code.
<br>

## Features

- **Feedback Management**: Create, update, and delete feedback entries.
- **Core Data**: Persistent storage of feedback data using Apple's Core Data framework.
- **Localization**: Support for multiple languages (English, Spanish, Italian).
- **Code Documentation**: Detailed code documentation to ensure clarity and maintainability.
- **SwiftLint**: Integrated SwiftLint for enforcing Swift code style and quality standards.

## Technologies

- **SwiftUI**: For building the user interface.
- **Core Data**: Persistent storage of user feedbacks.
- **Localization**: App localization to support multiple languages.
- **Code Documentation**: Markup used to provide clarity on functions and classes.
- **SwiftLint**: Linting tool used to enforce Swift coding standards.

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

## License

This project is licensed under the MIT License. See the `LICENSE` file for more information.
