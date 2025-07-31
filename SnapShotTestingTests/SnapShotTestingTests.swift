//
//  SnapShotTestingTests.swift
//  SnapShotTestingTests
//
//  Created by Yogesh Bharate on 31/07/25.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import SnapShotTesting

final class SnapShotTestingTests: XCTestCase {
    
    var isRecording = false
    
    @MainActor
    func test_customTextField_withoutError_snapshot() async throws {
        let view = ContentView()
        let vc = UIHostingController(rootView: view)
        assertSnapshot(matching: vc,
                       as: .image(on: .iPhoneX),
                       named: "CustomTextFieldView",
                       record: isRecording)
    }
    
    @MainActor
    func test_customTextField_withError_snapshot() async throws {
        let view = ContentView(isShowError: true)
        let vc = UIHostingController(rootView: view)
        assertSnapshot(matching: vc,
                       as: .image(on: .iPhoneX),
                       named: "CustomTextFieldView_withError",
                       record: isRecording)
    }
    
    private func traitCollection(for contentSize: UIContentSizeCategory) -> UITraitCollection {
        return UITraitCollection(preferredContentSizeCategory: contentSize)
    }
    
    @MainActor
    func test_customTextField_accessibilityLarge_snapshot() async throws {
        let view = ContentView()
        let vc = UIHostingController(rootView: view)
        let traits = traitCollection(for: .accessibilityLarge)
        assertSnapshot(matching: vc,
                       as: .image(on: .iPhoneX, traits: traits),
                       named: "CustomTextFieldView_accessibilityLarge",
                       record: isRecording)
    }
    
    @MainActor
    func test_customTextField_accessibilityMedium_snapshot() async throws {
        let view = ContentView()
        let vc = UIHostingController(rootView: view)
        let traits = traitCollection(for: .accessibilityMedium)
        assertSnapshot(matching: vc,
                       as: .image(on: .iPhoneX, traits: traits),
                       named: "CustomTextFieldView_accessibilityMedium",
                       record: isRecording)
    }
    
    @MainActor
    func test_customTextField_accessibilityExtraExtraExtraLarge_snapshot() async throws {
        let view = ContentView()
        let vc = UIHostingController(rootView: view)
        let traits = traitCollection(for: .accessibilityExtraExtraExtraLarge)
        assertSnapshot(matching: vc,
                       as: .image(on: .iPhoneX, traits: traits),
                       named: "CustomTextFieldView_accessibilityExtraExtraExtraLarge",
                       record: isRecording)
    }
    
    @MainActor
    func test_customTextField_accessibilityVoiceOver_snapshot() async throws {
        let view = ContentView()
        let vc = UIHostingController(rootView: view)
        // Simulate high contrast for accessibility/VoiceOver users
        let traits = UITraitCollection(accessibilityContrast: .high)
        assertSnapshot(matching: vc,
                       as: .image(on: .iPhoneX, traits: traits),
                       named: "CustomTextFieldView_accessibilityVoiceOver",
                       record: isRecording)
    }
}

