# PointInPolygon
A Swift package to determine whether a point is within a polygon in a two-dimensional Cartesian coordinate system.

## Installation
### Swift Package Manager (recommended)
For fellow Swift packages, add the following to your Package.swift file:

    .package(url: "https://github.com/jonblatho/PointInPolygon.git", from: "1.0.0")
    
Or if you're using Xcode's Swift Package Manager integration to add the package to an app or other project, add the package repository URL: https://github.com/jonblatho/PointInPolygon.git.

### Manual
I don't recommend it, but you can copy the source files out of the Sources/PointInPolygon directory and include them in your project.

## How it works
Points are determined to be in a polygon by casting a rightward ray from the point and counting the number of intersections with the line segments comprising the polygon's boundary. If the number of intersections is odd, the point is inside the polygon. Otherwise, it is outside the polygon. This should work for simple polygons and polygons that intersect themselves. Polygons with holes are not currently supported.

Use a `Point` object to store two-dimensional coordinates, and initialize a polygon with an array of `Point` objects with all vertices of the polygon. There's also a convenience init available for an array of `CGPoint` objects.
