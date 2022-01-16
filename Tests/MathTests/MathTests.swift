import XCTest
@testable import Math

final class MathTests: XCTestCase {
    func testArccosineOfZero() throws {
        let theta = arccos(0).rounded(3)
        let expected = (Double.pi / 2).rounded(3)
        XCTAssertEqual(theta, expected)
    }

    func testArccosineOfOne() throws {
        XCTAssertEqual(arccos(1), 0)
    }

    func testArccosineOfHalf() throws {
        let theta = arccos(0.5).rounded(3)
        let expected = (Double.pi / 3).rounded(3)
        XCTAssertEqual(theta, expected)
    }
}
