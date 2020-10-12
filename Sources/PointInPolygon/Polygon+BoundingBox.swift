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
