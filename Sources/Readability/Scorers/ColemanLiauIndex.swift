//
//  ColemanLiauIndex.swift
//  
//
//  Created by Shibo Lyu on 2022/5/20.
//

import Foundation

public struct RAColemanLiauIndexScorer: RAScorer {
  public static let requiresCommonMetrics: Set<RACommonMetric>? = [
    .wordCount,
    .characterCount,
    .sentenceCount
  ]

  public static let meta = RAScorerMeta(
    name: "Coleman-Liau Index",
    creator: "Meri Coleman & T. L. Liau",
    citation: "Coleman, M., & Liau, T. L. (1975). A computer readability formula designed for machine scoring. Journal of Applied Psychology, 60(2), 283."
  )

  public init() {}

  public func score(_ text: String, metrics: RACommonMetricsCalculator.Results?) -> Double {
    let wordCount = metrics![.wordCount]!

    let l = metrics![.characterCount]! * 100 / wordCount
    let s = metrics![.sentenceCount]! * 100 / wordCount

    return (0.0588 * l) - (0.296 * s) - 15.8
  }
}
