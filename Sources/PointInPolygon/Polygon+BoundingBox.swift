extension Polygon {
    /// Gives the x- and y-limits to form a bounding box around a polygon or line segment.
    internal struct BoundingBox {
        /// The minimum x-value for the bounding box.
        internal var xMin: Double
        /// The maximum x-value for the bounding box.
        internal var xMax: Double
        /// The minimum y-value for the bounding box.
        internal var yMin: Double
        /// The maximum y-value for the bounding box.
        internal var yMax: Double
        
        /**
         Initializes a `BoundingBox` instance for a bounding box which
         contains an array of points. If a bounding box cannot be generated
         for the given points with a nonzero interval for both the x- and y-
         components, the initializer will return nil.
         
         - parameter points: An array of points which the bounding box
                             should contain.
         */
        internal init?(points: [Point]) {
            if let xMin = points.min(by: { lhs, rhs in lhs.x < rhs.x }),
               let xMax = points.max(by: { lhs, rhs in lhs.x < rhs.x }),
               let yMin = points.min(by: { lhs, rhs in lhs.y < rhs.y }),
               let yMax = points.max(by: { lhs, rhs in lhs.y < rhs.y }) {
                guard xMin != xMax, yMin != yMax else {
                    return nil
                }
                
                self.xMin = xMin.x
                self.xMax = xMax.x
                self.yMin = yMin.y
                self.yMax = yMax.y
            } else {
                return nil
            }
        }
        
        /// Indicates whether the bounding box contains a given point.
        /// - parameter point: The point of interest.
        /// - returns: A boolean indicating whether the point is inside the bounding box.
        internal func contains(_ point: Point) -> Bool {
            if point.x > xMin, point.x < xMax, point.y > yMin, point.y < yMax {
                return true
            } else {
                return false
            }
        }
    }
}
