import XCTest
@testable import PointInPolygon

final class InvalidPolygonTests: XCTestCase {
    // Set up some simple polygons for use throughout these tests
    internal var empty = Polygon(points: [])
    internal var lineSegment = Polygon(points: [Point(x: 0, y: 0), Point(x: 1, y: 0)])
    internal var square = Polygon(points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1), Point(x: 0, y: 1)])
    
    func testEmptyPolygon() {
        XCTAssertEqual(empty.containsPoint(Point(x: 0, y: 0)), .invalidPolygon)
    }
    
    func testLineSegmentPolygon() {
        XCTAssertEqual(lineSegment.containsPoint(Point(x: 0, y: 0)), .invalidPolygon)
    }
}
