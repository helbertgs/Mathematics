import Swift

@frozen public struct Vector : Equatable, Hashable {

    // MARK: - Public Property(ies).

    /// X component of the vector.
    public var x: Double

    /// Y component of the vector.
    public var y: Double

    /// Z component of the vector.
    public var z: Double

    // MARK: - Special Value(s).

    /// Shorthand for writing Vector(x: 0, y: 0, z: 0).
    public static var zero = Vector()

    // MARK: - Constructor(s).

    /// Creates a new vector with given x, y, z components.
    /// - Parameters:
    ///   - x: X component of the vector.
    ///   - y: Y component of the vector.
    ///   - z: Z component of the vector.
    @inlinable public init(x: Double = 0, y: Double = 0, z: Double = 0) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Access the x, y, z components using [0], [1], [2] respectively.
    @inlinable public subscript(_ component: Int) -> Double {
        switch component {
            case 0: return x
            case 1: return y
            case 2: return z
            default: fatalError("Index out of range")
        }
    }

    // MARK: - Operator(s).

    /// Returns true if two vectors are approximately equal.
    /// - Parameters:
    ///   - a: Vector a.
    ///   - b: Vector b.
    @inlinable public static func == (_ a: Vector, _ b: Vector) -> Bool {
        a.x == b.x && a.y == b.y && a.z == b.z
    }

    /// Adds two vectors.
    /// - Parameters:
    ///   - a: Vector a.
    ///   - b: Vector b.
    /// - Returns: Vector.
    @inlinable public static func + (_ a: Vector, _ b: Vector) -> Vector {
        .init(x: a.x + b.x, y: a.y + b.y, z: a.z + b.z)
    }

    /// Adds one vector by a number.
    /// - Parameters:
    ///   - a: Vector a.
    ///   - b: Number b.
    /// - Returns: Vector.
    @inlinable public static func + (_ a: Vector, _ b: Double) -> Vector {
        .init(x: a.x + b, y: a.y + b, z: a.z + b)
    }

    /// Subtracts one vector from another.
    /// - Parameters:
    ///   - a: Vector a.
    ///   - b: Vector b.
    /// - Returns: Vector.
    @inlinable public static func - (_ a: Vector, _ b: Vector) -> Vector {
        .init(x: a.x - b.x, y: a.y - b.y, z: a.z - b.z)
    }

    /// Subtracts a vector by a number.
    /// - Parameters:
    ///   - a: Vector a.
    ///   - b: Number b.
    /// - Returns: Vector.
    @inlinable public static func - (_ a: Vector, _ b: Double) -> Vector {
        .init(x: a.x - b, y: a.y - b, z: a.z - b)
    }

    /// Multiplies a vector by a number.
    /// - Parameters:
    ///   - a: Vector a.
    ///   - b: Number b.
    /// - Returns: Vector.
    @inlinable public static func * (_ a: Vector, _ b: Double) -> Vector {
        .init(x: a.x * b, y: a.y * b, z: a.z * b)
    }

    /// Divides a vector by a number.
    /// - Parameters:
    ///   - a: Vector a.
    ///   - b: Number b.
    /// - Returns: Vector.
    @inlinable public static func / (_ a: Vector, _ b: Double) -> Vector {
        guard b != 0 else { return .zero }
        return .init(x: a.x / b, y: a.y / b, z: a.z / b)
    }

    // MARK: - Hash

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
}
