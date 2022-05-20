import XCTest
@testable import Readability

final class Tokenization: XCTestCase {
  func testHelloWorldSentence() throws {
    let tokenizer = RATokenizer("Hello, world!", unit: .sentence)

    var results: [String] = []
    let count = tokenizer.enumerateTokens { sent in
      results.append(sent)
    }

    XCTAssertEqual(count, 1)
    XCTAssertEqual(results, ["Hello, world!"])
  }

  func testHelloWorldWord() throws {
    let tokenizer = RATokenizer("Hello, world!", unit: .word)

    var results: [String] = []
    let count = tokenizer.enumerateTokens { sent in
      results.append(sent)
    }

    XCTAssertEqual(count, 2)
    XCTAssertEqual(results, ["Hello", "world"])
  }
}
