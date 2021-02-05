import XCTest
@testable import PointInPolygon

final class SelfIntersectingPolygonTests: XCTestCase {
    // Set up a self-intersecting polygon for use throughout these tests
    let polygon = Polygon(points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 0, y: 1), Point(x: 1, y: 1)])
    
    func testLineSegments() {
        // The self-intersecting polygon should have four line segments; verify they are correct.
        XCTAssertEqual(polygon.lineSegments.count, 4)
        XCTAssert(polygon.lineSegments.contains(Polygon.LineSegment(start: Point(x: 0, y: 0), end: Point(x: 1, y: 0))))
        XCTAssert(polygon.lineSegments.contains(Polygon.LineSegment(start: Point(x: 1, y: 0), end: Point(x: 0, y: 1))))
        XCTAssert(polygon.lineSegments.contains(Polygon.LineSegment(start: Point(x: 0, y: 1), end: Point(x: 1, y: 1))))
        XCTAssert(polygon.lineSegments.contains(Polygon.LineSegment(start: Point(x: 1, y: 1), end: Point(x: 0, y: 0))))
    }
    
    func testContainsPointsInsidePolygon() {
        // These points should be inside the polygon.
        XCTAssertTrue(polygon.contains(point: Point(x: 0.5, y: 0.25)))
        XCTAssertTrue(polygon.contains(point: Point(x: 0.5, y: 0.75)))
    }
    
    func testContainsBoundaryPoints() {
        // These points should be on the boundary of the polygon.
        XCTAssertFalse(polygon.contains(point: Point(x: 0, y: 0)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0, y: 1)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0.25, y: 0.25)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0.25, y: 0.75)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0.5, y: 0)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0.5, y: 0.5)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0.5, y: 1)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0.75, y: 0.25)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0.75, y: 0.75)))
        XCTAssertFalse(polygon.contains(point: Point(x: 1, y: 0)))
        XCTAssertFalse(polygon.contains(point: Point(x: 1, y: 1)))
    }
    
    func testContainsPointsInsideBoundingBoxOutsidePolygon() {
        // These points should be inside the polygon's bounding box but outside the polygon.
        XCTAssertFalse(polygon.contains(point: Point(x: 0.25, y: 0.5)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0.75, y: 0.5)))
    }

    static var allTests = [
        ("testLineSegments", testLineSegments),
        ("testContainsPointsInsidePolygon", testContainsPointsInsidePolygon),
        ("testContainsBoundaryPoints", testContainsBoundaryPoints),
        ("testContainsPointsInsideBoundingBoxOutsidePolygon", testContainsPointsInsideBoundingBoxOutsidePolygon)
    ]
}
