//
//  ContentView.swift
//  SnapShotTesting
//
//  Created by Yogesh Bharate on 31/07/25.
//

import SwiftUI

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
