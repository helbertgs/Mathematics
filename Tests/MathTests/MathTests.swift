import XCTest
@testable import Math

final class MathTests: XCTestCase {
    func testArccosineOfZero() throws {
        let theta = arccos(0)
        let expected = (Double.pi / 2)
        XCTAssertEqual(theta, expected)
    }

    func testArccosineOfOne() throws {
        XCTAssertEqual(arccos(1), 0)
    }

    func testArccosineOfHalf() throws {
        let theta = arccos(0.5).rounded(6)
        let expected = (Double.pi / 3).rounded(6)
        XCTAssertEqual(theta, expected)
    }
}
