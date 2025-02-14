/*
 * cos function on [-pi/4, pi/4], pi/4 ~ 0.785398164
 * Input x is assumed to be bounded by ~pi/4 in magnitude.
 * Input y is the tail of x. 
 *
 * Algorithm
 *	1. Since cos(-x) = cos(x), we need only to consider positive x.
 *	2. if x < 2^-27 (hx < 0x3e4000000), return 1 with inexact if x != 0.
 *	3. cos(x) is approximated by a polynomial of degree 14 on [0, pi / 4]
 *		  	                 4            14
 *	   	cos(x) ~ 1 - x*x/2 + C1*x + ... + C6*x
 *	   where the remez error is
 *	
 * 	|                     2         4         6         8        10        12        14 |     -58
 * 	|cos(x) - (1 - 0.5 * x  + C1 * x  + C2 * x  + C3 * x + C4 * x  + C5 * x  + C6 * x  )| <= 2
 * 	|    					               | 
 * 
 * 	                 4        6        8        10       12        14
 *	4. let r = C1 * x + C2 * x + C3 * x + C4 * x + C5 * x  + C6 * x  , then
 *	       cos(x) = 1 - x * x / 2 + r
 *	   since cos(x + y) ~ cos(x) - sin(x) * y
 *			  ~ cos(x) - x * y,
 *	   a correction term is necessary in cos(x) and hence
 *		cos(x + y) = 1 - (x * x / 2 - (r - x * y))
 *	   For better accuracy when x > 0.3, let qx = |x|/4 with
 *	   the last 32 bits mask off, and if x > 0.78125, let qx = 0.28125.
 *	   Then
 *		cos(x + y) = (1 - qx) - ((x * x / 2 - qx) - (r - x * y)).
 *	   Note that 1 - qx and (x * x / 2 - qx) is EXACT here, and the
 *	   magnitude of the latter is at least a quarter of x * x / 2,
 *	   thus, reducing the rounding error in the subtraction.
 */

import Swift

    /// 0x3FF00000, 0x00000000
@inline(__always)
fileprivate let one =  1.00000000000000000000e+00

/// 0x3FA55555, 0x5555554C
@inline(__always)
fileprivate let c1  =  4.16666666666666019037e-02 

/// 0xBF56C16C, 0x16C15177
@inline(__always)
fileprivate let c2  = -1.38888888888741095749e-03 

/// 0x3EFA01A0, 0x19CB1590
@inline(__always)
fileprivate let c3  =  2.48015872894767294178e-05 

/// 0xBE927E4F, 0x809C52AD
@inline(__always)
fileprivate let c4  = -2.75573143513906633035e-07 

/// 0x3E21EE9E, 0xBDB4B1C4
@inline(__always)
fileprivate let c5  =  2.08757232129817482790e-09 

/// 0xBDA8FAE9, 0xBE8838D4
@inline(__always)
fileprivate let c6  = -1.13596475577881948265e-11 

@inline(__always)
public func cos(_ x: Double, _ y: Double) -> Double {
    var a = 0.0
    var hz = 0.0
    var z = 0.0
    var r = 0.0
    var qx = 0.0

    var ix = 0

    ix = __hi(x) & 0x7fffffff // ix = |x|'s high word
    if ix < 0x3e400000 { // if x < 2ˆ27
        if x == 0 {
            return one // generate inexact
        }
    }
    z  = x * x
    r  = z * (c1 + z * (c2 + z * (c3 + z * (c4 + z * (c5 + z * c6)))))
    if ix < 0x3FD33333 { // if |x| < 0.3
        return one - (0.5 * z - (z * r - x * y))
    }
    else {
        if ix > 0x3fe90000 { // x > 0.78125
            qx = 0.28125
        } else {
            // __hi(qx) = ix - 0x00200000 // x / 4
            // __lo(qx) = 0
        }

        hz = 0.5 * z - qx
        a  = one - qx

        return a - (hz - (z * r - x * y))
    }
}
