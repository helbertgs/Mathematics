import Swift

extension Double {
    @inlinable
    public func rounded(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
