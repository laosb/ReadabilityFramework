//
//  ScoringTask.swift
//  Readability
//
//  Created by Shibo Lyu on 2022/5/19.
//

import Foundation

public class RAScoringTask {
  public typealias Results = [Scorer: Double]

  public enum Scorer: Hashable, CaseIterable, Comparable {
    case fleschReadingEase
    case fleschKincaidGrade
  }

  public static let availableScorers: [Scorer: RAScorer.Type] = [
    .fleschReadingEase: RAFleschReadingEaseScorer.self,
    .fleschKincaidGrade: RAFleschKincaidGradeScorer.self
  ]

  public var scorersToRun: Set<Scorer>

  /** Derived from `scorersToRun`. */
  public var scorers: [Scorer: RAScorer.Type] {
    scorersToRun.reduce([:]) { partialResult, scorer in
      var d = partialResult
      d[scorer] = Self.availableScorers[scorer]!
      return d
    }
  }

  /** Derived from `scorersToRun`. */
  public var commonMetricsToGet: Set<RACommonMetric> {
    scorers
      .map { $0.1.requiresCommonMetrics }
      .reduce([]) { partialResult, scorerMetrics in
        guard let metrics = scorerMetrics else { return partialResult }
        return partialResult.union(metrics)
      }
  }

  public init(scorers: Set<Scorer> = Set(Scorer.allCases)) {
    self.scorersToRun = scorers
  }

  public func run(on text: String) -> Results {
    var commonMetrics: RACommonMetricsCalculator.Results? = nil

    if !commonMetricsToGet.isEmpty {
      commonMetrics = RACommonMetricsCalculator(metrics: commonMetricsToGet)
        .calculate(on: text)
    }

    return scorers.reduce([:]) { partialResult, scorerPair in
      var d = partialResult
      let (scorer, Scorer) = scorerPair
      d[scorer] = Scorer.init().score(text, metrics: commonMetrics)
      return d
    }
  }
}
