import Foundation

extension Polygon {
    /**
     Cases describing possible results of `Polygon.containsPoint(_point:)`.
     */
    public enum ContainsPointResult {
        /// The point is within the polygon's boundary.
        case pointInside
        /// The point is on the boundary of the polygon.
        case pointOnBoundary
        /// The point is outside the polygon's boundary.
        case pointOutside
        /// An invalid polygon was provided.
        case invalidPolygon
    }
}
