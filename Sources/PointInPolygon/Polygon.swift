/// Defines a polygon as a set of points and provides some utilities for working with the polygon.
public class Polygon {
    /// The points that form the polygon.
    public var points: [Point]
    
    /**
     Initializes a polygon from an array of `Point` objects.
     
     - parameter points: An array of `Point` objects containing the polygon's points.
     */
    public init(points: [Point]) {
        self.points = points
        if let firstPoint = points.first, let lastPoint = points.last, firstPoint != lastPoint {
            // Close the polygon if the supplied points do not form a closed polygon.
            self.points.append(firstPoint)
        }
    }
    
    /// An intersection point.
    internal typealias Intersection = Point
    
    /// The line segments that make up the polygon.
    internal var lineSegments: [LineSegment] {
        var array: [LineSegment] = []
        for index in points.indices {
            if index < points.count.advanced(by: -1) {
                let startPoint = points[index]
                let endPoint = points[index.advanced(by: 1)]
                let line = LineSegment(start: startPoint, end: endPoint)
                array.append(line)
            }
        }
        return array
    }
    
    /// The bounding box containing the polygon.
    internal var bounds: BoundingBox? {
        return Polygon.BoundingBox(points: points)
    }
    
    /// Determines whether the polygon contains a given point using the ray casting method.
    /// - warning: This does not work correctly if the polygon crosses itself.
    /// - parameter point: The point of interest.
    /// - returns: A boolean indicating whether or not the requested point is inside the polygon.
    public func contains(point: Point) -> Bool {
        guard self.points.unique.count >= 3 else {
            // With fewer than 3 unique points, we do not have an evaluable polygon.
            return false
        }
        
        if let bounds = bounds {
            guard bounds.contains(point) else {
                // The point is outside the bounding box containing the polygon, so it is definitely outside the polygon.
                return false
            }
            
            // If the point lies on any line segment, the point does not contain the polygon.
            if lineSegments.filter({ segment -> Bool in return segment.pointIsOnSegment(point: point) }).count > 0 {
                return false
            }
            
            // The point is inside the bounding box containing the polygon and does not lie on its boundary.
            // Now try ray casting.
            let intersections: [Intersection] = lineSegments.compactMap { segment -> Intersection? in
                return segment.rightwardRayIntersection(from: point)
            }
            
            // If the number of intersections is even (or zero), the point is outside the polygon. Otherwise, it is inside.
            return intersections.count % 2 != 0
        } else {
            // A bounding box was unable to be generated, which implies that no points were supplied. Treat the point as outside.
            return false
        }
    }
}
