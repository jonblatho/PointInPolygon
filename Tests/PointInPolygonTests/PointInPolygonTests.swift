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

    static var allTests = [
        ("testClosingPolygons", testClosingPolygons),
    ]
}
