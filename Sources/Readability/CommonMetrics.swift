//
//  CommonMetrics.swift
//  Readability
//
//  Created by Shibo Lyu on 2022/5/19.
//

import Foundation
import SyllableCounter

public enum RACommonMetric {
  case sentenceCount
  case wordCount
  case syllableCount
  case characterCount
  case avgWordsPerSentence
  case avgSyllablesPerWord
}

public struct RACommonMetricsCalculator {
  public typealias Results = [RACommonMetric: Double]

  private var metrics: Set<RACommonMetric>

  private static let excludeCharacters: [Character] = ["-", "'"]

  public init(metrics: Set<RACommonMetric>) {
    self.metrics = metrics
  }

  private func countSyllables(word: String) -> Int {
    SyllableCounter.shared.count(word: word)
  }

  public func calculate(on text: String) -> Results {
    let shouldDoSentences = metrics.contains(.sentenceCount) || metrics.contains(.avgWordsPerSentence)
    let shouldDoWords = metrics.contains(.wordCount)
      || metrics.contains(.avgWordsPerSentence)
      || metrics.contains(.avgSyllablesPerWord)
      || metrics.contains(.characterCount)
    let shouldCountSyllables = metrics.contains(.avgSyllablesPerWord) || metrics.contains(.syllableCount)
    let shouldCountCharacters = metrics.contains(.characterCount)

    var sentenceCount = 0
    var wordCount = 0
    var syllableCount = 0
    var characterCount = 0

    if shouldDoSentences {
      sentenceCount = RATokenizer(text, unit: .sentence).enumerateTokens { _ in }
    }

    if shouldDoWords {
      let tokenizer = RATokenizer(text, unit: .word)
      wordCount = tokenizer.enumerateTokens { word in
        if shouldCountSyllables {
          syllableCount += countSyllables(word: word)
        }
        if shouldCountCharacters {
          characterCount += word
            .filter { !Self.excludeCharacters.contains($0) }
            .count
        }
      }
    }

    return metrics.reduce([:]) { dict, metric in
      var value = 0.0

      switch metric {
      case .syllableCount: value = Double(syllableCount)
      case .sentenceCount: value = Double(sentenceCount)
      case .wordCount: value = Double(wordCount)
      case .characterCount: value = Double(characterCount)
      case .avgWordsPerSentence: value = Double(wordCount) / Double(sentenceCount)
      case .avgSyllablesPerWord: value = Double(syllableCount) / Double(wordCount)
      }

      var d = dict
      d[metric] = value
      return d
    }
  }
}
