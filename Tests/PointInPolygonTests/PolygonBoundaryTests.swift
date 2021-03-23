import XCTest
@testable import PointInPolygon

final class PolygonBoundaryTests: XCTestCase {
    internal var triangle = Polygon(points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1)])

    internal func testPointIsOnBoundary() {
        XCTAssertEqual(triangle.containsPoint(Point(x: 0, y: 0)), .pointOnBoundary)
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.5, y: 0)), .pointOnBoundary)
        XCTAssertEqual(triangle.containsPoint(Point(x: 1, y: 0)), .pointOnBoundary)
        XCTAssertEqual(triangle.containsPoint(Point(x: 1, y: 0.5)), .pointOnBoundary)
        XCTAssertEqual(triangle.containsPoint(Point(x: 1, y: 1)), .pointOnBoundary)
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.25, y: 0.25)), .pointOnBoundary)
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.5, y: 0.5)), .pointOnBoundary)
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.75, y: 0.75)), .pointOnBoundary)
    }

    static var allTests = [
        ("testPointIsOnBoundary", testPointIsOnBoundary)
    ]
}
