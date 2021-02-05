import XCTest
@testable import PointInPolygon

final class PolygonBoundaryTests: XCTestCase {
    internal var triangle = Polygon(points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1)])
    
    internal func testPointIsOnBoundary() {
        XCTAssertTrue(triangle.pointIsOnBoundary(point: Point(x: 0, y: 0)))
        XCTAssertTrue(triangle.pointIsOnBoundary(point: Point(x: 0.5, y: 0)))
        XCTAssertTrue(triangle.pointIsOnBoundary(point: Point(x: 1, y: 0)))
        XCTAssertTrue(triangle.pointIsOnBoundary(point: Point(x: 1, y: 0.5)))
        XCTAssertTrue(triangle.pointIsOnBoundary(point: Point(x: 1, y: 1)))
        XCTAssertTrue(triangle.pointIsOnBoundary(point: Point(x: 0.25, y: 0.25)))
        XCTAssertTrue(triangle.pointIsOnBoundary(point: Point(x: 0.5, y: 0.5)))
        XCTAssertTrue(triangle.pointIsOnBoundary(point: Point(x: 0.75, y: 0.75)))
    }
    
    static var allTests = [
        ("testPointIsOnBoundary", testPointIsOnBoundary)
    ]
}
