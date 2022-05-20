//
//  CommonMetrics.swift
//  Readability
//
//  Created by Shibo Lyu on 2022/5/19.
//

import Foundation
import SyllableCounter

enum RACommonMetric {
  case sentenceCount
  case wordCount
  case syllableCount
  case avgWordsPerSentence
  case avgSyllablesPerWord
}

struct RACommonMetricsCalculator {
  typealias Results = [RACommonMetric: Double]

  private var metrics: Set<RACommonMetric>

  init(metrics: Set<RACommonMetric>) {
    self.metrics = metrics
  }

  private func countSyllables(word: String) -> Int {
    SyllableCounter.shared.count(word: word)
  }

  func calculate(on text: String) -> Results {
    let shouldDoSentences = metrics.contains(.sentenceCount) || metrics.contains(.avgWordsPerSentence)
    let shouldDoWords = metrics.contains(.wordCount)
      || metrics.contains(.avgWordsPerSentence)
      || metrics.contains(.avgSyllablesPerWord)
    let shouldCountSyllables = metrics.contains(.avgSyllablesPerWord) || metrics.contains(.syllableCount)

    var sentenceCount = 0
    var wordCount = 0
    var syllableCount = 0

    if shouldDoSentences {
      sentenceCount = RATokenizer(text, unit: .sentence).enumerateTokens { _ in }
    }

    if shouldDoWords {
      let tokenizer = RATokenizer(text, unit: .word)
      if shouldCountSyllables {
        wordCount = tokenizer.enumerateTokens { word in
          syllableCount += countSyllables(word: word)
        }
      } else {
        wordCount = tokenizer.enumerateTokens { _ in }
      }
    }

    return metrics.reduce([:]) { dict, metric in
      var value = 0.0

      switch metric {
      case .syllableCount: value = Double(syllableCount)
      case .sentenceCount: value = Double(sentenceCount)
      case .wordCount: value = Double(wordCount)
      case .avgWordsPerSentence: value = Double(wordCount) / Double(sentenceCount)
      case .avgSyllablesPerWord: value = Double(syllableCount) / Double(wordCount)
      }

      var d = dict
      d[metric] = value
      return d
    }
  }
}
