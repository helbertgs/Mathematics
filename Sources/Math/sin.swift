import Swift

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
