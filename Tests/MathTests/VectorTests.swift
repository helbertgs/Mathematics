import XCTest
@testable import Math

final class VectorTests: XCTestCase {
    func testInit() throws {
        let v = Vector(x: 2, y: 1, z: 3)

        XCTAssertEqual(v.x, 2)
        XCTAssertEqual(v.y, 1)
        XCTAssertEqual(v.z, 3)
    }

    func testVectorZero() throws {
        let v = Vector.zero

        XCTAssertEqual(v.x, 0)
        XCTAssertEqual(v.y, 0)
        XCTAssertEqual(v.z, 0)
    }

    func testAddWithVector() throws {
        let v = Vector(x: 2, y: 1, z: 3)
        let u = Vector(x: 6, y: 5, z: 4)
        let w = v + u

        XCTAssertEqual(w.x, 8)
        XCTAssertEqual(w.y, 6)
        XCTAssertEqual(w.z, 7)
    }

    func testAddWithScalar() throws {
        let v = Vector(x: 2, y: 1, z: 3)
        let w = v + 3

        XCTAssertEqual(w.x, 5)
        XCTAssertEqual(w.y, 4)
        XCTAssertEqual(w.z, 6)
    }

    func testSubtractWithVector() throws {
        let v = Vector(x: 2, y: 1, z: 3)
        let u = Vector(x: 6, y: 5, z: 4)
        let w = v - u

        XCTAssertEqual(w.x, -4)
        XCTAssertEqual(w.y, -4)
        XCTAssertEqual(w.z, -1)
    }

    func testSubtractWithScalar() throws {
        let v = Vector(x: 2, y: 1, z: 3)
        let w = v - 3

        XCTAssertEqual(w.x, -1)
        XCTAssertEqual(w.y, -2)
        XCTAssertEqual(w.z, 0)
    }
}
