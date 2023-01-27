//
//  TestDigimonModel.swift
//  IndividualChallengeTests
//
//  Created by Luciana Adrião on 26/10/22.
//

import XCTest
@testable import IndividualChallenge

final class TestDigimonModel: XCTestCase {
    let sutTypeElement = TypeElement(id: 1, type: "text")

    func testTypeElement() throws {
        let id = sutTypeElement.id
        let type = sutTypeElement.type

        XCTAssertEqual(id, 1)
        XCTAssertEqual(type, "text")
    }

    let sutSkill = Skill(id: 1, skill: "skill", translation: "translation", skillDescription: "description skill")

    func testSkill() throws {
        let id = sutSkill.id
        let skill = sutSkill.skill
        let translation = sutSkill.translation
        let skillDescription = sutSkill.skillDescription

        XCTAssertEqual(id, 1)
        XCTAssertEqual(skill, "skill")
        XCTAssertEqual(translation, "translation")
        XCTAssertEqual(skillDescription, sutSkill.skillDescription)
    }

    let sutEvolution = Evolution(id: 1, digimon: "digimon", condition: "condition")

    func testEvolution() throws {
        let id = sutEvolution.id
        let digimon = sutEvolution.digimon
        let condition = sutEvolution.condition

        XCTAssertEqual(id, 1)
        XCTAssertEqual(digimon, "digimon")
        XCTAssertEqual(condition, "condition")
    }

    func testEvolutionNil() throws {
        let sutEvolutionNil = Evolution(id: nil, digimon: "digimon", condition: "condition")

        let id = sutEvolutionNil.id
        let digimon = sutEvolutionNil.digimon
        let condition = sutEvolutionNil.condition

        XCTAssertNil(id)
        XCTAssertEqual(digimon, "digimon")
        XCTAssertEqual(condition, "condition")
    }

    func testLevel() throws {
        let sutLevel = Level(id: 1, level: "level")

        let id = sutLevel.id
        let level = sutLevel.level

        XCTAssertEqual(id, 1)
        XCTAssertEqual(level, "level")
    }

    func testImage() {
        let sutImage = Image(href: "hrefString", transparent: false)

        let href = sutImage.href
        let transparency = sutImage.transparent

        XCTAssertEqual(href, "hrefString")
        XCTAssertFalse(transparency)
    }

    func testField() {

    }
}
