//
//  ScoringTask.swift
//  Readability
//
//  Created by Shibo Lyu on 2022/5/19.
//

import Foundation

public class RAScoringTask {
  typealias Results = [Scorer: Double]

  enum Scorer: Hashable, CaseIterable, Comparable {
    case fleschReadingEase
    case fleschKincaidGrade
  }

  static let availableScorers: [Scorer: RAScorer.Type] = [
    .fleschReadingEase: RAFleschReadingEaseScorer.self,
    .fleschKincaidGrade: RAFleschKincaidGradeScorer.self
  ]

  var scorersToRun: Set<Scorer> = Set(Scorer.allCases)

  var scorers: [Scorer: RAScorer.Type] {
    scorersToRun.reduce([:]) { partialResult, scorer in
      var d = partialResult
      d[scorer] = Self.availableScorers[scorer]!
      return d
    }
  }

  var commonMetricsToGet: Set<RACommonMetric> {
    scorers
      .map { $0.1.requiresCommonMetrics }
      .reduce([]) { partialResult, scorerMetrics in
        guard let metrics = scorerMetrics else { return partialResult }
        return partialResult.union(metrics)
      }
  }

  func run(on text: String) -> Results {
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
