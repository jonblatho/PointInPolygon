#if canImport(CoreGraphics)
import CoreGraphics

extension Polygon {
    /**
     Initializes a Polygon from an array of `CGPoint` objects.
     
     - parameter cgPoints: An array of `CGPoint` objects containing the polygon's points.
     */
    public convenience init(cgPoints: [CGPoint]) {
        let points: [Point] = cgPoints.map { (cgPoint) -> Point in
            Point(x: Double(cgPoint.x), y: Double(cgPoint.y))
        }
        
        self.init(points: points)
    }
}
#endif
