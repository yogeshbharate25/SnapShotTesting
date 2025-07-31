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
