//
//  TestDigimonCardView.swift
//  IndividualChallengeTests
//
//  Created by Luciana Adrião on 24/10/22.
//

import XCTest
@testable import IndividualChallenge

final class TestDigimonCardView: XCTestCase {
    let sut = DigimonCardView()

    func testFlipCard() throws {
        let uiView = sut.flipCard

        XCTAssertEqual(uiView.backgroundColor, .white)
        XCTAssertEqual(uiView.layer.borderWidth, 2)
        XCTAssertEqual(uiView.layer.borderColor, UIColor.gray.cgColor)
        XCTAssertEqual(uiView.layer.cornerRadius, 40)
        XCTAssertTrue(uiView.layer.masksToBounds)
        XCTAssertFalse(uiView.translatesAutoresizingMaskIntoConstraints)
    }

}
