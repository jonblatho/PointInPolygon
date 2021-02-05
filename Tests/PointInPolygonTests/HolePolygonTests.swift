import XCTest
@testable import PointInPolygon

final class HolePolygonTests: XCTestCase {
    internal static var inner = Polygon(points: [Point(x: 2, y: 2), Point(x: 3, y: 2), Point(x: 3, y: 3), Point(x: 2, y: 3)])
    internal static var middle = Polygon(points: [Point(x: 1, y: 1), Point(x: 4, y: 1), Point(x: 4, y: 4), Point(x: 1, y: 4)], holes: [inner])
    internal var outer = Polygon(points: [Point(x: 0, y: 0), Point(x: 5, y: 0), Point(x: 5, y: 5), Point(x: 0, y: 5)], holes: [middle])
    // Test alternate way of initializing a polygon with overlapping hole polygons
    internal static var middleAlternate = Polygon(points: middle.points, holes: [])
    internal var outerAlternate = Polygon(points: [Point(x: 0, y: 0), Point(x: 5, y: 0), Point(x: 5, y: 5), Point(x: 0, y: 5)], holes: [middleAlternate, inner])
    
    internal func testOuterLineSegments() {
        for polygon in [outer, outerAlternate] {
        // The polygon should have 12 total line segments (including those from hole polygons).
            XCTAssertEqual(polygon.lineSegments.count, 12)
            // Check for outer polygon's line segments
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 0, y: 0), end: Point(x: 5, y: 0))))
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 5, y: 0), end: Point(x: 5, y: 5))))
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 5, y: 5), end: Point(x: 0, y: 5))))
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 0, y: 5), end: Point(x: 0, y: 0))))
        }
    }
    
    internal func testMiddleLineSegments() {
        for polygon in [outer, outerAlternate] {
            // Check for middle polygon's line segments
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 1, y: 1), end: Point(x: 4, y: 1))))
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 4, y: 1), end: Point(x: 4, y: 4))))
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 4, y: 4), end: Point(x: 1, y: 4))))
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 1, y: 4), end: Point(x: 1, y: 1))))
        }
    }
    
    internal func testInnerLineSegments() {
        for polygon in [outer, outerAlternate] {
            // Check for inner polygon's line segments
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 2, y: 2), end: Point(x: 3, y: 2))))
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 3, y: 2), end: Point(x: 3, y: 3))))
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 3, y: 3), end: Point(x: 2, y: 3))))
            XCTAssert(polygon.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 2, y: 3), end: Point(x: 2, y: 2))))
        }
    }
    
    internal func testPointsInPolygon() {
        for polygon in [outer, outerAlternate] {
        // Check various points in/around the polygon
            XCTAssertTrue(polygon.contains(point: Point(x: 0.5, y: 0.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 0.5, y: 2.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 0.5, y: 4.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 1.5, y: 0.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 1.5, y: 1.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 1.5, y: 2.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 1.5, y: 3.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 1.5, y: 4.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 2.5, y: 0.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 2.5, y: 1.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 2.5, y: 2.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 2.5, y: 3.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 2.5, y: 4.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 3.5, y: 0.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 3.5, y: 1.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 3.5, y: 2.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 3.5, y: 3.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 3.5, y: 4.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 4.5, y: 0.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 4.5, y: 2.5)))
            XCTAssertTrue(polygon.contains(point: Point(x: 4.5, y: 4.5)))
        }
    }
    
    static var allTests = [
        ("testOuterLineSegments", testOuterLineSegments),
        ("testMiddleLineSegments", testMiddleLineSegments),
        ("testInnerLineSegments", testInnerLineSegments),
        ("testPointsInPolygon", testPointsInPolygon)
    ]
}
