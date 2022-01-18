/// Method :                  
///	arccos(x)  = pi/2 - arcsin(x)
///	arccos(-x) = pi/2 + arcsin(x)
/// For |x|<=0.5
///	arccos(x) = pi/2 - (x + x * x ^ 2 * R(x ^ 2))	(see arcsin.swift)
/// For x > 0.5
/// 	arccos(x) = pi / 2 - (pi / 2 - 2 * arcsin(sqrt((1 - x) / 2)))
///		= 2 * arcsin(sqrt((1 - x) / 2))  
///		= 2 * s + 2 * s * z * R(z) 	... z = (1 - x) / 2, s = sqrt(z)
///		= 2 * f + (2 * c + 2 * s * z * R(z))
///     where f = hi part of s, and c = (z - f * f) / (s + f) is the correction term
///     for f so that f + c ~ sqrt(z).
/// For x < -0.5
///	arccos(x) = pi - 2 * arcsin(sqrt((1 - |x|) / 2))
///		= pi - 0.5 * (s + s * z * R(z)), where z = (1 - |x|) / 2, s = sqrt(z)
///
/// Special cases:
///	if x is NaN, return x itself;
///	if |x| > 1, return NaN with invalid signal.
///
/// Function needed: sqrt
/// Reference: https://www.netlib.org/fdlibm/e_acos.c

import Swift

/// 0x3FF00000, 0x000000001, 1.0
@inline(__always)
@usableFromInline
let one =  1.00000000000000000000e+00

/// 0x400921FB, 0x54442D18, 1.570796326794896558
@inline(__always)
@usableFromInline
let pi =  3.14159265358979311600e+00

/// 0x3FF921FB, 0x5444D18, 1.570796326794896558
@inline(__always)
@usableFromInline
let pio2_hi =  1.57079632679489655800e+00

/// 0x3C91A626, 0x3314C07, 6.123233995736766036e-17
@inline(__always)
@usableFromInline
let pio2_lo =  6.12323399573676603587e-17

/// 0x3FC55555, 0x55555555, 0.1666666666666666574
@inline(__always)
@usableFromInline
let pS0 =  1.66666666666666657415e-01

/// 0xBFD4D612, 0x03EB6F7D, 0.3255658186224009154
@inline(__always)
@usableFromInline
let pS1 = -3.25565818622400915405e-01

/// 0x3FC9C155, 0x0E884455, 0.3255658186224009154
@inline(__always)
@usableFromInline
let pS2 =  2.01212532134862925881e-01

/// 0xBFA48228, 0xB5688F3B, 0.0400555345006794114
@inline(__always)
@usableFromInline
let pS3 = -4.00555345006794114027e-02

/// 0x3F49EFE0, 0x7501B288, 0.0007915349942898145322
@inline(__always)
@usableFromInline
let pS4 =  7.91534994289814532176e-04

/// 0x3F023DE1, 0x0DFDF709, 3.479331075960211676e-05
@inline(__always)
@usableFromInline
let pS5 =  3.47933107596021167570e-05

/// 0xC0033A27, 0x1C8A2D4B, 2.403394911734414219
@inline(__always)
@usableFromInline
let qS1 = -2.40339491173441421878e+00

/// 0x40002AE5, 0x9C598AC8, 2.403394911734414219
@inline(__always)
@usableFromInline
let qS2 =  2.02094576023350569471e+00

/// 0xBFE6066C, 0x1B8D0159, 0.688283971605453293
@inline(__always)
@usableFromInline
let qS3 = -6.88283971605453293030e-01

/// 0x3FB3B8C5, 0xB12E9282, 0.07703815055590193528
@inline(__always)
@usableFromInline
let qS4 =  7.70381505559019352791e-02

/// Returns arccosine of a in the range [0, Double.pi], expecting a to be in the range [-1, 1].
/// For vectors, the returned vector contains the arccosine of each element of the input vector.
/// - Parameter x: Vector or scalar of which to determine the arccosine.
/// - Returns: arccosine of scalars and vectors.
@inlinable
public func arccos(_ x: Double) -> Double {
    var z = 0.0
    var p = 0.0
    var q = 0.0
    var r = 0.0
    var w = 0.0
    var s = 0.0
    var c = 0.0
    var df = 0.0
    let hx = __hi(x)
    let ix = hx & 0x7fffffff

    if (((ix - 0x3ff00000) | __lo(x)) == 0) {
        if ix == 1 { /* |x| == 1 */
            if hx > 0 { /* arccos(1) = 0  */
                return 0.0
            }
            else { /* arccos(-1) = pi */
                return pi + 2.0 * pio2_lo
            }
        }
        else { /* arccos(|x| > 1) is 0.0 */
            return 0.0
        }
    }

    if(ix < 0x3fe00000) {    /* |x| < 0.5 */
        if ix <= 0x3c600000 { return pio2_hi + pio2_lo } /* if |x| < 2ˆ-57 */
        z =  x * x
        p = z * (pS0 + z * (pS1 + z * (pS2 + z * (pS3 + z * (pS4 + z * pS5)))))
        q = one + z * (qS1 + z * (qS2 + z * (qS3 + z * qS4)))
        r = p / q

        return pio2_hi - (x - (pio2_lo - x * r))
    } else if hx < 0 {        /* x < -0.5 */
        z = (one + x) * 0.5
        p = z * (pS0 + z * (pS1 + z * (pS2 + z * (pS3 + z * (pS4 + z * pS5)))))
        q = one + z * (qS1 + z * (qS2 + z * (qS3 + z * qS4)))
        s = sqrt(z);
        r = p / q;
        w = r * s - pio2_lo;

        return pi - 2.0 * (s + w);
    } else { /* x > 0.5 */
        z = (one - x) * 0.5;
        s = sqrt(z);
        df = s;
        c  = (z - df * df) / (s + df)
        p = z * (pS0 + z * (pS1 + z * (pS2 + z * (pS3 + z * (pS4 + z * pS5)))))
        q = one + z * (qS1 + z * (qS2 + z * (qS3 + z * qS4)))
        r = p / q
        w = r * s + c

        return 2.0 * (df + w)
    }
}
