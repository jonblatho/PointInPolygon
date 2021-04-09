extension Polygon {
    /// Defines a line segment as a pair of points.
    internal struct LineSegment: Hashable {
        /// The starting point of the line segment.
        internal var start: Point
        /// The endpoint of the line segment.
        internal var end: Point

        /// Indicates whether the line is horizontal, vertical, or neither.
        private var type: LineType {
            if start.y == end.y {
                return .horizontal
            }
            if start.x == end.x {
                return .vertical
            }
            return .sloped
        }

        /// The minimum x-value in the line segment.
        private var xMin: Double {
            return [start.x, end.x].min()!
        }

        /// The maximum x-value in the line segment.
        private var xMax: Double {
            return [start.x, end.x].max()!
        }

        /// The minimum y-value in the line segment.
        private var yMin: Double {
            return [start.y, end.y].min()!
        }

        /// The maximum y-value in the line segment.
        private var yMax: Double {
            return [start.y, end.y].max()!
        }

        /// The slope of the line segment.
        internal var slope: Double? {
            switch type {
            case .horizontal:
                return 0
            case .sloped:
                // A sloped line has slope defined as m = (rise) / (run).
                let rise = end.y - start.y
                let run = end.x - start.x
                return rise / run
            case .vertical:
                // A vertical line has slope m = ∞. Return nil.
                return nil
            }
        }

        /// The y-value along the line containing the line segment associated with x = 0.
        internal var yAxisIntercept: Double? {
            if let slope = slope {
                return start.y - slope * start.x
            }
            return nil
        }

        /// Determines the x-value at which a horizontal line through a given point would intercept the line segment.
        internal func horizontalIntercept(for point: Point) -> Double? {
            if let slope = slope, let yAxisIntercept = yAxisIntercept, slope != 0 {
                return (point.y - yAxisIntercept) / slope
            } else if yAxisIntercept == nil {
                return point.y
            }
            return nil
        }

        /// The bounding box containing the line segment.
        private var bounds: BoundingBox? {
            return BoundingBox(points: [start, end])
        }

        /**
         Whether the given point lies on the line segment.
         
         - parameter point: The `Point` object to check against the line segment.
         - returns: A Boolean indicating whether the point lies on the line segment.
         */
        internal func pointIsOnSegment(point: Point) -> Bool {
            if let bounds = bounds, bounds.contains(point) {
                switch type {
                case .vertical:
                    return point.x == xMin
                case .horizontal:
                    return point.y == yMin
                case .sloped:
                    return point.x == horizontalIntercept(for: point)
                }
            }
            return false
        }

        /**
         Indicates whether a ray extending rightward from the given point will intersect the line segment.
         
         - parameter point: The point from which a ray will extend rightward.
         - returns: If there is an intersection, the function will
         return the coordinates of the intersection. If not, returns nil.
        */
        internal func rightwardRayIntersection(from point: Point) -> Intersection? {
            guard point.y >= yMin, point.y <= yMax else {
                // The point is outside the vertical extent of the line segment so there will never be an intersection.
                return nil
            }

            switch type {
            case .horizontal:
                return nil
            case .vertical:
                if point.x < xMax {
                    return Intersection(x: xMax, y: point.y)
                } else {
                    return nil
                }
            case .sloped:
                // Determine whether the intercept of a line extending horizontally
                // from the point happens to the left or right of the point.
                if let intercept = horizontalIntercept(for: point), intercept > point.x {
                    return Intersection(x: intercept, y: point.y)
                }
                return nil
            }
        }
    }

    /// Whether the line segment is horizontal, sloped, or vertical.
    fileprivate enum LineType {
        /// The line segment is horizontal.
        case horizontal
        /// The line segment is neither horizontal nor vertical.
        case sloped
        /// The line segment is vertical.
        case vertical
    }
}
