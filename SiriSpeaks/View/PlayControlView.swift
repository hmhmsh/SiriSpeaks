//
//  PlayControlView.swift
//  SiriSpeaks
//
//  Created by 長谷川瞬哉 on 2021/01/18.
//

import SwiftUI

struct PlayControlView: View {
    let action: () -> Void
    let synthesizerIsSpeacking: Bool
    @Binding var rate: SpeechSynthesizerModel.Rate
    @Binding var language: SpeechSynthesizerModel.Language

    var body: some View {
        VStack {
            LanguageView(
                action: action,
                synthesizerIsSpeacking: synthesizerIsSpeacking,
                language: $language
            )

            RateView(rate: $rate)
        }
        .padding()
        .frame(height: 140)
    }
}

struct PlayControlView_Previews: PreviewProvider {
    static var previews: some View {
        PlayControlView(
            action: {
            },
            synthesizerIsSpeacking: true,
            rate: .constant(.basic),
            language: .constant(.Japanese)
        )
        .previewLayout(.fixed(width: 375, height: 140))
    }
}
