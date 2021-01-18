//
//  LanguageView.swift
//  SiriSpeaks
//
//  Created by 長谷川瞬哉 on 2021/01/18.
//

import SwiftUI

struct LanguageView: View {
    let action: () -> Void
    let synthesizerIsSpeacking: Bool
    @Binding var language: SpeechSynthesizerModel.Language
    
    func selected(language: SpeechSynthesizerModel.Language) -> Bool {
        self.language == language && synthesizerIsSpeacking
    }

    var body: some View {
        HStack(spacing: 16) {
            ForEach(SpeechSynthesizerModel.Language.allCases, id: \.rawValue) { language in
                Button(action: {
                    if !synthesizerIsSpeacking || self.language == language {
                        self.language = language
                        action()
                    }
                }) {
                    ZStack {
                        self.selected(language: language) ? Color.purple : Color.clear

                        HStack {
                            Image(
                                systemName:
                                    self.selected(language: language) ?
                                    "stop.fill" : "play.fill"
                            )

                            Text(language.title)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(Color(.label))
                        .padding()
                    }
                }
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple, lineWidth: 5)
                )
            }
        }
        .frame(height: 50)
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView(
            action: {
            },
            synthesizerIsSpeacking: true,
            language: .constant(.Japanese)
        )
        .previewLayout(.fixed(width: 375, height: 100))
    }
}
