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

/// Returns arccosine of a in the range [0, Double.pi], expecting a to be in the range [-1, 1].
/// For vectors, the returned vector contains the arccosine of each element of the input vector. 
/// - Parameter a: Vector or scalar of which to determine the arccosine.
/// - Returns: arccosine of scalars and vectors.
@inlinable public func arccos(_ a: Double) -> Double {
    let n = a < 0 ? 1.0 : 0.0
    let x = abs(a)
    var r = -0.0187293
    r = r * x
    r += 0.0742610
    r = r * x
    r = r - 0.2121144
    r = r * x
    r = r + 1.5707288
    r = r * (1.0 - x).squareRoot()
    r = r - (2.0 * n * r)

    return n * Double.pi + r
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

