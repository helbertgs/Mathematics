import Swift

@usableFromInline
typealias Byte = UInt32

@inline(__always)
@usableFromInline
func __memory<T>(_ value: T) -> [Byte] where T: SignedNumeric & Comparable {
    var value = abs(value)
    return withUnsafePointer(to: &value) {
        $0.withMemoryRebound(to: Byte.self, capacity: MemoryLayout<T>.size) {
            Array(UnsafeBufferPointer(start: $0, count: MemoryLayout<T>.size))
        }
    }
}

@inline(__always)
@usableFromInline
func __hi<T>(_ value: T) -> Int where T: SignedNumeric & Comparable {
    Int(__memory(abs(value))[1])
}

@inline(__always)
@usableFromInline
func __lo<T>(_ value: T) -> Int where T: SignedNumeric & Comparable {
    Int(__memory(value)[0])
}

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

@inlinable public func arcsin(_ x: Double) -> Double {
    let negate = x < 0 ? 1.0 : 0.0
    let x = abs(x)
    var ret = -0.0187293
    ret *= x
    ret += 0.0742610
    ret *= x
    ret -= 0.2121144
    ret *= x
    ret += 1.5707288
    ret = 3.14159265358979 * 0.5 - sqrt(1.0 - x) * ret

    return ret - 2 * negate * ret
}

@inlinable public func sin(_ x: Double) -> Double {
    let x = (x + Double.pi).truncatingRemainder(dividingBy: (2 * Double.pi)) - Double.pi
    var y = 0.0
    var t = 1.0
    var p = 1.0

    for _ in 0...10 {
        y += (Double(pow(x, p)) / factorial(p)) * t
        t *= -1
        p += 2
    }

    return y
}

@inlinable public func cos(_ x: Double) -> Double {
    let x = (x + Double.pi).truncatingRemainder(dividingBy: (2 * Double.pi)) - Double.pi
    var y = 0.0
    var t = 1.0
    var p = 0.0

    for _ in 0...10 {
        y += (Double(pow(x, p)) / factorial(p)) * t
        t *= -1
        p += 2
    }

    return y
}

@inlinable public func pow(_ x: Double, _ y: Double) -> Double {
    if y == 0 { return 1 }
    if x == 0 { return 0 }

    return x * pow(x, y - 1)
}

@inlinable public func sqrt(_ number: Double) -> Double {
    number.squareRoot()
}

@inlinable public func factorial(_ n: Double) -> Double {
    n == 0 ? 1 : n * factorial(n - 1)
}


@inlinable public func rad(degree: Double) -> Double {
    degree * (Double.pi / 180)
}

@inlinable public func degree(rad: Double) -> Double {
    rad * (180 / Double.pi)
}

