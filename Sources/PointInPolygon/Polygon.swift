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
            self.points.append(firstPoint)
        }
    }
    
    /// An intersection point.
    internal typealias Intersection = Point
    
    /// The line segments that make up the polygon.
    private var lineSegments: [LineSegment] {
        var array: [LineSegment] = []
        for point in points {
            if let index = points.firstIndex(of: point) {
                let startPoint = points[index]
                if index.advanced(by: 1) == points.count {
                    if let first = points.first {
                        let endPoint = first
                        let line = LineSegment(start: startPoint, end: endPoint)
                        array.append(line)
                    }
                } else {
                    let endPoint = points[index.advanced(by: 1)]
                    let line = LineSegment(start: startPoint, end: endPoint)
                    array.append(line)
                }
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
            
            // Now we have a point inside the bounding box containing the polygon. Let's move on to the ray casting method.
            let intersections: [Intersection] = lineSegments.compactMap { segment -> Intersection? in
                return segment.rightwardRayIntersection(from: point)
            }
            
            if intersections.unique.count % 2 == 0 {
                // If the number of intersections is even, the point is outside the polygon.
                return false
            } else {
                // If the number of intersections is odd, the point is inside the polygon.
                return true
            }
        } else {
            // A bounding box was unable to be generated, which implies that no points were supplied. Treat the point as outside.
            return false
        }
    }
}
