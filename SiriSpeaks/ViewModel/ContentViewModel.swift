//
//  ContentViewModel.swift
//  SiriSpeaks
//
//  Created by 長谷川瞬哉 on 2021/01/18.
//

import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    private var speechSynthesizer = SpeechSynthesizerModel()
    var cancellables: [Cancellable] = []

    @Published var synthesizerIsSpeacking = false
    @Published var text = """
    SwiftUI

    Declare the user interface and behavior for your app on every platform.

    Overview

    SwiftUI provides views, controls, and layout structures for declaring your app’s user interface. The framework provides event handlers for delivering taps, gestures, and other types of input to your app, and tools to manage the flow of data from your app’s models down to the views and controls that users will see and interact with.
    Define your app structure using the App protocol, and populate it with scenes that contain the views that make up your app’s user interface. Create your own custom views that conform to the View protocol, and compose them with SwiftUI views for displaying text, images, and custom shapes using stacks, lists, and more. Apply powerful modifiers to built-in views and your own views to customize their rendering and interactivity. Share code between apps on multiple platforms with views and controls that adapt to their context and presentation.

    You can integrate SwiftUI views with objects from the UIKit, AppKit, and WatchKit frameworks to take further advantage of platform-specific functionality. You can also customize accessibility support in SwiftUI, and localize your app’s interface for different languages, countries, or cultural regions.
    """
    @Published var rate: SpeechSynthesizerModel.Rate = .basic {
        didSet {
            self.speechSynthesizer.rate = rate
        }
    }

    @Published var language: SpeechSynthesizerModel.Language = .Japanese {
        didSet {
            self.speechSynthesizer.language = language
        }
    }

    init() {
        cancellables.append(speechSynthesizer.isSpeaking.assign(to: \.synthesizerIsSpeacking, on: self))
    }

    func playStopAction() {
        if synthesizerIsSpeacking {
            stopSpeaking()
        } else {
            speech()
        }
    }

    func speech() {
        speechSynthesizer.speak(text: text)
    }

    func stopSpeaking() {
        speechSynthesizer.stopSpeaking()
    }
}
