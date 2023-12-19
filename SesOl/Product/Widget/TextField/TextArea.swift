//
//  TextArea.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 7.05.2023.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String

    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
                    .allowsHitTesting(false) // Placeholder üzerinde tıklanmasını engeller
            }

            TextEditor(text: $text)
                .padding(4)
                .opacity(text.isEmpty ? 0.25 : 1) // Metin boşsa opaklığı azaltır
        }
        .font(.body)
    }
}

struct TextArea_Previews: PreviewProvider {
    static var previews: some View {
        TextArea("", text: .constant(""))
    }
}

struct LargeTextField: View {
    var text: Binding<String>
    var hint: String

    var body: some View {
        VStack(alignment: .leading) {
            TextField(hint, text: text)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .frame(height: 100)
                .foregroundColor(.halloween_orange)
                .modifier(TextFieldModifier())
        }
    }
}
