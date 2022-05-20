import XCTest
@testable import Readability

final class CommonMetrics: XCTestCase {
  func testOnlyWordCount() throws {
    let calc = RACommonMetricsCalculator(metrics: [.wordCount])

    let results = calc.calculate(on: "Hello, World!")

    XCTAssertEqual(results, [.wordCount: 2.0])
  }

  func testAllMetrics() throws {
    let calc = RACommonMetricsCalculator(metrics: [
      .syllableCount,
      .wordCount,
      .sentenceCount,
      .avgSyllablesPerWord,
      .avgWordsPerSentence,
    ])

    let results = calc.calculate(on: "Hello, World!")

    XCTAssertEqual(results, [
      .syllableCount: 3.0,
      .wordCount: 2.0,
      .sentenceCount: 1.0,
      .avgSyllablesPerWord: 1.5,
      .avgWordsPerSentence: 2.0
    ])
  }
}
