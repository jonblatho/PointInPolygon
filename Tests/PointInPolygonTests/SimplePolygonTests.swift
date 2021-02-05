import XCTest
@testable import PointInPolygon

final class SimplePolygonTests: XCTestCase {
    // Set up some simple polygons for use throughout these tests
    internal var square = Polygon(points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1), Point(x: 0, y: 1)])
    internal var triangle = Polygon(points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1)])
    
    func testSquareLineSegments() {
        // The square should have four line segments; verify that they are correct.
        XCTAssertEqual(square.lineSegments.count, 4)
        XCTAssert(square.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 0, y: 0), end: Point(x: 1, y: 0))))
        XCTAssert(square.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 1, y: 0), end: Point(x: 1, y: 1))))
        XCTAssert(square.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 1, y: 1), end: Point(x: 0, y: 1))))
        XCTAssert(square.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 0, y: 1), end: Point(x: 0, y: 0))))
    }
    
    func testTriangleLineSegments() {
        // The triangle should have three line segments; verify that they are correct.
        XCTAssertEqual(triangle.lineSegments.count, 3)
        XCTAssert(triangle.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 0, y: 0), end: Point(x: 1, y: 0))))
        XCTAssert(triangle.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 1, y: 0), end: Point(x: 1, y: 1))))
        XCTAssert(triangle.lineSegments.contains(PointInPolygon.Polygon.LineSegment(start: Point(x: 1, y: 1), end: Point(x: 0, y: 0))))
    }
    
    func testBoundingBox() {
        // The square and triangle should have the same bounding box.
        for polygon in [square, triangle] {
            if let bounds = polygon.bounds {
                XCTAssertEqual(bounds.xMin, 0)
                XCTAssertEqual(bounds.xMax, 1)
                XCTAssertEqual(bounds.yMin, 0)
                XCTAssertEqual(bounds.yMax, 1)
            }
        }
    }
    
    func testContainsPointsInsidePolygons() {
        // These points should be inside both polygons.
        for polygon in [square, triangle] {
            XCTAssertTrue(polygon.contains(point: Point(x: 0.5, y: 0.25)))
            XCTAssertTrue(polygon.contains(point: Point(x: 0.75, y: 0.25)))
            XCTAssertTrue(polygon.contains(point: Point(x: 0.75, y: 0.5)))
        }
        // These points should be inside the square.
        XCTAssertTrue(square.contains(point: Point(x: 0.25, y: 0.25)))
        XCTAssertTrue(square.contains(point: Point(x: 0.25, y: 0.5)))
        XCTAssertTrue(square.contains(point: Point(x: 0.25, y: 0.75)))
        XCTAssertTrue(square.contains(point: Point(x: 0.5, y: 0.25)))
        XCTAssertTrue(square.contains(point: Point(x: 0.5, y: 0.5)))
        XCTAssertTrue(square.contains(point: Point(x: 0.5, y: 0.75)))
        XCTAssertTrue(square.contains(point: Point(x: 0.75, y: 0.25)))
        XCTAssertTrue(square.contains(point: Point(x: 0.75, y: 0.5)))
        XCTAssertTrue(square.contains(point: Point(x: 0.75, y: 0.75)))
    }
    
    func testContainsBoundaryPoints() {
        // These points should be on the boundaries of both polygons.
        for polygon in [square, triangle] {
            XCTAssertFalse(polygon.contains(point: Point(x: 0, y: 0)))
            XCTAssertFalse(polygon.contains(point: Point(x: 0.5, y: 0)))
            XCTAssertFalse(polygon.contains(point: Point(x: 1, y: 0)))
            XCTAssertFalse(polygon.contains(point: Point(x: 1, y: 0.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 1, y: 1)))
        }
        // These points should be on the boundary of the square.
        XCTAssertFalse(square.contains(point: Point(x: 0, y: 0.5)))
        XCTAssertFalse(square.contains(point: Point(x: 0, y: 1)))
        XCTAssertFalse(square.contains(point: Point(x: 0.5, y: 1)))
        // These points should be on the boundary of the triangle.
        XCTAssertFalse(triangle.contains(point: Point(x: 0.25, y: 0.25)))
        XCTAssertFalse(triangle.contains(point: Point(x: 0.5, y: 0.5)))
        XCTAssertFalse(triangle.contains(point: Point(x: 0.75, y: 0.75)))
    }
    
    func testContainsPointsOutsideBoundingBoxAndPolygon() {
        // These points should outside both the bounding box and the polygon for both the square and triangle.
        for polygon in [square, triangle] {
            XCTAssertFalse(polygon.contains(point: Point(x: -1, y: -1)))
            XCTAssertFalse(polygon.contains(point: Point(x: -1, y: 0)))
            XCTAssertFalse(polygon.contains(point: Point(x: -1, y: 0.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: -1, y: 1)))
            XCTAssertFalse(polygon.contains(point: Point(x: -1, y: 2)))
            XCTAssertFalse(polygon.contains(point: Point(x: 0, y: -1)))
            XCTAssertFalse(polygon.contains(point: Point(x: 0, y: 2)))
            XCTAssertFalse(polygon.contains(point: Point(x: 2, y: -1)))
            XCTAssertFalse(polygon.contains(point: Point(x: 2, y: 0)))
            XCTAssertFalse(polygon.contains(point: Point(x: 2, y: 0.5)))
            XCTAssertFalse(polygon.contains(point: Point(x: 2, y: 1)))
            XCTAssertFalse(polygon.contains(point: Point(x: 2, y: 2)))
        }
    }
    
    func testContainsPointInsideBoundingBoxOutsidePolygon() {
        // These points should be inside the triangle's bounding box but outside the triangle.
        XCTAssertFalse(triangle.contains(point: Point(x: 0.25, y: 0.5)))
        XCTAssertFalse(triangle.contains(point: Point(x: 0.25, y: 0.75)))
        XCTAssertFalse(triangle.contains(point: Point(x: 0.5, y: 0.75)))
    }

    static var allTests = [
        ("testSquareLineSegments", testSquareLineSegments),
        ("testTriangleLineSegments", testTriangleLineSegments),
        ("testBoundingBox", testBoundingBox),
        ("testContainsPointsInsidePolygons", testContainsPointsInsidePolygons),
        ("testContainsBoundaryPoints", testContainsBoundaryPoints),
        ("testContainsPointsOutsideBoundingBoxAndPolygon", testContainsPointsOutsideBoundingBoxAndPolygon),
        ("testContainsPointInsideBoundingBoxOutsidePolygon", testContainsPointInsideBoundingBoxOutsidePolygon),
    ]
}
