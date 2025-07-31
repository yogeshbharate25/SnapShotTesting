# 📸 Snapshot Testing in iOS – Team Notes

---

## 1. ✅ What is Snapshot Testing?

Snapshot testing captures a **visual representation (image or text)** of your UI and compares it to a stored reference.

- The test **fails** when the current snapshot differs from the saved one.
- Commonly used for:
  - Visual regression detection
  - Layout validation with Dynamic Type
  - Theme testing (dark/light mode)

---

## 2. 🧰 Available Frameworks for Snapshot Testing

| Framework | Features |
|----------|----------|
| **SnapshotTesting (Point-Free)** | Swift-native, supports SwiftUI, UIKit, UIViewController, CALayer, Accessibility, etc. |
| **iOSSnapshotTestCase (Uber/Facebook)** | UIKit-focused, great for Objective-C or legacy UIKit codebases. |
| **swift-snapshot-testing** | Community-maintained alternative. |

> ✅ **Recommended**: `SnapshotTesting` (Point-Free) for modern SwiftUI or Swift apps.

---

## 3. 🧪 SwiftUI Example - `CustomTextField`

### `CustomTextField` View

```swift
struct CustomTextField: View {
    let header: String
    let error: String?
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(header)
                .font(.title)
                .bold()
            if let error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            TextField("Enter text...", text: $text)
                .textFieldStyle(.roundedBorder)
        }
        .accessibilityIdentifier("CustomTextFieldView_VoiceOver")
        .padding()
    }
}
```
### `ContentView` View
```swift
struct ContentView: View {
    private var errorMessage: String? {
        isShowError ? "This is Demo error" : nil
    }

    @State private var inputText: String
    private let isShowError: Bool
    private let header: String

    init(header: String = "Header 1",
         inputText: String = "Sample demo",
         isShowError: Bool = false) {
        self.header = header
        self.inputText = inputText
        self.isShowError = isShowError
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CustomTextField(
                header: header,
                error: errorMessage,
                text: $inputText
            )
            Spacer()
        }
    }
}
```
## 4. 🧪 Test Cases (XCTest + SnapshotTesting)
```swift
@MainActor
func test_customTextField_withoutError_snapshot() async throws {
    let view = ContentView()
    let vc = UIHostingController(rootView: view)
    assertSnapshot(matching: vc, as: .image(on: .iPhoneX), named: "CustomTextFieldView")
}

@MainActor
func test_customTextField_withError_snapshot() async throws {
    let view = ContentView(isShowError: true)
    let vc = UIHostingController(rootView: view)
    assertSnapshot(matching: vc, as: .image(on: .iPhoneX), named: "CustomTextFieldView_withError")
}

@MainActor
func test_customTextField_accessibilityLarge_snapshot() async throws {
    let traits = UITraitCollection(preferredContentSizeCategory: .accessibilityLarge)
    let vc = UIHostingController(rootView: ContentView())
    assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: traits), named: "Accessibility_Large")
}

@MainActor
func test_contentView_accessibilityLabel_snapshot() async throws {
    let vc = UIHostingController(rootView: ContentView())
    assertSnapshot(matching: vc, as: .accessibilityDescription, named: "ContentView_accessibilityLabel")
}
```
##5. ✅ Advantages vs 🚫 Disadvantages
✅ ### Advantages:
Quickly detects UI regressions visually.
Great for design consistency across font sizes/devices.
Simplifies testing layout without verbose assertions.
Easy integration with SwiftUI previews and components.

🚫 ### Disadvantages:
Fragile: Fails on minor pixel variations.
Harder to debug: No descriptive output—requires visual diff review.
Needs frequent updates when intentional changes happen.
Can create a lot of snapshot artifacts in the repo.

