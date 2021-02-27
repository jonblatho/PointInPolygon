/// Defines a polygon as a set of points and provides some utilities for working with the polygon.
public class Polygon {
    /// The points that form the polygon.
    public var points: [Point]
    /// Additional polygons which are holes in the polygon.
    public var holes: [Polygon]? = nil
    
    /**
     Initializes a polygon from `Point` objects, as well as `Polygon` objects which are holes in the parent polygon.
     
     - note: Multiple hole polygons can be nested within hole polygons, or they can all be added in a list to the parent polygon; either case will not impact the result of the `Polygon.contains(point:)` method. If a polygon's holes overlap, the intersection area of the hole polygons will be counted as falling within the polygon.
     
     - parameter points: An array of `Point` objects containing the polygon's points.
     - parameter holes: An array of `Polygon` objects which are holes in the polygon.
     */
    public init(points: [Point], holes: [Polygon]? = nil) {
        self.points = points
        self.holes = holes
        
        if let firstPoint = points.first, let lastPoint = points.last, firstPoint != lastPoint {
            // Close the polygon if the supplied points do not already form a closed polygon.
            self.points.append(firstPoint)
        }
    }
    
    /// An intersection point.
    internal typealias Intersection = Point
    
    /// The line segments that make up the polygon.
    internal var lineSegments: [LineSegment] {
        var array: [LineSegment] = []
        // Form the line segments of the parent polygon
        for index in points.indices {
            if index < points.count.advanced(by: -1) {
                let startPoint = points[index]
                let endPoint = points[index.advanced(by: 1)]
                let line = LineSegment(start: startPoint, end: endPoint)
                array.append(line)
            }
        }
        
        // Recursively add line segments from hole polygons
        if let holes = holes {
            for polygon in holes {
                array.append(contentsOf: polygon.lineSegments)
            }
        }
        
        return array
    }
    
    /// The bounding box containing the polygon.
    internal var bounds: BoundingBox? {
        return Polygon.BoundingBox(points: points)
    }
    
    /**
     Determines whether the given point is inside the polygon, on its boundary, or neither.
     
     - parameter point: The point of interest.
     - returns: A case of `Polygon.ContainsPointResult` which describes whether the point is inside or on the boundary of the polygon.
     */
    public func containsPoint(_ point: Point) -> ContainsPointResult {
        guard self.points.unique.count >= 3 else {
            // With fewer than 3 unique points, we do not have an evaluable polygon.
            return .invalidPolygon
        }
        
        guard let bounds = bounds else {
            // A bounding box could not be generated, implying an invalid polygon.
            return .invalidPolygon
        }
        
        guard bounds.contains(point) else {
            // The point is outside the bounding box containing the polygon, so it is definitely outside the polygon.
            return .pointOutside
        }
        
        for segment in lineSegments {
            if segment.pointIsOnSegment(point: point) {
                // If the point is on any line segment, the polygon does not contain the point.
                return .pointOnBoundary
            }
        }
        
        // The point is inside the bounding box containing the polygon and does not lie on its boundary.
        // Now try ray casting.
        let intersections: [Intersection] = lineSegments.compactMap { segment -> Intersection? in
            return segment.rightwardRayIntersection(from: point)
        }
        
        // If the number of intersections is even (or zero), the point is outside the polygon. Otherwise, it is inside.
        if intersections.count % 2 != 0 {
            return .pointInside
        } else {
            return .pointOutside
        }
    }
}
