//
//  ContentView.swift
//  SiriSpeaks
//
//  Created by 長谷川瞬哉 on 2021/01/18.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            TextEditor(text: $viewModel.text)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple, lineWidth: 5)
                )
                .padding()

            PlayControlView(
                action: viewModel.playStopAction,
                synthesizerIsSpeacking: viewModel.synthesizerIsSpeacking,
                rate: $viewModel.rate,
                language: $viewModel.language
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
