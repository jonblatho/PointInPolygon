import XCTest
@testable import PointInPolygon

final class PointInPolygonTests: XCTestCase {
    func testClosingPolygons() {
        // Test an open polygon to ensure it is closed at initialization
        let openPolygonPoints = [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1), Point(x: 1, y: 0)]
        let openPolygon = Polygon(points: openPolygonPoints)
        XCTAssertEqual(openPolygon.points.count, 5)
        XCTAssertEqual(openPolygon.points.first!, openPolygon.points.last!)
        // Test a closed polygon to ensure that a duplicate point is not added
        let closedPolygonPoints = [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1), Point(x: 1, y: 0), Point(x: 0, y: 0)]
        let closedPolygon = Polygon(points: closedPolygonPoints)
        XCTAssertEqual(closedPolygon.points.count, 5)
        XCTAssertEqual(closedPolygon.points.first!, closedPolygon.points.last!)
    }
    
    func testSimplePolygonBoundingBox() {
        // Create a simple polygon, around which there should be a bounding box with x in (0, 1) and y in (0, 1).
        let polygonPoints = [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1), Point(x: 0, y: 1)]
        let polygon = Polygon(points: polygonPoints)
        if let bounds = polygon.bounds {
            XCTAssertEqual(bounds.xMin, 0)
            XCTAssertEqual(bounds.xMax, 1)
            XCTAssertEqual(bounds.yMin, 0)
            XCTAssertEqual(bounds.yMax, 1)
        }
    }
    
    func testSimplePolygonContainsPoints() {
        // Test various points in/around a simple polygon to ensure that the results are what we would expect
        let polygonPoints = [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1), Point(x: 0, y: 1)]
        let polygon = Polygon(points: polygonPoints)
        // The point (0.5, 0.5) should be inside the simple polygon.
        XCTAssertTrue(polygon.contains(point: Point(x: 0.5, y: 0.5)))
        // The points (-1, 1) and (-1, 0) should be outside the simple polygon.
        // (A rightward ray from these points would directly overlap with the boundaries.)
        XCTAssertFalse(polygon.contains(point: Point(x: -1, y: 1)))
        XCTAssertFalse(polygon.contains(point: Point(x: -1, y: 0)))
        // The points (0.5, 1) and (0, 0) should be outside the simple polygon.
        // (A polygon does not contain points on its boundary.)
        XCTAssertFalse(polygon.contains(point: Point(x: 0.5, y: 1)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0, y: 0)))
        // The points (-1, 0.5) and (2, 0.5) should be outside (on either side of) the simple polygon.
        XCTAssertFalse(polygon.contains(point: Point(x: -1, y: 0.5)))
        XCTAssertFalse(polygon.contains(point: Point(x: 2, y: 0.5)))
        // The points (0.5, 2) (0.5, -1) should be above and below the simple polygon, respectively.
        XCTAssertFalse(polygon.contains(point: Point(x: 0.5, y: 2)))
        XCTAssertFalse(polygon.contains(point: Point(x: 0.5, y: -1)))
    }

    static var allTests = [
        ("testClosingPolygons", testClosingPolygons),
        ("testSimplePolygonBoundingBox", testSimplePolygonBoundingBox),
        ("testSimplePolygonContainsPoints", testSimplePolygonContainsPoints),
    ]
}
