# PointInPolygon
A Swift package to determine whether a point is within a polygon in a two-dimensional Cartesian coordinate system.

## Installation
### Swift Package Manager (recommended)
For fellow Swift packages, add the following to your Package.swift file:

    .package(url: "https://github.com/jonblatho/PointInPolygon.git", from: "2.0.0")
    
Or if you're using Xcode's Swift Package Manager integration to add the package to an app or other project, add the package repository URL: https://github.com/jonblatho/PointInPolygon.git.

### Manual
I don't recommend it, but you can copy the source files out of the Sources/PointInPolygon directory and include them in your project.

## How it works
Points are determined to be in a polygon by casting a rightward ray from the point and counting the number of intersections with the line segments comprising the polygon's boundary. If the number of intersections is odd, the point is inside the polygon. Otherwise, it is outside the polygon.

Use the `Point` type to store two-dimensional coordinates. There are two inits available for the `Polygon` type:

* `Polygon(points:holes:)` initializes a polygon with an array of points and any hole polygons.
* `Polygon(cgPoints:holes:)` initializes a polygon with an array of `CGPoint`s and any hole polygons. This init is only available on platforms which can import Core Graphics (i.e., Apple platforms).

By default for both inits, `holes: [Polygon] = []`.

Then, use `Polygon.containsPoint(_point:)` to check whether a polygon contains a point, or whether that point lies on the polygon’s boundary. This method returns one of the following enum types:

* `.pointInside`: The point is inside, but not on, the polygon’s boundary.
* `.pointOnBoundary`: The point is on the polygon’s boundary.
* `.pointOutside`: The point is outside, but not on, the polygon's boundary.
* `.invalidPolygon`: The supplied polygon was not evaluable (e.g., too few points).

### Notes on hole polygons
* You can nest holes within multiple levels of polygons or add them all to the list in the “parent” polygon. Either case will not impact the result of `Polygon.containsPoint(_point:)`. 
* If two hole polygons overlap, the intersection area will be considered part of the polygon; if there is a hole in the intersection area, it will *not* be considered part of the polygon…and so on.
