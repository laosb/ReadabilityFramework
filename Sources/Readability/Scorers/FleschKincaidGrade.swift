//
//  File.swift
//  Readability
//
//  Created by Shibo Lyu on 2022/5/20.
//

import Foundation

public struct RAFleschKincaidGradeScorer: RAScorer {
  public static let requiresCommonMetrics: Set<RACommonMetric>? = [
    .avgWordsPerSentence,
    .avgSyllablesPerWord
  ]

  public static let meta = RAScorerMeta(
    name: "Flesch-Kincaid Grade",
    creator: "John P. Kincaid",
    citation: "Kincaid, J. P., Fishburne Jr, R. P., Rogers, R. L., & Chissom, B. S. (1975). Derivation of new readability formulas (automated readability index, fog count and flesch reading ease formula) for navy enlisted personnel. Naval Technical Training Command Millington TN Research Branch."
  )

  public init() {}

  public func score(_ text: String, metrics: RACommonMetricsCalculator.Results?) -> Double {
    let asl = metrics![.avgWordsPerSentence]!
    let asw = metrics![.avgSyllablesPerWord]!

    return (0.39 * asl) + (11.8 * asw) - 15.59
  }
}
