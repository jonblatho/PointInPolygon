import XCTest
@testable import PointInPolygon

final class LineSegmentTests: XCTestCase {
    // Set up some simple polygons for use throughout these tests
    internal var horizontal = Polygon.LineSegment(start: Point(x: 0, y:0), end: Point(x: 1, y: 0))
    internal var vertical = Polygon.LineSegment(start: Point(x: 0, y: 0), end: Point(x: 0, y: 1))
    
    func testSlopes() {
        XCTAssertEqual(horizontal.slope, 0)
        XCTAssertNil(vertical.slope)
    }
    
    func testYAxisIntercepts() {
        XCTAssertEqual(horizontal.yAxisIntercept, 0)
        XCTAssertNil(vertical.yAxisIntercept)
    }
    
    func testHorizontalIntercepts() {
        let point = Point(x: -0.5, y: 0.5)
        XCTAssertNil(horizontal.horizontalIntercept(for: point))
        XCTAssertEqual(vertical.horizontalIntercept(for: point), 0.5)
    }
    
    func testRightwardRayIntersection() {
        let point = Point(x: -0.5, y: 0)
        XCTAssertNil(horizontal.rightwardRayIntersection(from: point))
    }
}
