import Swift

/// For vectors, the returned vector contains the absolute value of each element of the input vector.
/// - Parameter a: Vector or scalar of which to determine the absolute value.
/// - Returns: Returns absolute value of scalars and vectors.
@inlinable public func abs(_ a: Double) -> Double {
    a < 0 ? -a : a
}

/// For vectors, the returned vector contains the absolute value of each element of the input vector.
/// - Parameter a: Vector or scalar of which to determine the absolute value.
/// - Returns: Returns absolute value of scalars and vectors.
@inlinable public func abs(_ a: Vector) -> Vector {
    .init(x: abs(a.x), y: abs(a.y), z: abs(a.z))
}
