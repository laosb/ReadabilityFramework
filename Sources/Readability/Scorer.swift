//
//  ReadabilityScorer.swift
//  Readability
//
//  Created by Shibo Lyu on 2022/5/19.
//

import Foundation
import SwiftUI

public struct RAScorerMeta {
  let name: String
  let creator: String
  /** Should be in APA format. */
  let citation: String
}

public protocol RAScorer {
  static var meta: RAScorerMeta { get }
  static var requiresCommonMetrics: Set<RACommonMetric>? { get }

  init()
  func score(_ text: String, metrics: RACommonMetricsCalculator.Results?) -> Double
}
