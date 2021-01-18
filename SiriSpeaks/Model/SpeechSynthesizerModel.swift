//
//  SpeechSynthesizerModel.swift
//  SiriSpeaks
//
//  Created by 長谷川瞬哉 on 2021/01/18.
//

import AVFoundation
import Combine
import Foundation

class SpeechSynthesizerModel: NSObject {
    enum Language: String, CaseIterable, Identifiable {
        case Japanese = "ja-JP"
        case English = "en-US"

        var id: String {
            rawValue
        }

        var title: String {
            switch self {
            case .Japanese:
                return "日本語"
            case .English:
                return "English"
            }
        }
    }

    enum Rate: Float {
        case slow = 0.25
        case basic = 0.5
        case fast = 0.75
        case fastest = 1.0

        var text: String {
            String(rawValue * 2)
        }

        func slowly() -> Rate {
            switch self {
            case .slow:
                return .slow
            case .basic:
                return .slow
            case .fast:
                return .basic
            case .fastest:
                return .fast
            }
        }

        func fastly() -> Rate {
            switch self {
            case .slow:
                return .basic
            case .basic:
                return .fast
            case .fast:
                return .fastest
            case .fastest:
                return .fastest
            }
        }
    }

    private let synthesizer = AVSpeechSynthesizer()
    private(set) var isSpeaking = CurrentValueSubject<Bool, Never>(false)

    var language: Language = .Japanese
    var preUtteranceDelay: TimeInterval = 0
    var rate: Rate = .basic

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(text: String) {
        if isSpeaking.value {
            return
        }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language.rawValue)
        utterance.preUtteranceDelay = preUtteranceDelay
        utterance.rate = rate.rawValue
        synthesizer.speak(utterance)
    }

    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}

extension SpeechSynthesizerModel: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        isSpeaking.send(true)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking.send(false)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        isSpeaking.send(false)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        isSpeaking.send(true)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        isSpeaking.send(false)
    }
}
