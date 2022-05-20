//
//  File.swift
//  Readability
//
//  Created by Shibo Lyu on 2022/5/19.
//

import Foundation

struct RAFleschReadingEaseScorer: RAScorer {
  static let requiresCommonMetrics: Set<RACommonMetric>? = [
    .avgWordsPerSentence,
    .avgSyllablesPerWord
  ]

  static let meta = RAScorerMeta(
    name: "Flesch Reading Ease",
    creator: "Rudolf Flesch",
    citation: "Flesch, R. (1948). A new readability yardstick. Journal of applied psychology, 32(3), 221."
  )

  func score(_ text: String, metrics: RACommonMetricsCalculator.Results?) -> Double {
    let asl = metrics![.avgWordsPerSentence]!
    let asw = metrics![.avgSyllablesPerWord]!

    return 206.835 - (1.015 * asl) - (84.6 * asw)
  }
}
