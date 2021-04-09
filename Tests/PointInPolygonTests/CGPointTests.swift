#if canImport(CoreGraphics)
import XCTest
import CoreGraphics
@testable import PointInPolygon

final class CGPointTests: XCTestCase {
    func testPoints() {
        let cgPoints = [CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1.0, y: 0.0), CGPoint(x: 1.0, y: 1.0), CGPoint(x: 0.0, y: 1.0)]
        let polygon = Polygon(cgPoints: cgPoints)
        XCTAssertEqual(polygon.points.count, 5)
        XCTAssertEqual(polygon.lineSegments.count, 4)
        for cgPoint in cgPoints {
            let equivalentPoint = PointInPolygon.Point(x: Double(cgPoint.x), y: Double(cgPoint.y))
            XCTAssertTrue(polygon.points.contains(equivalentPoint))
        }
    }

    static var allTests = [
        ("testPoints", testPoints)
    ]
}
#endif
