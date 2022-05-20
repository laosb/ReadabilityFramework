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
      .characterCount,
      .syllableCount,
      .wordCount,
      .sentenceCount,
      .avgSyllablesPerWord,
      .avgWordsPerSentence,
    ])

    let results = calc.calculate(on: "Hello, World!")

    XCTAssertEqual(results, [
      .characterCount: 10.0,
      .syllableCount: 3.0,
      .wordCount: 2.0,
      .sentenceCount: 1.0,
      .avgSyllablesPerWord: 1.5,
      .avgWordsPerSentence: 2.0
    ])
  }

  func testLongTextCharCount() throws {
    let calc = RACommonMetricsCalculator(metrics: [
      .characterCount,
    ])

    let text =
      """
      The best things in an artist’s work are so much a matter of intuition, that there is much to be said for the point of view that would altogether discourage intellectual inquiry into artistic phenomena on the part of the artist. Intuitions are shy things and apt to disappear if looked into too closely. And there is undoubtedly a danger that too much knowledge and training may supplant the natural intuitive feeling of a student, leaving only a cold knowledge of the means of expression in its place. For the artist, if he has the right stuff in him
      """

    let results = calc.calculate(on: text)

    XCTAssertEqual(results, [
      .characterCount: 446.0,
    ])
  }
}
