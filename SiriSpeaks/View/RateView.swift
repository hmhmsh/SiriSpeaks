//
//  RateView.swift
//  SiriSpeaks
//
//  Created by 長谷川瞬哉 on 2021/01/18.
//

import SwiftUI

struct RateView: View {
    @Binding var rate: SpeechSynthesizerModel.Rate
    
    var body: some View {
        HStack {
            Button(action: {
                self.rate = rate.slowly()
            }) {
                Image(systemName: "tortoise.fill")
                    .foregroundColor(Color(.label))
                    .padding()
            }

            Text("x" + String(rate.text))
                .foregroundColor(Color(.label))
                .padding()

            Button(action: {
                self.rate = rate.fastly()
            }) {
                Image(systemName: "hare.fill")
                    .foregroundColor(Color(.label))
                    .padding()
            }
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(rate: .constant(.basic))
            .previewLayout(.fixed(width: 375, height: 50))
    }
}
