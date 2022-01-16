import XCTest
@testable import Math

final class MathTests: XCTestCase {
    func testArccosineOfZero() throws {
        let theta = arccos(0).round(3)
        let expected = (Double.pi / 2).round(3)
        XCTAssertEqual(theta, expected)
    }

    func testArccosineOfOne() throws {
        XCTAssertEqual(arccos(1), 0)
    }

    func testArccosineOfHalf() throws {
        let theta = arccos(0.5).round(3)
        let expected = (Double.pi / 3).round(3)
        XCTAssertEqual(theta, expected)
    }
}
