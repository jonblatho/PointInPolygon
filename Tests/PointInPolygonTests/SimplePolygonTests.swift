import XCTest
@testable import PointInPolygon

final class SimplePolygonTests: XCTestCase {
    // Set up some simple polygons for use throughout these tests
    internal var square = Polygon(points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1), Point(x: 0, y: 1)])
    internal var triangle = Polygon(points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1)])

    func testSquareLineSegments() {
        // The square should have four line segments; verify that they are correct.
        XCTAssertEqual(square.lineSegments.count, 4)
        let expectedLineSegments = [
            Polygon.LineSegment(start: Point(x: 0, y: 0), end: Point(x: 1, y: 0)),
            Polygon.LineSegment(start: Point(x: 1, y: 0), end: Point(x: 1, y: 1)),
            Polygon.LineSegment(start: Point(x: 1, y: 1), end: Point(x: 0, y: 1)),
            Polygon.LineSegment(start: Point(x: 0, y: 1), end: Point(x: 0, y: 0))
        ]
        for lineSegment in expectedLineSegments {
            XCTAssert(square.lineSegments.contains(lineSegment))
        }
    }

    func testTriangleLineSegments() {
        // The triangle should have three line segments; verify that they are correct.
        XCTAssertEqual(triangle.lineSegments.count, 3)
        let expectedLineSegments = [
            Polygon.LineSegment(start: Point(x: 0, y: 0), end: Point(x: 1, y: 0)),
            Polygon.LineSegment(start: Point(x: 1, y: 0), end: Point(x: 1, y: 1)),
            Polygon.LineSegment(start: Point(x: 1, y: 1), end: Point(x: 0, y: 0))
        ]
        for lineSegment in expectedLineSegments {
            XCTAssert(triangle.lineSegments.contains(lineSegment))
        }
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
            XCTAssertEqual(polygon.containsPoint(Point(x: 0.5, y: 0.25)), .pointInside)
            XCTAssertEqual(polygon.containsPoint(Point(x: 0.75, y: 0.25)), .pointInside)
            XCTAssertEqual(polygon.containsPoint(Point(x: 0.75, y: 0.5)), .pointInside)
        }
        // These points should be inside the square.
        XCTAssertEqual(square.containsPoint(Point(x: 0.25, y: 0.25)), .pointInside)
        XCTAssertEqual(square.containsPoint(Point(x: 0.25, y: 0.5)), .pointInside)
        XCTAssertEqual(square.containsPoint(Point(x: 0.25, y: 0.75)), .pointInside)
        XCTAssertEqual(square.containsPoint(Point(x: 0.5, y: 0.25)), .pointInside)
        XCTAssertEqual(square.containsPoint(Point(x: 0.5, y: 0.5)), .pointInside)
        XCTAssertEqual(square.containsPoint(Point(x: 0.5, y: 0.75)), .pointInside)
        XCTAssertEqual(square.containsPoint(Point(x: 0.75, y: 0.25)), .pointInside)
        XCTAssertEqual(square.containsPoint(Point(x: 0.75, y: 0.5)), .pointInside)
        XCTAssertEqual(square.containsPoint(Point(x: 0.75, y: 0.75)), .pointInside)
    }

    func testContainsBoundaryPoints() {
        // These points should be on the boundaries of both polygons.
        for polygon in [square, triangle] {
            XCTAssertEqual(polygon.containsPoint(Point(x: 0, y: 0)), .pointOnBoundary)
            XCTAssertEqual(polygon.containsPoint(Point(x: 0.5, y: 0)), .pointOnBoundary)
            XCTAssertEqual(polygon.containsPoint(Point(x: 1, y: 0)), .pointOnBoundary)
            XCTAssertEqual(polygon.containsPoint(Point(x: 1, y: 0.5)), .pointOnBoundary)
            XCTAssertEqual(polygon.containsPoint(Point(x: 1, y: 1)), .pointOnBoundary)
        }
        // These points should be on the boundary of the square.
        XCTAssertEqual(square.containsPoint(Point(x: 0, y: 0.5)), .pointOnBoundary)
        XCTAssertEqual(square.containsPoint(Point(x: 0, y: 1)), .pointOnBoundary)
        XCTAssertEqual(square.containsPoint(Point(x: 0.5, y: 1)), .pointOnBoundary)
        // These points should be on the boundary of the triangle.
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.25, y: 0.25)), .pointOnBoundary)
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.5, y: 0.5)), .pointOnBoundary)
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.75, y: 0.75)), .pointOnBoundary)
    }

    func testContainsPointsOutsideBoundingBoxAndPolygon() {
        // These points should outside both the bounding box and the polygon for both the square and triangle.
        for polygon in [square, triangle] {
            XCTAssertEqual(polygon.containsPoint(Point(x: -1, y: -1)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: -1, y: 0)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: -1, y: 0.5)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: -1, y: 1)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: -1, y: 2)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: 0, y: -1)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: 0, y: 2)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: 2, y: -1)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: 2, y: 0)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: 2, y: 0.5)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: 2, y: 1)), .pointOutside)
            XCTAssertEqual(polygon.containsPoint(Point(x: 2, y: 2)), .pointOutside)
        }
    }

    func testContainsPointInsideBoundingBoxOutsidePolygon() {
        // These points should be inside the triangle's bounding box but outside the triangle.
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.25, y: 0.5)), .pointOutside)
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.25, y: 0.75)), .pointOutside)
        XCTAssertEqual(triangle.containsPoint(Point(x: 0.5, y: 0.75)), .pointOutside)
    }

    static var allTests = [
        ("testSquareLineSegments", testSquareLineSegments),
        ("testTriangleLineSegments", testTriangleLineSegments),
        ("testBoundingBox", testBoundingBox),
        ("testContainsPointsInsidePolygons", testContainsPointsInsidePolygons),
        ("testContainsBoundaryPoints", testContainsBoundaryPoints),
        ("testContainsPointsOutsideBoundingBoxAndPolygon", testContainsPointsOutsideBoundingBoxAndPolygon),
        ("testContainsPointInsideBoundingBoxOutsidePolygon", testContainsPointInsideBoundingBoxOutsidePolygon)
    ]
}
