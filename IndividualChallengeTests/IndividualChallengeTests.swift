//
//  IndividualChallengeTests.swift
//  IndividualChallengeTests
//
//  Created by Luciana Adrião on 24/10/22.
//

//1. Testa a model

import XCTest
@testable import IndividualChallenge

final class IndividualChallengeTests: XCTestCase {

    let sut = Info(image: UIImage(), title: "text")

    func testInfo() throws {
        let image = sut.image
        let title = sut.title

        XCTAssertEqual(title, "text")
        XCTAssertEqual(image, UIImage())
    }
}
