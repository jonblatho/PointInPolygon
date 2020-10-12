extension Array where Element == Point {
    /// Returns only the unique points in the array.
    var unique: [Point] {
        return Array(Set<Point>(self))
    }
}
