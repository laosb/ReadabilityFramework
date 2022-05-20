//
//  AutomatedReadabilityIndex.swift
//  
//
//  Created by Shibo Lyu on 2022/5/21.
//


import Foundation

public struct RAAutomatedReadabilityIndexScorer: RAScorer {
  public static let requiresCommonMetrics: Set<RACommonMetric>? = [
    .wordCount,
    .characterCount,
    .sentenceCount
  ]

  public static let meta = RAScorerMeta(
    name: "Automated Readability Index",
    creator: "RJ Senter & EA Smith",
    citation: "Senter, R. J., & Smith, E. A. (1967). Automated readability index. Cincinnati Univ OH."
  )

  public init() {}

  public func score(_ text: String, metrics: RACommonMetricsCalculator.Results?) -> Double {
    let wordCount = metrics![.wordCount]!
    let characterCount = metrics![.characterCount]!
    let sentenceCount = metrics![.sentenceCount]!

    return 4.71 * (characterCount / wordCount) + 0.5 * (wordCount / sentenceCount) - 21.43
  }
}
