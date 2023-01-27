//
//  TestPageContentModel.swift
//  IndividualChallengeTests
//
//  Created by Luciana Adrião on 24/10/22.
//

import XCTest
@testable import IndividualChallenge

final class TestPageContentModel: XCTestCase {
    // system unit test
    let sutPageable = Pageable(
        currentPage: 1,
        elementsOnPage: 5,
        totalElements: 10,
        totalPages: 15,
        previousPage: "previousPage",
        nextPage: "nextPage")

    let sutContentElement = ContentElement(id: 1, name: "text", href: "https")

    func testPageable() throws {

        let currentPage = sutPageable.currentPage
        let elementosOnPage = sutPageable.elementsOnPage
        let totalElements  = sutPageable.totalElements
        let totalPages = sutPageable.totalPages
        let previousPage = sutPageable.previousPage
        let nextPage = sutPageable.nextPage

        XCTAssertEqual(currentPage, 1)
        XCTAssertEqual(elementosOnPage, 5)
        XCTAssertEqual(totalElements, 10)
        XCTAssertEqual(totalPages, 15)
        XCTAssertEqual(previousPage, "previousPage")
        XCTAssertEqual(nextPage, "nextPage")
    }

    func testContentElement() throws {

        let id = sutContentElement.id
        let name = sutContentElement.name
        let href = sutContentElement.href

        XCTAssertEqual(id, 1)
        XCTAssertEqual(name, "text")
        XCTAssertEqual(href, "https")
    }

    func testPageInfo() throws {
        let sutPageInfo = PageInfo(content: [sutContentElement], pageable: sutPageable)

        let testContent = sutPageInfo.content
        let testPageable = sutPageInfo.pageable

//        XCTAssertEqual(testContent, [sutContentElement])
//        XCTAssertEqual(testPageable, sutPageable)
    }
}
