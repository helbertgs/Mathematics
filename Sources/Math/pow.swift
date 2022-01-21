import Swift

@inlinable public func pow(_ x: Double, _ y: Double) -> Double {
    if y == 0 { return 1 }
    if x == 0 { return 0 }

    return x * pow(x, y - 1)
}
