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

@inlinable public func rad(degree: Double) -> Double {
    degree * (Double.pi / 180)
}

@inlinable public func degree(rad: Double) -> Double {
    rad * (180 / Double.pi)
}

@inlinable public func factorial(_ n: Double) -> Double {
    n == 0 ? 1 : n * factorial(n - 1)
}
