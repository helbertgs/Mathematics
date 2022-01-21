import Swift

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
