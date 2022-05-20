//
//  Tokenization.swift
//  Readability
//
//  Created by Shibo Lyu on 2022/5/19.
//

import Foundation
import NaturalLanguage

public struct RATokenizer {
  private var unit: NLTokenUnit
  private var text: String

  private var tokenizer: NLTokenizer

  public init (_ text: String, unit: NLTokenUnit, language: NLLanguage? = nil) {
    self.text = text
    self.unit = unit
    tokenizer = NLTokenizer(unit: unit)
    if let language = language {
      tokenizer.setLanguage(language)
    }
    tokenizer.string = text
  }

  /** - Returns: Token count. */
  public func enumerateTokens(using callBack: (String) -> Void) -> Int {
    var tokenCount = 0
    tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { range, _ in
      tokenCount += 1
      callBack(String(text[range]))

      return true
    }

    return tokenCount
  }
}
