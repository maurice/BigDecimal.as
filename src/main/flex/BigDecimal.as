package
{
import flash.utils.getQualifiedClassName;

//##header 1189099963000 FOUNDATION
/* Generated from 'BigDecimal.nrx' 8 Sep 2000 11:10:50 [v2.00] */
/* Options: Binary Comments Crossref Format Java Logo Strictargs Strictcase Trace2 Verbose3 */

/* ------------------------------------------------------------------ */
/* BigDecimal -- Decimal arithmetic for Java */
/* ------------------------------------------------------------------ */
/* Copyright IBM Corporation, 1996-2006. All Rights Reserved. */
/* */
/* The BigDecimal class provides immutable arbitrary-precision */
/* floating point (including integer) decimal numbers. */
/* */
/* As the numbers are decimal, there is an exact correspondence */
/* between an instance of a BigDecimal object and its String */
/* representation; the BigDecimal class provides direct conversions */
/* to and from String and character array objects, and well as */
/* conversions to and from the Java primitive types (which may not */
/* be exact). */
/* ------------------------------------------------------------------ */
/* Notes: */
/* */
/* 1. A BigDecimal object is never changed in value once constructed; */
/* this avoids the need for locking. Note in particular that the */
/* mantissa array may be shared between many BigDecimal objects, */
/* so that once exposed it must not be altered. */
/* */
/* 2. This class looks at MathContext class fields directly (for */
/* performance). It must not and does not change them. */
/* */
/* 3. Exponent checking is delayed until finish(), as we know */
/* intermediate calculations cannot cause 31-bit overflow. */
/* [This assertion depends on MAX_DIGITS in MathContext.] */
/* */
/* 4. Comments for the public API now follow the javadoc conventions. */
/* The NetRexx -comments option is used to pass these comments */
/* through to the generated Java code (with -format, if desired). */
/* */
/* 5. System.arraycopy is faster than explicit loop as follows */
/* Mean length 4: equal */
/* Mean length 8: x2 */
/* Mean length 16: x3 */
/* Mean length 24: x4 */
/* From prior experience, we expect mean length a little below 8, */
/* but arraycopy is still the one to use, in general, until later */
/* measurements suggest otherwise. */
/* */
/* 6. 'DMSRCN' referred to below is the original (1981) IBM S/370 */
/* assembler code implementation of the algorithms below; it is */
/* now called IXXRCN and is available with the OS/390 and VM/ESA */
/* operating systems. */
/* ------------------------------------------------------------------ */
/* Change History: */
/* 1997.09.02 Initial version (derived from netrexx.lang classes) */
/* 1997.09.12 Add lostDigits checking */
/* 1997.10.06 Change mantissa to a byte array */
/* 1997.11.22 Rework power [did not prepare arguments, etc.] */
/* 1997.12.13 multiply did not prepare arguments */
/* 1997.12.14 add did not prepare and align arguments correctly */
/* 1998.05.02 0.07 packaging changes suggested by Sun and Oracle */
/* 1998.05.21 adjust remainder operator finalization */
/* 1998.06.04 rework to pass MathContext to finish() and round() */
/* 1998.06.06 change format to use round(); support rounding modes */
/* 1998.06.25 rename to BigDecimal and begin merge */
/* zero can now have trailing zeros (i.e., exp\=0) */
/* 1998.06.28 new methods: movePointXxxx, scale, toBigInteger */
/* unscaledValue, valueof */
/* 1998.07.01 improve byteaddsub to allow array reuse, etc. */
/* 1998.07.01 make null testing explicit to avoid JIT bug [Win32] */
/* 1998.07.07 scaled division [divide(BigDecimal, int, int)] */
/* 1998.07.08 setScale, faster equals */
/* 1998.07.11 allow 1E6 (no sign) <sigh>; new double/float conversion */
/* 1998.10.12 change package to com.ibm.icu.math */
/* 1998.12.14 power operator no longer rounds RHS [to match ANSI] */
/* add toBigDecimal() and BigDecimal(java.math.BigDecimal) */
/* 1998.12.29 improve byteaddsub by using table lookup */
/* 1999.02.04 lostdigits=0 behaviour rounds instead of digits+1 guard */
/* 1999.02.05 cleaner code for BigDecimal(char[]) */
/* 1999.02.06 add javadoc comments */
/* 1999.02.11 format() changed from 7 to 2 method form */
/* 1999.03.05 null pointer checking is no longer explicit */
/* 1999.03.05 simplify; changes from discussion with J. Bloch: */
/* null no longer permitted for MathContext; drop Boolean, */
/* byte, char, float, short constructor, deprecate double */
/* constructor, no blanks in string constructor, add */
/* offset and length version of char[] constructor; */
/* add valueOf(double); drop BooleanValue, charValue; */
/* add ...Exact versions of remaining convertors */
/* 1999.03.13 add toBigIntegerExact */
/* 1999.03.13 1.00 release to IBM Centre for Java Technology */
/* 1999.05.27 1.01 correct 0-0.2 bug under scaled arithmetic */
/* 1999.06.29 1.02 constructors should not allow exponent > 9 digits */
/* 1999.07.03 1.03 lost digits should not be checked if digits=0 */
/* 1999.07.06 lost digits Exception message changed */
/* 1999.07.10 1.04 more work on 0-0.2 (scaled arithmetic) */
/* 1999.07.17 improve messages from pow method */
/* 1999.08.08 performance tweaks */
/* 1999.08.15 fastpath in multiply */
/* 1999.11.05 1.05 fix problem in intValueExact [e.g., 5555555555] */
/* 1999.12.22 1.06 remove multiply fastpath, and improve performance */
/* 2000.01.01 copyright update [Y2K has arrived] */
/* 2000.06.18 1.08 no longer deprecate BigDecimal(double) */
/* ------------------------------------------------------------------ */

/**
 * The <code>BigDecimal</code> class implements immutable
 * arbitrary-precision decimal numbers. The methods of the
 * <code>BigDecimal</code> class provide operations for fixed and
 * floating point arithmetic, comparison, format conversions, and
 * hashing.
 * <p>
 * As the numbers are decimal, there is an exact correspondence between
 * an instance of a <code>BigDecimal</code> object and its
 * <code>String</code> representation; the <code>BigDecimal</code> class
 * provides direct conversions to and from <code>String</code> and
 * character array (<code>char[]</code>) objects, as well as conversions
 * to and from the Java primitive types (which may not be exact) and
 * <code>BigInteger</code>.
 * <p>
 * In the descriptions of constructors and methods in this documentation,
 * the value of a <code>BigDecimal</code> number object is shown as the
 * result of invoking the <code>toString()</code> method on the object.
 * The internal representation of a decimal number is neither defined
 * nor exposed, and is not permitted to affect the result of any
 * operation.
 * <p>
 * The floating point arithmetic provided by this class is defined by
 * the ANSI X3.274-1996 standard, and is also documented at
 * <code>http://www2.hursley.ibm.com/decimal</code>
 * <br><i>[This URL will change.]</i>
 *
 * <h3>Operator methods</h3>
 * <p>
 * Operations on <code>BigDecimal</code> numbers are controlled by a
 * {@link MathContext} object, which provides the context (precision and
 * other information) for the operation. Methods that can take a
 * <code>MathContext</code> parameter implement the standard arithmetic
 * operators for <code>BigDecimal</code> objects and are known as
 * <i>operator methods</i>. The default settings provided by the
 * constant {@link MathContext#DEFAULT} (<code>digits=9,
 * form=SCIENTIFIC, lostDigits=false, roundingMode=ROUND_HALF_UP</code>)
 * perform general-purpose floating point arithmetic to nine digits of
 * precision. The <code>MathContext</code> parameter must not be
 * <code>null</code>.
 * <p>
 * Each operator method also has a version provided which does
 * not take a <code>MathContext</code> parameter. For this version of
 * each method, the context settings used are <code>digits=0,
 * form=PLAIN, lostDigits=false, roundingMode=ROUND_HALF_UP</code>;
 * these settings perform fixed point arithmetic with unlimited
 * precision, as defined for the original BigDecimal class in Java 1.1
 * and Java 1.2.
 * <p>
 * For monadic operators, only the optional <code>MathContext</code>
 * parameter is present; the operation acts upon the current object.
 * <p>
 * For dyadic operators, a <code>BigDecimal</code> parameter is always
 * present; it must not be <code>null</code>.
 * The operation acts with the current object being the left-hand operand
 * and the <code>BigDecimal</code> parameter being the right-hand operand.
 * <p>
 * For example, adding two <code>BigDecimal</code> objects referred to
 * by the names <code>award</code> and <code>extra</code> could be
 * written as any of:
 * <p><code>
 * award.add(extra)
 * <br>award.add(extra, MathContext.DEFAULT)
 * <br>award.add(extra, acontext)
 * </code>
 * <p>
 * (where <code>acontext</code> is a <code>MathContext</code> object),
 * which would return a <code>BigDecimal</code> object whose value is
 * the result of adding <code>award</code> and <code>extra</code> under
 * the appropriate context settings.
 * <p>
 * When a <code>BigDecimal</code> operator method is used, a set of
 * rules define what the result will be (and, by implication, how the
 * result would be represented as a character string).
 * These rules are defined in the BigDecimal arithmetic documentation
 * (see the URL above), but in summary:
 * <ul>
 * <li>Results are normally calculated with up to some maximum number of
 * significant digits.
 * For example, if the <code>MathContext</code> parameter for an operation
 * were <code>MathContext.DEFAULT</code> then the result would be
 * rounded to 9 digits; the division of 2 by 3 would then result in
 * 0.666666667.
 * <br>
 * You can change the default of 9 significant digits by providing the
 * method with a suitable <code>MathContext</code> object. This lets you
 * calculate using as many digits as you need -- thousands, if necessary.
 * Fixed point (scaled) arithmetic is indicated by using a
 * <code>digits</code> setting of 0 (or omitting the
 * <code>MathContext</code> parameter).
 * <br>
 * Similarly, you can change the algorithm used for rounding from the
 * default "classic" algorithm.
 * <li>
 * In standard arithmetic (that is, when the <code>form</code> setting
 * is not <code>PLAIN</code>), a zero result is always expressed as the
 * single digit <code>'0'</code> (that is, with no sign, decimal point,
 * or exponent part).
 * <li>
 * Except for the division and power operators in standard arithmetic,
 * trailing zeros are preserved (this is in contrast to binary floating
 * point operations and most electronic calculators, which lose the
 * information about trailing zeros in the fractional part of results).
 * <br>
 * So, for example:
 * <p><code>
 * new BigDecimal("2.40").add( new BigDecimal("2")) =&gt; "4.40"
 * <br>new BigDecimal("2.40").subtract(new BigDecimal("2")) =&gt; "0.40"
 * <br>new BigDecimal("2.40").multiply(new BigDecimal("2")) =&gt; "4.80"
 * <br>new BigDecimal("2.40").divide( new BigDecimal("2"), def) =&gt; "1.2"
 * </code>
 * <p>where the value on the right of the <code>=&gt;</code> would be the
 * result of the operation, expressed as a <code>String</code>, and
 * <code>def</code> (in this and following examples) refers to
 * <code>MathContext.DEFAULT</code>).
 * This preservation of trailing zeros is desirable for most
 * calculations (including financial calculations).
 * If necessary, trailing zeros may be easily removed using division by 1.
 * <li>
 * In standard arithmetic, exponential form is used for a result
 * depending on its value and the current setting of <code>digits</code>
 * (the default is 9 digits).
 * If the number of places needed before the decimal point exceeds the
 * <code>digits</code> setting, or the absolute value of the number is
 * less than <code>0.000001</code>, then the number will be expressed in
 * exponential notation; thus
 * <p><code>
 * new BigDecimal("1e+6").multiply(new BigDecimal("1e+6"), def)
 * </code>
 * <p>results in <code>1E+12</code> instead of
 * <code>1000000000000</code>, and
 * <p><code>
 * new BigDecimal("1").divide(new BigDecimal("3E+10"), def)
 * </code>
 * <p>results in <code>3.33333333E-11</code> instead of
 * <code>0.0000000000333333333</code>.
 * <p>
 * The form of the exponential notation (scientific or engineering) is
 * determined by the <code>form</code> setting.
 * <eul>
 * <p>
 * The names of methods in this class follow the conventions established
 * by <code>java.lang.Number</code>, <code>java.math.BigInteger</code>,
 * and <code>java.math.BigDecimal</code> in Java 1.1 and Java 1.2.
 *
 * @see MathContext
 * @author Mike Cowlishaw
 * @stable ICU 2.0
 */


/** ActionScript 3 conversion (c) 2009
 *   Jean-Francois Larouche, Canada
 *
 *   To know what have been changed, just search for
 *   ActionScript in this file.
 *
 *   Constructors:
 *
 *   new BigDecimal() : Default BigDecimal to 0
 *   new BigDecimal(String) : String must be a decimal representation.
 *   new BigDecimal(int)
 *   new BigDecimal(Number)
 *
 *   This class is Immutable exactly like the Java version
 *
 *   To convert the value back:
 *   decimal.numberValue();
 *   decimal.toString()
 *
 **/


public class BigDecimal
{

    // ActionScript 3 Port
    // Utility functions that does not exist in AS3
    private static function arraycopy(src:Array, srcindex:int, dest:Array, destindex:int, length:int):void
    {
        var i:int;

        if (destindex > srcindex)
        {
            // in case src and dest are equals, but also doesn't hurt
            // if they are different
            for (i = length - 1; i >= 0; --i)
            {
                dest[i + destindex] = src[i + srcindex];
            }
        }
        else
        {
            for (i = 0; i < length; ++i)
            {
                dest[i + destindex] = src[i + srcindex];
            }
        }
    }

    // ActionScript 3 Port
    // Utility functions that does not exist in AS3
    private static function createArrayWithZeros(length:int):Array
    {
        var retVal:Array = new Array(length);
        var i:int;
        for (i = 0; i < length; ++i)
        {
            retVal[i] = 0;
        }
        return retVal;
    }

    /* ----- Constants ----- */
    /* properties constant public */ // useful to others
    /**
     * The <code>BigDecimal</code> constant "0".
     *
     * @see #ONE
     * @see #TEN
     * @stable ICU 2.0
     */
    public static const ZERO:BigDecimal = BigDecimal.createStatic(0); // use long as we want the int constructor
    // .. to be able to use this, for speed

    /**
     * The <code>BigDecimal</code> constant "1".
     *
     * @see #TEN
     * @see #ZERO
     * @stable ICU 2.0
     */
    public static const ONE:BigDecimal = BigDecimal.createStatic(1); // use long as we want the int constructor
    // .. to be able to use this, for speed

    /**
     * The <code>BigDecimal</code> constant "10".
     *
     * @see #ONE
     * @see #ZERO
     * @stable ICU 2.0
     */
    public static const TEN:BigDecimal = BigDecimal.createStatic(10);

    /* properties constant private */ // locals
    private static const ispos:int = 1; // ind: indicates positive (must be 1)
    private static const iszero:int = 0; // ind: indicates zero (must be 0)
    private static const isneg:int = -1; // ind: indicates negative (must be -1)
    // [later could add NaN, +/- infinity, here]

    private static const MinExp:int = -999999999; // minimum exponent allowed
    private static const MaxExp:int = 999999999; // maximum exponent allowed

    // ActionScript 3 Port
    // In AS3 there is no char, byte or native arrays
    // So lets create the int value of each char we need in the
    // algorythms
    private static const VALUE_ZERO:int = "0".charCodeAt(0); // use long as we want the int constructor
    private static const VALUE_NINE:int = "9".charCodeAt(0); // use long as we want the int constructor
    private static const VALUE_EUPPER:int = "e".charCodeAt(0); // use long as we want the int constructor
    private static const VALUE_ELOWER:int = "E".charCodeAt(0); // use long as we want the int constructor
    private static const VALUE_DOT:int = ".".charCodeAt(0); // use long as we want the int constructor

    /* properties static private */
    // Precalculated constant arrays (used by byteaddsub)
    private static const bytecar:Array = new Array((90 + 99) + 1); // carry/borrow array
    private static const bytedig:Array = diginit(); // next digit array

    /* ----- Instance properties [all private and immutable] ----- */
    /* properties private */

    /**
     * The indicator. This may take the values:
     * <ul>
     * <li>ispos -- the number is positive
     * <li>iszero -- the number is zero
     * <li>isneg -- the number is negative
     * </ul>
     *
     * @serial
     */
    private var ind:int; // assumed undefined
    // Note: some code below assumes IND = Sign [-1, 0, 1], at present.
    // We only need two bits for this, but use a byte [also permits
    // smooth future extension].

    /**
     * The formatting style. This may take the values:
     * <ul>
     * <li>MathContext.PLAIN -- no exponent needed
     * <li>MathContext.SCIENTIFIC -- scientific notation required
     * <li>MathContext.ENGINEERING -- engineering notation required
     * </ul>
     * <p>
     * This property is an optimization; it allows us to defer number
     * layout until it is actually needed as a string, hence avoiding
     * unnecessary formatting.
     *
     * @serial
     */
    private var form:int = MathContext.NOTATION_PLAIN; // assumed PLAIN
    // We only need two bits for this, at present, but use a byte
    // [again, to allow for smooth future extension]

    /**
     * The value of the mantissa.
     * <p>
     * Once constructed, this may become shared between several BigDecimal
     * objects, so must not be altered.
     * <p>
     * For efficiency (speed), this is a byte array, with each byte
     * taking a value of 0 -> 9.
     * <p>
     * If the first byte is 0 then the value of the number is zero (and
     * mant.length=1, except when constructed from a plain number, for
     * example, 0.000).
     *
     * @serial
     */
    private var mant:Array; // assumed null

    /**
     * The exponent.
     * <p>
     * For fixed point arithmetic, scale is <code>-exp</code>, and can
     * apply to zero.
     *
     * Note that this property can have a value less than MinExp when
     * the mantissa has more than one digit.
     *
     * @serial
     */
    private var exp:int;
    // assumed 0

    /* ---------------------------------------------------------------- */
    /* Constructors */
    /* ---------------------------------------------------------------- */

    /**
     * Constructs a new <code>BigDecimal</code> instance from a given unscaled value
     * <code>unscaledVal</code> and a given scale. The value of this instance is
     * <code>unscaledVal</code> (<code>10^-scale</code>). The result is rounded according
     * to the specified math context.
     *
     * @param unscaledValue
     *            <code>String</code> representing the unscaled integer value of this
     *            <code>BigDecimal</code> instance.
     * @param scale
     *            scale of this <code>BigDecimal</code> instance.
     * @param context
     *            rounding mode and precision for the result of this operation.
     * @throws ArgumentError
     *             if <code>mc.precision > 0</code> and
     *             <code>context.roundingMode == UNNECESSARY</code>
     *             and the new big decimal cannot be represented
     *             within the given precision without rounding.
     * @throws TypeError
     *             if <code>unscaledValue == null</code>.
     */
    public static function createFromUnscaledInteger(unscaledValue:String, scale:int = 0, context:MathContext = null):BigDecimal
    {
        if (unscaledValue == null)
        {
            throw new TypeError("The unscaledValue parameter cannot be null");
        }
        const d:BigDecimal = new BigDecimal(unscaledValue);
        if (d.exp != 0 && scale)
        {
            throw new ArgumentError("The unscaledValue '" + unscaledValue + "' already has a scale!");
        }
        d.exp = -scale;
        return d.plus(context);
    }

    /**
     * Constructs a <code>BigDecimal</code> object from the given input.
     * <p>
     * The given <code>inobject</code> may be a <code>String</code> (in which
     * case <code>offset</code> and <code>length</code> describe the part
     * of the String to use), an <code>int</code>, a <code>Number</code>
     *
     * @param inobject An <code>Object</code> to create the <code>BigDecimal</code> from;
     * should not be null, NaN, +Infinity or -Infinity
     * @param offset If <code>inobject</code> is a <code>String</code>, the offset into
     * character array of the start of the number to be converted.
     * @param length If <code>inobject</code> is a <code>String</code>, the length of the number
     */
    public function BigDecimal(inobject:Object = 0, offset:int = 0, length:int = -1)
    {
        var si:int = 0;
        var eneg:Boolean = false;
        var k:int = 0;
        var elen:int = 0;
        var j:int = 0;
        var sj:int = 0;
        var dvalue:int = 0;
        var mag:int = 0;
        var inchars:String = null;

        //ActionScript 3 :
        //This is only for the createStatic
        //People should never pass null to the constructor
        if (inobject == null)
        {
            return;
        }

        //Path the multiple possibilities of constructing
        if (inobject is int)
        {
            createFromInt(inobject as int);
            return;
        }
        else if (inobject is Number)
        {
            if (isNaN(Number(inobject)) || !isFinite(Number(inobject)))
            {
                throw new ArgumentError("Infinite or NaN");
            }
            inchars = (inobject as Number).toString();
        }
        else if (!(inobject is String))
        {
            throw new ArgumentError("Unhandled parameter type: " + getQualifiedClassName(inobject));
        }
        else
        {
            inchars = inobject as String;
        }

        //Default parameter correction
        if (length == -1)
        {
            length = inchars.length;
        }

        // This is the primary constructor; all incoming strings end up
        // here; it uses explicit (inline) parsing for speed and to avoid
        // generating intermediate (temporary) objects of any kind.
        // 1998.06.25: exponent form built only if E/e in string
        // 1998.06.25: trailing zeros not removed for zero
        // 1999.03.06: no embedded blanks; allow offset and length
        if (length <= 0)
        {
            bad(inchars); // bad conversion (empty string)
            // [bad offset will raise array bounds exception]
        }

        /* Handle and step past sign */
        ind = ispos; // assume positive

        if (inchars.charAt(offset) == "-")
        {
            length--;

            if (length == 0)
            {
                bad(inchars); // nothing after sign
            }
            ind = isneg;
            offset++;
        }
        else if (inchars.charAt(offset) == "+")
        {
            length--;
            if (length == 0)
            {
                bad(inchars); // nothing after sign
            }
            offset++;
        }

        /* We're at the start of the number */
        var exotic:Boolean = false; // have extra digits
        var hadexp:Boolean = false; // had explicit exponent
        var d:int = 0; // count of digits found
        var dotoff:int = -1; // offset where dot was found
        var last:int = -1; // last character of mantissa

        for (var $1:int = length, i:int = offset; $1 > 0; $1--, i++) /*i*/
        {
            si = inchars.charCodeAt(i);
            if (si >= BigDecimal.VALUE_ZERO)
            {
                // test for Arabic digit
                if (si <= BigDecimal.VALUE_NINE)
                {
                    last = i;
                    d++; // still in mantissa
                    continue;
                }
            }

            if (si == BigDecimal.VALUE_DOT)
            {
                // record and ignore
                if (dotoff >= 0)
                {
                    bad(inchars); // two dots
                }
                dotoff = i - offset; // offset into mantissa
                continue /*i*/;
            }

            if (si != BigDecimal.VALUE_ELOWER)
            {
                if (si != BigDecimal.VALUE_EUPPER)
                {
                    // expect an extra digit
                    if (si < BigDecimal.VALUE_ZERO || si > BigDecimal.VALUE_NINE)
                    {
                        bad(inchars); // not a number
                    }
                    // defer the base 10 check until later to avoid extra method call
                    exotic = true; // will need conversion later
                    last = i;
                    d++; // still in mantissa
                    continue /*i*/;
                }
            }

            /* Found 'e' or 'E' -- now process explicit exponent */
            // 1998.07.11: sign no longer required
            if (i - offset > length - 2)
            {
                bad(inchars); // no room for even one digit
            }
            eneg = false;

            if (inchars.charAt(i + 1) == "-")
            {
                eneg = true;
                k = i + 2;
            }
            else if (inchars.charAt(i + 1) == "+")
            {
                k = i + 2;
            }
            else
            {
                k = i + 1;
            }

            // k is offset of first expected digit
            elen = length - (k - offset); // possible number of digits
            if (elen == 0 || elen > 9)
            {
                bad(inchars); // 0 or more than 9 digits
            }

            j = k;
            for (var $2:int = elen; $2 > 0; $2--, j++) /*j*/
            {
                sj = inchars.charCodeAt(j);
                if (sj < BigDecimal.VALUE_ZERO)
                {
                    bad(inchars); // always bad
                }
                if (sj > BigDecimal.VALUE_NINE)
                {
                    // maybe an exotic digit
                    // ActionScript 3 PORT
                    // Lets forget exotics for now... i dont have time.
                    //if ((!(isDigit(sj)))) {
                    //    bad(inchars); // not a number
                    //}
                    //dvalue=java.lang.Character.digit(sj,10); // check base
                    //if (dvalue<0) {
                    bad(inchars); // not base 10
                    //}
                }
                else
                {
                    dvalue = (sj) - (BigDecimal.VALUE_ZERO);
                }
                exp = (exp * 10) + dvalue;
            }
            /*j*/

            if (eneg)
            {
                exp = -exp; // was negative
            }

            hadexp = true; // remember we had one
            break; // we are done
        }
        /*i*/

        /* Here when all inspected */
        if (d == 0)
        {
            bad(inchars); // no mantissa digits
        }
        if (dotoff >= 0)
        {
            exp = (exp + dotoff) - d; // adjust exponent if had dot
        }

        /* strip leading zeros/dot (leave final if all 0's) */
        var $3:int = last - 1;
        i = offset;

        for (; i <= $3; i++) /*i*/
        {
            si = inchars.charCodeAt(i);
            if (si == BigDecimal.VALUE_ZERO)
            {
                offset++;
                dotoff--;
                d--;
            }
            else if (si == BigDecimal.VALUE_DOT)
            {
                offset++; // step past dot
                dotoff--;
            }
            else if (si <= BigDecimal.VALUE_NINE)
            {
                break;
                /* non-0 */
            }
            else
            {
                /* exotic */
                // ActionScript 3 PORT
                // Lets forget exotics for now... i dont have time.
                //if ((java.lang.Character.digit(si,10))!=0) {
                break; // non-0 or bad
                //}

                // is 0 .. strip like '0'
                //offset++;
                //dotoff--;
                //d--;
            }
        }
        /*i*/

        /* Create the mantissa array */
        mant = new Array(d); // we know the length
        j = offset; // input offset

        if (exotic)
        {
            /* exotica: */
            // slow: check for exotica
            var $4:int = d;
            i = 0;

            for (; $4 > 0; $4--, i++)
            {
                if (i == dotoff)
                {
                    j++; // at dot
                }
                sj = inchars[j];
                if (sj <= BigDecimal.VALUE_NINE)
                {
                    mant[i] = (sj - VALUE_ZERO);
                    /* easy */
                }
                else
                {
                    // ActionScript 3 PORT
                    // Lets forget exotics for now... i dont have time.
                    //dvalue=java.lang.Character.digit(sj,10);
                    //if (dvalue<0) {
                    bad(inchars); // not a number after all
                    //}
                    //mant[i]=(byte)dvalue;
                }

                j++;
            }
        }
        else /*simple*/
        {
            var $5:int = d;
            i = 0;
            for (; $5 > 0; $5--, i++)
            {
                if (i == dotoff)
                {
                    j++;
                }
                mant[i] = (inchars.charCodeAt(j) - (BigDecimal.VALUE_ZERO));
                j++;
            }
        }
        /*simple*/

        /* Looks good. Set the sign indicator and form, as needed. */
        // Trailing zeros are preserved
        // The rule here for form is:
        // If no E-notation, then request plain notation
        // Otherwise act as though add(0,DEFAULT) and request scientific notation
        // [form is already PLAIN]
        if (mant[0] == 0)
        {
            ind = iszero; // force to show zero
        }
        else
        {
            // non-zero
            // [ind was set earlier]
            // now determine form
            if (hadexp)
            {
                form = MathContext.NOTATION_SCIENTIFIC;
                // 1999.06.29 check for overflow
                mag = (exp + mant.length) - 1; // true exponent in scientific notation
                if ((mag < MinExp) || (mag > MaxExp))
                {
                    bad(inchars);
                }
            }
        }
    }

    /**
     * Constructs a <code>BigDecimal</code> object directly from a
     * <code>int</code>.
     * <p>
     * Constructs a <code>BigDecimal</code> which is the exact decimal
     * representation of the 32-bit signed binary integer parameter.
     * The <code>BigDecimal</code> will contain only decimal digits,
     * prefixed with a leading minus sign (hyphen) if the parameter is
     * negative.
     * A leading zero will be present only if the parameter is zero.
     *
     * @param num The <code>int</code> to be converted.
     * @stable ICU 2.0
     */
    private function createFromInt(num:int = 0):void
    {
        var mun:int;
        var i:int;

        // We fastpath commoners
        if (num <= 9)
        {
            if (num >= -9) /*singledigit*/
            {
                // very common single digit case
                if (num == 0)
                {
                    mant = ZERO.mant;
                    ind = iszero;
                }
                else if (num == 1)
                {
                    mant = ONE.mant;
                    ind = ispos;
                }
                else if (num == -1)
                {
                    mant = ONE.mant;
                    ind = isneg;
                }
                else
                {
                    {
                        mant = new Array(1);
                        if (num > 0)
                        {
                            mant[0] = num;
                            ind = ispos;
                        }
                        else
                        {
                            // num<-1
                            mant[0] = -num;
                            ind = isneg;
                        }
                    }
                }

                return;
            }
            /*singledigit*/
        }

        /* We work on negative numbers so we handle the most negative number */
        if (num > 0)
        {
            ind = ispos;
            num = -num;
        }
        else
        {
            ind = isneg;
            /* negative */ // [0 case already handled]
        }

        // [it is quicker, here, to pre-calculate the length with
        // one loop, then allocate exactly the right length of byte array,
        // then re-fill it with another loop]
        mun = num; // working copy

        for (i = 9; ; i--)
        {
            mun = int(mun / 10);
            if (mun == 0)
            {
                break;
            }
        }

        // i is the position of the leftmost digit placed
        mant = new Array(10 - i);
        i = (10 - i) - 1;
        for (; ; i--)
        {
            mant[i] = -(int(num % 10));
            num = int(num / 10);
            if (num == 0)
            {
                break;
            }
        }
    }

    /**
     * Constructs a <code>BigDecimal</code> object directly from a
     * <code>long</code>.
     * <p>
     * Constructs a <code>BigDecimal</code> which is the exact decimal
     * representation of the 64-bit signed binary integer parameter.
     * The <code>BigDecimal</code> will contain only decimal digits,
     * prefixed with a leading minus sign (hyphen) if the parameter is
     * negative.
     * A leading zero will be present only if the parameter is zero.
     *
     * @param num The <code>long</code> to be converted.
     * @stable ICU 2.0
     */
        //ActionScript 3 : This is to patch the fact that AS3 dont support Overriding
        //of Methods.  We need a way to construct the static constants without using 
        //them in the 1st place with the normal int constructor.
    private static function createStatic(num:int):BigDecimal
    {
        const r:BigDecimal = new BigDecimal(null);

        // Not really worth fastpathing commoners in this constructor [also,
        // we use this to construct the static constants].
        // This is much faster than: this(String.valueOf(num).toCharArray())
        /* We work on negative num so we handle the most negative number */

        if (num > 0)
        {
            r.ind = ispos;
            num = -num;
        }
        else if (num == 0)
        {
            r.ind = iszero;
        }
        else
        {
            r.ind = isneg;
        }

        var mun:int = num;
        var i:int = 18;
        for (; ; i--)
        {
            mun = int(mun / 10);
            if (mun == 0)
            {
                break;
            }
        }

        // i is the position of the leftmost digit placed
        r.mant = new Array(19 - i);
        i = (19 - i) - 1;
        for (; ; i--)
        {
            r.mant[i] = -((num % 10));
            num = int(num / 10);
            if (num == 0)
            {
                break;
            }
        }

        return r;
    }

    /* ---------------------------------------------------------------- */
    /* Operator methods [methods which take a context parameter] */
    /* ---------------------------------------------------------------- */

    /**
     * Returns a new <code>BigDecimal</code> whose value is the absolute value of
     * <code>this</code>. The result is rounded according to the passed context
     * <code>context</code>.
     *
     * @param context
     *            rounding mode and precision for the result of this operation.
     * @return <code>abs(this)</code>
     */
    public function abs(context:MathContext = null):BigDecimal
    {
        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        if (this.ind == isneg)
        {
            return this.negate(context);
        }
        return this.plus(context);
    }

    /**
     * Returns a new <code>BigDecimal</code> whose value is <code>this + rhs</code>.
     * The result is rounded according to the passed context <code>context</code>.
     *
     * @param rhs
     *            value to be added to <code>this</code>.
     * @param context
     *            rounding mode and precision for the result of this operation.
     * @return <code>this + rhs</code>.
     */
    public function add(rhs:BigDecimal, context:MathContext = null):BigDecimal
    {
        var newlen:int = 0;
        var tlen:int = 0;
        var mult:int = 0;
        var t:Array = null;
        var ia:int = 0;
        var ib:int = 0;
        var ea:int = 0;
        var eb:int = 0;
        var ca:int = 0;
        var cb:int = 0;

        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        /* determine requested digits and form */
        if (context.lostDigits)
        {
            checkdigits(rhs, context.digits);
        }

        var lhs:BigDecimal = this; // name for clarity and proxy

        /* Quick exit for add floating 0 */
        // plus() will optimize to return same object if possible
        if (lhs.ind == 0)
        {
            if (context.form != MathContext.NOTATION_PLAIN)
            {
                return rhs.plus(context);
            }
            if (rhs.ind == 0)
            {
                if (context.form != MathContext.NOTATION_PLAIN)
                {
                    return lhs.plus(context);
                }
            }
        }

        /* Prepare numbers (round, unless unlimited precision) */
        var reqdig:int = context.digits; // local copy (heavily used)
        if (reqdig > 0)
        {
            if (lhs.mant.length > reqdig)
            {
                lhs = clone(lhs).roundContext(context);
            }
            if (rhs.mant.length > reqdig)
            {
                rhs = clone(rhs).roundContext(context);
                // [we could reuse the new LHS for result in this case]
            }
        }

        const res:BigDecimal = new BigDecimal(); // build result here

        /* Now see how much we have to pad or truncate lhs or rhs in order
         to align the numbers. If one number is much larger than the
         other, then the smaller cannot affect the answer [but we may
         still need to pad with up to DIGITS trailing zeros]. */
        // Note sign may be 0 if digits (reqdig) is 0
        // usel and user will be the byte arrays passed to the adder; we'll
        // use them on all paths except quick exits
        var usel:Array = lhs.mant;
        var usellen:int = lhs.mant.length;
        var user:Array = rhs.mant;
        var userlen:int = rhs.mant.length;

        /*padder*/
        if (lhs.exp == rhs.exp)
        {
            /* no padding needed */
            // This is the most common, and fastest, path
            res.exp = lhs.exp;
        }
        else if (lhs.exp > rhs.exp)
        {
            // need to pad lhs and/or truncate rhs
            newlen = (usellen + lhs.exp) - rhs.exp;
            /* If, after pad, lhs would be longer than rhs by digits+1 or
             more (and digits>0) then rhs cannot affect answer, so we only
             need to pad up to a length of DIGITS+1. */
            if (newlen >= ((userlen + reqdig) + 1))
            {
                if (reqdig > 0)
                {
                    // LHS is sufficient
                    res.mant = usel;
                    res.exp = lhs.exp;
                    res.ind = lhs.ind;

                    if (usellen < reqdig)
                    {
                        // need 0 padding
                        res.mant = extend(lhs.mant, reqdig);
                        res.exp = res.exp - ((reqdig - usellen));
                    }

                    return res.finish(context, false);
                }
            }

            // RHS may affect result
            res.exp = rhs.exp; // expected final exponent
            if (newlen > (reqdig + 1))
            {
                if (reqdig > 0)
                {
                    // LHS will be max; RHS truncated
                    tlen = (newlen - reqdig) - 1; // truncation length
                    userlen = userlen - tlen;
                    res.exp = res.exp + tlen;
                    newlen = reqdig + 1;
                }
            }
            if (newlen > usellen)
            {
                usellen = newlen; // need to pad LHS
            }
        }
        else
        {
            // need to pad rhs and/or truncate lhs
            newlen = (userlen + rhs.exp) - lhs.exp;
            if (newlen >= ((usellen + reqdig) + 1))
            {
                if (reqdig > 0)
                {
                    // RHS is sufficient
                    res.mant = user;
                    res.exp = rhs.exp;
                    res.ind = rhs.ind;
                    if (userlen < reqdig)
                    {
                        // need 0 padding
                        res.mant = extend(rhs.mant, reqdig);
                        res.exp = res.exp - ((reqdig - userlen));
                    }
                    return res.finish(context, false);
                }
            }
            // LHS may affect result
            res.exp = lhs.exp; // expected final exponent
            if (newlen > (reqdig + 1))
            {
                if (reqdig > 0)
                {
                    // RHS will be max; LHS truncated
                    tlen = (newlen - reqdig) - 1; // truncation length
                    usellen = usellen - tlen;
                    res.exp = res.exp + tlen;
                    newlen = reqdig + 1;
                }
            }
            if (newlen > userlen)
            {
                userlen = newlen; // need to pad RHS
            }
        }
        /*padder*/

        /* OK, we have aligned mantissas. Now add or subtract. */
        // 1998.06.27 Sign may now be 0 [e.g., 0.000] .. treat as positive
        // 1999.05.27 Allow for 00 on lhs [is not larger than 2 on rhs]
        // 1999.07.10 Allow for 00 on rhs [is not larger than 2 on rhs]
        if (lhs.ind == iszero)
        {
            res.ind = ispos;
        }
        else
        {
            res.ind = lhs.ind; // likely sign, all paths
        }
        if (( (lhs.ind == isneg) ? 1 : 0) == ((rhs.ind == isneg) ? 1 : 0))
        {
            // same sign, 0 non-negative
            mult = 1;
        }
        else
        {
            /*signdiff*/
            // different signs, so subtraction is needed
            mult = -1; // will cause subtract
            /* Before we can subtract we must determine which is the larger,
             as our add/subtract routine only handles non-negative results
             so we may need to swap the operands. */
            /*swaptest*/
            if (rhs.ind == iszero)
            {
                // original A bigger
            }
            else if ((usellen < userlen) || (lhs.ind == iszero))
            {
                // original B bigger
                t = usel;
                usel = user;
                user = t; // swap
                tlen = usellen;
                usellen = userlen;
                userlen = tlen; // ..
                res.ind = -res.ind; // and set sign
            }
            else if (usellen > userlen)
            {
                // original A bigger
            }
            else
            {
                /* logical lengths the same */ // need compare
                /* may still need to swap: compare the strings */
                ia = 0;
                ib = 0;
                ea = usel.length - 1;
                eb = user.length - 1;
                for (; ;) /*compare*/
                {
                    if (ia <= ea)
                    {
                        ca = usel[ia];
                    }
                    else
                    {
                        if (ib > eb)
                        {
                            /* identical */
                            if (context.form != MathContext.NOTATION_PLAIN)
                            {
                                return ZERO;
                            }
                            // [if PLAIN we must do the subtract, in case of 0.000 results]
                            break /*compare*/;
                        }
                        ca = 0;
                    }

                    if (ib <= eb)
                    {
                        cb = user[ib];
                    }
                    else
                    {
                        cb = 0;
                    }
                    if (ca != cb)
                    {
                        if (ca < cb)
                        {
                            /* swap needed */
                            t = usel;
                            usel = user;
                            user = t; // swap
                            tlen = usellen;
                            usellen = userlen;
                            userlen = tlen; // ..
                            res.ind = -res.ind;
                        }
                        break /*compare*/;
                    }
                    /* mantissas the same, so far */
                    ia++;
                    ib++;
                }
                /*compare*/
                // lengths the same
            }
        }
        /*swaptest*/
        /*signdiff*/

        /* here, A is > B if subtracting */
        // add [A+B*1] or subtract [A+(B*-1)]
        res.mant = byteaddsub(usel, usellen, user, userlen, mult, false);
        // [reuse possible only after chop; accounting makes not worthwhile]

        // Finish() rounds before stripping leading 0's, then sets form, etc.
        return res.finish(context, false);
    }

    /**
     * Compares this <code>BigDecimal</code> with <code>rhs</code>. Returns one of the
     * three values <code>1</code>, <code>0</code>, or <code>-1</code>. The method behaves as
     * if <code>this.subtract(rhs)</code> is computed. If this difference is > 0 then
     * 1 is returned, if the difference is < 0 then -1 is returned, and if the
     * difference is 0 then 0 is returned. This means, that if two decimal
     * instances are compared which are equal in value but differ in scale, then
     * these two instances are considered as equal.
     *
     * @param rhs
     *            value to be compared with <code>this</code>.
     * @return <code>1</code> if <code>this > rhs</code>, <code>-1</code> if <code>this < rhs</code>,
     *         <code>0</code> if <code>this == rhs</code>.
     */
    public function compareTo(rhs:BigDecimal, context:MathContext = null):int
    {
        var thislength:int = 0;
        var i:int = 0;
        var newrhs:BigDecimal;

        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        // rhs=null will raise NullPointerException, as per Comparable interface
        if (context.lostDigits)
        {
            checkdigits(rhs, context.digits);
        }

        // [add will recheck in slowpath cases .. but would report -rhs]
        if (this.ind == rhs.ind && this.exp == rhs.exp)
        {
            /* sign & exponent the same [very common] */
            thislength = this.mant.length;
            if (thislength < rhs.mant.length)
            {
                return -this.ind;
            }
            if (thislength > rhs.mant.length)
            {
                return this.ind;
            }
            /* lengths are the same; we can do a straight mantissa compare
             unless maybe rounding [rounding is very unusual] */
            if (thislength <= context.digits || context.digits == 0)
            {
                var $6:int = thislength;
                i = 0;
                for (; $6 > 0; $6--, i++)
                {
                    if (this.mant[i] < rhs.mant[i])
                    {
                        return -this.ind;
                    }
                    if (this.mant[i] > rhs.mant[i])
                    {
                        return this.ind;
                    }
                }
                return 0; // identical
            }
            /* drop through for full comparison */
        }
        else
        {
            /* More fastpaths possible */
            if (this.ind < rhs.ind)
            {
                return -1;
            }
            if (this.ind > rhs.ind)
            {
                return 1;
            }
        }
        /* carry out a subtract to make the comparison */
        newrhs = clone(rhs); // safe copy
        newrhs.ind = -newrhs.ind; // prepare to subtract
        return this.add(newrhs, context).ind; // add, and return sign of result
    }

    /**
     * Returns a plain <code>BigDecimal</code> whose value is
     * <code>this/rhs</code>, using fixed point arithmetic.
     * <p>
     * The same as {@link #divide(BigDecimal, int)},
     * where the <code>BigDecimal</code> is <code>rhs</code>,
     * and the rounding mode is {@link MathContext#ROUND_HALF_UP}.
     *
     * The length of the decimal part (the scale) of the result will be
     * the same as the scale of the current object, if the latter were
     * formatted without exponential notation.
     *
     * @param rhs The <code>BigDecimal</code> for the right hand side of
     * the division.
     * @return A plain <code>BigDecimal</code> whose value is
     * <code>this/rhs</code>, using fixed point arithmetic.
     * @throws ArithmeticError if <code>rhs</code> is zero.
     * @stable ICU 2.0
     */

    /*      ActionScript 3 : Flex override is with default parameters

     public function divide(rhs:BigDecimal):BigDecimal {
     return this.dodivide('D',rhs,MathContext.PLAIN,-1);
     }
     */
    /**
     * Returns a plain <code>BigDecimal</code> whose value is
     * <code>this/rhs</code>, using fixed point arithmetic and a
     * rounding mode.
     * <p>
     * The same as {@link #divide(BigDecimal, int, int)},
     * where the <code>BigDecimal</code> is <code>rhs</code>,
     * and the second parameter is <code>this.scale()</code>, and
     * the third is <code>round</code>.
     * <p>
     * The length of the decimal part (the scale) of the result will
     * therefore be the same as the scale of the current object, if the
     * latter were formatted without exponential notation.
     * <p>
     * @param rhs The <code>BigDecimal</code> for the right hand side of
     * the division.
     * @param round The <code>int</code> rounding mode to be used for
     * the division (see the {@link MathContext} class).
     * @return A plain <code>BigDecimal</code> whose value is
     * <code>this/rhs</code>, using fixed point arithmetic
     * and the specified rounding mode.
     * @throws Error if <code>round</code> is not a
     * valid rounding mode.
     * @throws ArithmeticError if <code>rhs</code> is zero.
     * @throws ArithmeticError if <code>round</code> is {@link
     * MathContext#ROUND_UNNECESSARY} and
     * <code>this.scale()</code> is insufficient to
     * represent the result exactly.
     * @stable ICU 2.0
     */
    public function divideRound(rhs:BigDecimal, round:int):BigDecimal
    {
        var context:MathContext;
        context = new MathContext(0, MathContext.NOTATION_PLAIN, false, round); // [checks round, too]
        return this.dodivide('D', rhs, context, -1); // take scale from LHS
    }

    /**
     * Returns a plain <code>BigDecimal</code> whose value is
     * <code>this/rhs</code>, using fixed point arithmetic and a
     * given scale and rounding mode.
     * <p>
     * The same as {@link #divide(BigDecimal, MathContext)},
     * where the <code>BigDecimal</code> is <code>rhs</code>,
     * <code>new MathContext(0, MathContext.PLAIN, false, round)</code>,
     * except that the length of the decimal part (the scale) to be used
     * for the result is explicit rather than being taken from
     * <code>this</code>.
     * <p>
     * The length of the decimal part (the scale) of the result will be
     * the same as the scale of the current object, if the latter were
     * formatted without exponential notation.
     * <p>
     * @param rhs The <code>BigDecimal</code> for the right hand side of
     * the division.
     * @param scale The <code>int</code> scale to be used for the result.
     * @param round The <code>int</code> rounding mode to be used for
     * the division (see the {@link MathContext} class).
     * @return A plain <code>BigDecimal</code> whose value is
     * <code>this/rhs</code>, using fixed point arithmetic
     * and the specified rounding mode.
     * @throws Error if <code>round</code> is not a
     * valid rounding mode.
     * @throws ArithmeticError if <code>rhs</code> is zero.
     * @throws ArithmeticError if <code>scale</code> is negative.
     * @throws ArithmeticError if <code>round</code> is {@link
     * MathContext#ROUND_UNNECESSARY} and <code>scale</code>
     * is insufficient to represent the result exactly.
     * @stable ICU 2.0
     */
    public function divideScaleRound(rhs:BigDecimal, scale:int, round:int):BigDecimal
    {
        var context:MathContext;
        if (scale < 0)
        {
            throw new ArithmeticError("Negative scale:" + " " + scale);
        }
        context = new MathContext(0, MathContext.NOTATION_PLAIN, false, round); // [checks round]
        return this.dodivide('D', rhs, context, scale);
    }

    /**
     * Returns a new <code>BigDecimal</code> whose value is <code>this / rhs</code>.
     * The result is rounded according to the passed context <code>context</code>. If the
     * passed math context specifies precision <code>0</code>, then this call is
     * equivalent to <code>this.divide(rhs)</code>.
     *
     * @param rhs
     *            value by which <code>this</code> is divided.
     * @param context
     *            rounding mode and precision for the result of this operation.
     * @return <code>this / rhs</code>.
     */
    public function divide(rhs:BigDecimal, context:MathContext = null):BigDecimal
    {
        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        return this.dodivide('D', rhs, context, -1);
    }

    /**
     * Returns a plain <code>BigDecimal</code> whose value is the integer
     * part of <code>this/rhs</code>.
     * <p>
     * The same as {@link #divideInteger(BigDecimal, MathContext)},
     * where the <code>BigDecimal</code> is <code>rhs</code>,
     * and the context is <code>new MathContext(0, MathContext.PLAIN)</code>.
     *
     * @param rhs The <code>BigDecimal</code> for the right hand side of
     * the integer division.
     * @return A <code>BigDecimal</code> whose value is the integer
     * part of <code>this/rhs</code>.
     * @throws ArithmeticError if <code>rhs</code> is zero.
     * @stable ICU 2.0
     */

    /*      ActionScript 3 : Flex override is with default parameters

     public function divideInteger(rhs:BigDecimal):BigDecimal {
     // scale 0 to drop .000 when plain
     return this.dodivide('I',rhs,MathContext.PLAIN,0);
     }
     */
    /**
     * Returns a <code>BigDecimal</code> whose value is the integer
     * part of <code>this/rhs</code>.
     * <p>
     * Implements the integer division operator
     * (as defined in the decimal documentation, see {@link BigDecimal
     * class header}),
     * and returns the result as a <code>BigDecimal</code> object.
     *
     * @param rhs The <code>BigDecimal</code> for the right hand side of
     * the integer division.
     * @param context The <code>MathContext</code> arithmetic settings.
     * @return A <code>BigDecimal</code> whose value is the integer
     * part of <code>this/rhs</code>.
     * @throws ArithmeticError if <code>rhs</code> is zero.
     * @throws ArithmeticError if the result will not fit in the
     * number of digits specified for the context.
     * @stable ICU 2.0
     */
    public function divideInteger(rhs:BigDecimal, context:MathContext = null):BigDecimal
    {
        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        // scale 0 to drop .000 when plain
        return this.dodivide('I', rhs, context, 0);
    }

    /**
     * Returns the maximum of this <code>BigDecimal</code> and <code>rhs</code>.
     *
     * @param rhs
     *            value to be used to compute the maximum with this.
     * @return <code>max(this, rhs</code>.
     */
    public function max(rhs:BigDecimal, context:MathContext = null):BigDecimal
    {
        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        if (this.compareTo(rhs, context) >= 0)
        {
            return this.plus(context);
        }
        else
        {
            return rhs.plus(context);
        }
    }

    /**
     * Returns the minimum of this <code>BigDecimal</code> and <code>rhs</code>.
     *
     * @param rhs
     *            value to be used to compute the minimum with this.
     * @return <code>min(this, rhs</code>.
     */
    public function min(rhs:BigDecimal, context:MathContext = null):BigDecimal
    {
        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        if (this.compareTo(rhs, context) <= 0)
        {
            return this.plus(context);
        }
        else
        {
            return rhs.plus(context);
        }
    }

    /**
     * Returns a new <code>BigDecimal</code> whose value is {@code this *
     * rhs}. The result is rounded according to the passed context
     * <code>context</code>.
     *
     * @param rhs
     *            value to be multiplied with <code>this</code>.
     * @param context
     *            rounding mode and precision for the result of this operation.
     * @return <code>this * rhs</code>.
     */
    public function multiply(rhs:BigDecimal, context:MathContext = null):BigDecimal
    {
        var lhs:BigDecimal;
        var reqdig:int;
        var multer:Array = null;
        var multand:Array = null;
        var multandlen:int;
        var acclen:int = 0;
        var res:BigDecimal;
        var acc:Array;
        var n:int;
        var mult:int = 0;

        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        if (context.lostDigits)
        {
            checkdigits(rhs, context.digits);
        }
        lhs = this; // name for clarity and proxy

        /* Prepare numbers (truncate, unless unlimited precision) */
        reqdig = context.digits; // local copy

        if (reqdig > 0)
        {
            if (lhs.mant.length > reqdig)
            {
                lhs = clone(lhs).roundContext(context);
            }
            if (rhs.mant.length > reqdig)
            {
                rhs = clone(rhs).roundContext(context);
            }
            // [we could reuse the new LHS for result in this case]
        }

        // For best speed, as in DMSRCN, we use the shorter number as the
        // multiplier and the longer as the multiplicand.
        // 1999.12.22: We used to special case when the result would fit in
        // a long, but with Java 1.3 this gave no advantage.
        if (lhs.mant.length < rhs.mant.length)
        {
            multer = lhs.mant;
            multand = rhs.mant;
        }
        else
        {
            multer = rhs.mant;
            multand = lhs.mant;
        }

        /* Calculate how long result byte array will be */
        multandlen = (multer.length + multand.length) - 1; // effective length
        // optimize for 75% of the cases where a carry is expected...
        if ((multer[0] * multand[0]) > 9)
        {
            acclen = multandlen + 1;
        }
        else
        {
            acclen = multandlen;
        }

        /* Now the main long multiplication loop */
        res = new BigDecimal(); // where we'll build result
        acc = createArrayWithZeros(acclen); // accumulator, all zeros
        // 1998.07.01: calculate from left to right so that accumulator goes
        // to likely final length on first addition; this avoids a one-digit
        // extension (and object allocation) each time around the loop.
        // Initial number therefore has virtual zeros added to right.
        var $7:int = multer.length;
        for (n = 0; $7 > 0; $7--, n++)
        {
            mult = multer[n];
            if (mult != 0)
            {
                // [optimization]
                // accumulate [accumulator is reusable array]
                acc = byteaddsub(acc, acc.length, multand, multandlen, mult, true);
            }
            // divide multiplicand by 10 for next digit to right
            multandlen--; // 'virtual length'
        }

        res.ind = (lhs.ind * rhs.ind); // final sign
        res.exp = (lhs.exp + rhs.exp); // final exponent
        res.mant = acc;
        return res.finish(context, false);
    }

    /**
     * Returns a new <code>BigDecimal</code> whose value is the <code>-this</code>. The
     * result is rounded according to the passed context <code>context</code>.
     *
     * @param context
     *            rounding mode and precision for the result of this operation.
     * @return <code>-this</code>
     */
    public function negate(context:MathContext = null):BigDecimal
    {
        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        var res:BigDecimal;
        // Originally called minus(), changed to matched Java precedents
        // This simply clones, flips the sign, and possibly rounds
        if (context.lostDigits)
        {
            checkdigits(null as BigDecimal, context.digits);
        }
        res = clone(this); // safe copy
        res.ind = -res.ind;

        return res.finish(context, false);
    }

    /**
     * Returns a new <code>BigDecimal</code> whose value is <code>+this</code>. The result
     * is rounded according to the passed context <code>context</code>.
     *
     * @param context
     *            rounding mode and precision for the result of this operation.
     * @return <code>this</code>, rounded
     */
    public function plus(context:MathContext = null):BigDecimal
    {
        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        // This clones and forces the result to the new settings
        // May return same object
        if (context.lostDigits)
        {
            checkdigits(null as BigDecimal, context.digits);
        }
        // Optimization: returns same object for some common cases
        if (context.form == MathContext.NOTATION_PLAIN)
        {
            if (this.form == MathContext.NOTATION_PLAIN)
            {
                if (this.mant.length <= context.digits)
                {
                    return this;
                }
                if (context.digits == 0)
                {
                    return this;
                }
            }
        }
        return clone(this).finish(context, false);
    }

    // The name for this method is inherited from the precedent set by the
    // BigInteger and Math classes.

    /**
     * Returns a new <code>BigDecimal</code> whose value is <code>this ^ n</code>. The
     * scale of the result is <code>n</code> times the scales of <code>this</code>.
     * <p>
     * <code>x.pow(0)</code> returns <code>1</code>, even if <code>x == 0</code>.
     * <p>
     * Implementation Note: The implementation is based on the ANSI standard
     * X3.274-1996 algorithm.
     *
     * @param n
     *            exponent to which <code>this</code> is raised.
     * @return <code>this ^ n</code>.
     * @throws ArithmeticError
     *             if <code>n < 0</code> or <code>n > 999999999</code>.
     */
    public function pow(n:int, context:MathContext = null):BigDecimal
    {
        if (n == 0)
        {
            return ONE;
        }
        if (n < 0 || n > 999999999)
        {
            throw new ArithmeticError("Invalid Operation");
        }

        var lhs:BigDecimal;
        var reqdig:int;
        var workdigits:int = 0;
        var L:int = 0;
        var workset:MathContext;
        var res:BigDecimal;
        var seenbit:Boolean;
        var i:int;

        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        var rhs:BigDecimal = new BigDecimal(String(n)); // todo complete the transition from rhs:BigDecimal to n:int parameter
        if (context.lostDigits)
        {
            checkdigits(rhs, context.digits);
        }

        lhs = this; // clarified name

        reqdig = context.digits; // local copy (heavily used)

        if (reqdig == 0)
        {
            if (rhs.ind == isneg)
            {
                throw new Error("Negative power:" + " " + rhs.toString());
            }
            workdigits = 0;
        }
        else
        {
            /* non-0 digits */
            if ((rhs.mant.length + rhs.exp) > reqdig)
            {
                throw Error("Too many digits:" + " " + rhs.toString());
            }

            /* Round the lhs to DIGITS if need be */
            if (lhs.mant.length > reqdig)
            {
                lhs = clone(lhs).roundContext(context);
            }

            /* L for precision calculation [see ANSI X3.274-1996] */
            L = rhs.mant.length + rhs.exp; // length without decimal zeros/exp
            workdigits = (reqdig + L) + 1; // calculate the working DIGITS
        }

        /* Create a copy of context for working settings */
        // Note: no need to check for lostDigits again.
        // 1999.07.17 Note: this construction must follow RHS check
        workset = new MathContext(workdigits, context.form, false, context.roundingMode);

        res = ONE; // accumulator

        if (n == 0)
        {
            return res; // x**0 == 1
        }
        if (n < 0)
        {
            n = -n; // [rhs.ind records the sign]
        }
        seenbit = false; // set once we've seen a 1-bit

        for (i = 1; ; i++)
        {
            // for each bit [top bit ignored]
            n = n + n; // shift left 1 bit
            if (n < 0)
            {
                // top bit is set
                seenbit = true; // OK, we're off
                res = res.multiply(lhs, workset); // acc=acc*x
            }
            if (i == 31)
            {
                break; // that was the last bit
            }
            if ((!seenbit))
            {
                continue; // we don't have to square 1
            }
            res = res.multiply(res, workset); // acc=acc*acc [square]
        }
        // 32 bits

        if (rhs.ind < 0)
        {
            // was a **-n [hence digits>0]
            res = ONE.divide(res, workset); // .. so acc=1/acc
        }
        return res.finish(context, true); // round and strip [original digits]
    }

    /**
     * Returns a new <code>BigDecimal</code> whose value is <code>this % rhs</code>.
     * <p>
     * The remainder is defined as {@code this -
     * this.divideToIntegralValue(rhs) * rhs}.
     *
     * @param rhs
     *            value by which <code>this</code> is divided.
     * @return <code>this % rhs</code>.
     */
    public function remainder(rhs:BigDecimal, context:MathContext = null):BigDecimal
    {
        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        return this.dodivide('R', rhs, context, -1);
    }

    /**
     * Returns a new <code>BigDecimal</code> whose value is <code>this - rhs</code>.
     * The result is rounded according to the passed context <code>context</code>.
     *
     * @param rhs
     *            value to be subtracted from <code>this</code>.
     * @param context
     *            rounding mode and precision for the result of this operation.
     * @return <code>this - rhs</code>.
     */
    public function subtract(rhs:BigDecimal, context:MathContext = null):BigDecimal
    {
        var newrhs:BigDecimal;

        if (context == null)
        {
            context = MathContext.PLAIN;
        }

        if (context.lostDigits)
        {
            checkdigits(rhs, context.digits);
        }
        // [add will recheck .. but would report -rhs]
        /* carry out the subtraction */
        // we could fastpath -0, but it is too rare.
        newrhs = clone(rhs); // safe copy
        newrhs.ind = -newrhs.ind; // prepare to subtract

        return this.add(newrhs, context); // arithmetic
    }

    /* ---------------------------------------------------------------- */
    /* Other methods */
    /* ---------------------------------------------------------------- */

    /**
     * Converts this <code>BigDecimal</code> to a <code>double</code>.
     * If the <code>BigDecimal</code> is out of the possible range for a
     * <code>double</code> (64-bit signed floating point) result then an
     * <code>ArithmeticException</code> is thrown.
     * <p>
     * The double produced is identical to result of expressing the
     * <code>BigDecimal</code> as a <code>String</code> and then
     * converting it using the <code>Double(String)</code> constructor;
     * this can result in values of <code>Double.NEGATIVE_INFINITY</code>
     * or <code>Double.POSITIVE_INFINITY</code>.
     *
     * @return A <code>double</code> corresponding to <code>this</code>.
     * @stable ICU 2.0
     */

    public function numberValue():Number
    {
        // We go via a String [as does BigDecimal in JDK 1.2]
        // Next line could possibly raise NumberFormatException
        return Number(this.toString());
    }

    /**
     * Returns <code>true</code> if <code>obj</code> is a <code>BigDecimal</code> instance and if
     * this instance is equal to this big decimal. Two big decimals are equal if
     * their unscaled value and their scale is equal. For example, 1.0
     * (10*10^(-1)) is not equal to 1.00 (100*10^(-2)). Similarly, zero
     * instances are not equal if their scale differs.
     *
     * @param obj
     *            object to be compared with <code>this</code>.
     * @return true if <code>obj</code> is a <code>BigDecimal</code> and <code>this == obj</code>.
     */
    public function equals(obj:Object):Boolean
    {
        var rhs:BigDecimal;
        var i:int = 0;
        var lca:Array = null;
        var rca:Array = null;

        // We are equal iff toString of both are exactly the same
        if (obj == null)
        {
            return false; // not equal
        }

        if (!(obj is BigDecimal))
        {
            return false; // not a decimal
        }

        rhs = obj as BigDecimal; // cast; we know it will work
        if (this.ind != rhs.ind)
        {
            return false; // different signs never match
        }

        if (this.mant.length == rhs.mant.length && this.exp == rhs.exp && this.form == rhs.form)
        {
            // mantissas say all
            // here with equal-length byte arrays to compare
            var $8:int = this.mant.length;
            i = 0;
            for (; $8 > 0; $8--, i++)
            {
                if (this.mant[i] != rhs.mant[i])
                {
                    return false;
                }
            }
        }
        else
        {
            // need proper layout
            lca = this.layout(); // layout to character array
            rca = rhs.layout();
            if (lca.length != rca.length)
            {
                return false; // mismatch
            }
            // here with equal-length character arrays to compare
            var $9:int = lca.length;
            i = 0;
            for (; $9 > 0; $9--, i++)
            {
                if (lca[i] != rca[i])
                {
                    return false;
                }
            }
        }
        return true; // arrays have identical content
    }

    /**
     * Converts this <code>BigDecimal</code> to an <code>int</code>.
     * If the <code>BigDecimal</code> has a non-zero decimal part it is
     * discarded. If the <code>BigDecimal</code> is out of the possible
     * range for an <code>int</code> (32-bit signed integer) result then
     * only the low-order 32 bits are used. (That is, the number may be
     * <i>decapitated</i>.) To avoid unexpected errors when these
     * conditions occur, use the {@link #intValueExact} method.
     *
     * @return An <code>int</code> converted from <code>this</code>,
     * truncated and decapitated if necessary.
     * @stable ICU 2.0
     */
    /* ActionScript : WONT PORT
     public int intValue(){
     return toBigInteger().intValue();
     }
     */

    /**
     * Returns this <code>BigDecimal</code> as a int value if it has no fractional
     * part and if its value fits to the int range ([-2^{31}..2^{31}-1]). If
     * these conditions are not met, an <code>ArithmeticException</code> is thrown.
     *
     * @return this <code>BigDecimal</code> as a int value.
     * @throws Error
     *             if rounding is necessary or the number doesn't fit in a int.
     */
    public function intValueExact():int
    {
        var lodigit:int;
        var useexp:int = 0;
        var result:int;
        var i:int;
        var topdig:int = 0;
        // This does not use longValueExact() as the latter can be much
        // slower.
        // intcheck (from pow) relies on this to check decimal part
        if (ind == iszero)
        {
            return 0; // easy, and quite common
        }
        /* test and drop any trailing decimal part */

        lodigit = mant.length - 1;
        if (exp < 0)
        {
            lodigit = lodigit + exp; // reduces by -(-exp)
            /* all decimal places must be 0 */

            if (!allzero(mant, lodigit + 1))
            {
                throw new Error("Decimal part non-zero:" + " " + this.toString());
            }
            if (lodigit < 0)
            {
                return 0; // -1<this<1
            }
            useexp = 0;
        }
        else
        {
            /* >=0 */

            if ((exp + lodigit) > 9)
            {
                // early exit
                throw new Error("Conversion overflow:" + " " + this.toString());
            }
            useexp = exp;
        }
        /* convert the mantissa to binary, inline for speed */

        result = 0;
        var $16:int = lodigit + useexp;
        i = 0;
        for (; i <= $16; i++)
        {
            result = result * 10;
            if (i <= lodigit)
            {
                result = result + mant[i];
            }
        }

        /* Now, if the risky length, check for overflow */

        if ((lodigit + useexp) == 9)
        {
            // note we cannot just test for -ve result, as overflow can move a
            // zero into the top bit [consider 5555555555]
            topdig = int(result / 1000000000); // get top digit, preserving sign
            if (topdig != mant[0])
            {
                // digit must match and be positive
                // except in the special case ...
                if (result == int.MIN_VALUE)
                {
                    // looks like the special
                    if (ind == isneg)
                    {
                        // really was negative
                        if (mant[0] == 2)
                        {
                            return result; // really had top digit 2
                        }
                    }
                }

                throw new Error("Conversion overflow:" + " " + this.toString());
            }
        }

        /* Looks good */

        if (ind == ispos)
        {
            return result;
        }

        return -result;
    }

    /**
     * Returns a new <code>BigDecimal</code> instance where the decimal point has
     * been moved <code>n</code> places to the left. If <code>n < 0</code> then the
     * decimal point is moved <code>-n</code> places to the right.
     * <p>
     * The result is obtained by changing its scale. If the scale of the result
     * becomes negative, then its precision is increased such that the scale is
     * zero.
     * <p>
     * Note, that <code>movePointLeft(0)</code> returns a result which is
     * mathematically equivalent, but which has <code>scale >= 0</code>.
     *
     * @param n
     *            number of placed the decimal point has to be moved.
     * @return <code>this * 10^(-n</code>).
     */
    public function movePointLeft(n:int):BigDecimal
    {
        return movePoint(-n);
    }

    /**
     * Returns a new <code>BigDecimal</code> instance where the decimal point has
     * been moved <code>n</code> places to the right. If <code>n < 0</code> then the
     * decimal point is moved <code>-n</code> places to the left.
     * <p>
     * The result is obtained by changing its scale. If the scale of the result
     * becomes negative, then its precision is increased such that the scale is
     * zero.
     * <p>
     * Note, that <code>movePointRight(0)</code> returns a result which is
     * mathematically equivalent, but which has scale >= 0.
     *
     * @param n
     *            number of placed the decimal point has to be moved.
     * @return <code>this * 10^n</code>.
     */
    public function movePointRight(n:int):BigDecimal
    {
        return movePoint(n);
    }

    private function movePoint(n:int):BigDecimal
    {
        var res:BigDecimal = clone(this);
        res.exp = res.exp + n;
        res = res.finish(MathContext.PLAIN, false);
        return res.exp < 0 ? res : res.setScale(0, MathContext.ROUND_UNNECESSARY);
    }

    /**
     * Returns the scale of this <code>BigDecimal</code>. The scale is the number of
     * digits behind the decimal point. The value of this <code>BigDecimal</code> is
     * the unsignedValue * 10^(-scale). If the scale is negative, then this
     * <code>BigDecimal</code> represents a big integer.
     *
     * @return the scale of this <code>BigDecimal</code>.
     */
    public function scale():int
    {
        return -exp;
    }

    /**
     * Returns a new <code>BigDecimal</code> instance with the specified scale.
     * <p>
     * If the new scale is greater than the old scale, then additional zeros are
     * added to the unscaled value. In this case no rounding is necessary.
     * <p>
     * If the new scale is smaller than the old scale, then trailing digits are
     * removed. If these trailing digits are not zero, then the remaining
     * unscaled value has to be rounded. For this rounding operation the
     * specified rounding mode is used.
     *
     * @param scale
     *            scale of the result returned.
     * @param round
     *            rounding mode to be used to round the result.
     * @return a new <code>BigDecimal</code> instance with the specified scale.
     */
    public function setScale(scale:int, round:int = -1):BigDecimal
    {
        var ourscale:int;
        var res:BigDecimal;
        var padding:int = 0;
        var newlen:int = 0;

        //ActionScript 3
        //Correct the default parameter patch because of 
        //Compiler bug for the compile time constants
        if (round == -1)
        {
            round = MathContext.ROUND_UNNECESSARY;
        }

        // at present this naughtily only checks the round value if it is
        // needed (used), for speed
        ourscale = this.scale();

        if (ourscale == scale)
        {
            // already correct scale
            if (this.form == MathContext.NOTATION_PLAIN)
            {
                // .. and form
                return this;
            }
        }
        res = clone(this); // need copy
        if (ourscale <= scale)
        {
            // simply zero-padding/changing form
            // if ourscale is 0 we may have lots of 0s to add
            if (ourscale == 0)
            {
                padding = res.exp + scale;
            }
            else
            {
                padding = scale - ourscale;
            }
            res.mant = extend(res.mant, res.mant.length + padding);
            res.exp = -scale; // as requested
        }
        else
        {
            /* ourscale>scale: shortening, probably */
            if (scale < 0)
            {
                throw new Error("Negative scale:" + " " + scale);
            }
            // [round() will raise exception if invalid round]
            newlen = res.mant.length - ((ourscale - scale)); // [<=0 is OK]
            res = res.round(newlen, round); // round to required length
            // This could have shifted left if round (say) 0.9->1[.0]
            // Repair if so by adding a zero and reducing exponent
            if (res.exp != (-scale))
            {
                res.mant = extend(res.mant, res.mant.length + 1);
                res.exp = res.exp - 1;
            }
        }
        res.form = MathContext.NOTATION_PLAIN; // by definition
        return res;
    }

    /**
     * Returns the sign of this <code>BigDecimal</code>.
     *
     * @return <code>-1</code> if <code>this < 0</code>,
     *         <code>0</code> if <code>this == 0</code>,
     *         <code>1</code> if <code>this > 0</code>.
     */
    public function signum():int
    {
        return this.ind; // [note this assumes values for ind.]
    }

    /**
     * Converts this <code>BigDecimal</code> to a
     * <code>java.math.BigInteger</code>.
     * <p>
     * Any decimal part is truncated (discarded).
     * If an exception is desired should the decimal part be non-zero,
     * use {@link #toBigIntegerExact()}.
     *
     * @return The <code>java.math.BigInteger</code> equal in value
     * to the integer part of this <code>BigDecimal</code>.
     * @stable ICU 2.0
     */
    /* ActionScript : WONT PORT

     public java.math.BigInteger JavaDoc toBigInteger(){
     com.ibm.icu.math.BigDecimal res=null;
     int newlen=0;
     byte newmant[]=null;
     {/*select*/
    /*
     if ((exp>=0)&(form==com.ibm.icu.math.MathContext.PLAIN))
     res=this; // can layout simply
     else if (exp>=0)
     {
     res=clone(this); // safe copy
     res.form=(byte)com.ibm.icu.math.MathContext.PLAIN; // .. and request PLAIN
     }
     else{
     { // exp<0; scale to be truncated
     // we could use divideInteger, but we may as well be quicker
     if (((int)-this.exp)>=this.mant.length)
     res=ZERO; // all blows away
     else
     {
     res=clone(this); // safe copy
     newlen=res.mant.length+res.exp;
     newmant=new byte[newlen]; // [shorter]
     java.lang.System.arraycopy((java.lang.Object JavaDoc)res.mant,0,(java.lang.Object JavaDoc)newmant,0,newlen);
     res.mant=newmant;
     res.form=(byte)com.ibm.icu.math.MathContext.PLAIN;
     res.exp=0;
     }
     }
     }
     }
     return new BigInteger JavaDoc(new java.lang.String JavaDoc(res.layout()));
     }

     /**
     * Converts this <code>BigDecimal</code> to a
     * <code>java.math.BigInteger</code>.
     * <p>
     * An exception is thrown if the decimal part (if any) is non-zero.
     *
     * @return The <code>java.math.BigInteger</code> equal in value
     * to the integer part of this <code>BigDecimal</code>.
     * @throws ArithmeticException if <code>this</code> has a non-zero
     * decimal part.
     * @stable ICU 2.0
     */
    /* ActionScript : WONT PORT

     public java.math.BigInteger JavaDoc toBigIntegerExact(){
     /* test any trailing decimal part */
    /*
     if (exp<0)
     { // possible decimal part
     /* all decimal places must be 0; note exp<0 */
    /*
     if ((!(allzero(mant,mant.length+exp))))
     throw new java.lang.ArithmeticException JavaDoc("Decimal part non-zero:"+" "+this.toString());
     }
     return toBigInteger();
     }

     /**
     * Returns a canonical string representation of this <code>BigDecimal</code>. If
     * necessary, scientific notation is used. This representation always prints
     * all significant digits of this value.
     * <p>
     * If the scale is negative or if <code>scale - precision >= 6</code> then
     * scientific notation is used.
     *
     * @return a string representation of <code>this</code> in scientific notation if
     *         necessary.
     */
    public function toString():String
    {
        const result:Vector.<String> = Vector.<String>(mant);
        if (ind < 0)
        {
            result.splice(0, 0, "-");
        }
        if (scale() == 0)
        {
            return result.join("");
        }

        const begin:int = (ind < 0) ? 2 : 1;
        var end:int = result.length;
        const exponent:int = -scale() + end - begin;

        if (scale() > 0 && exponent >= -6)
        {
            if (exponent >= 0)
            {
                result.splice(end - scale(), 0, '.');
            }
            else
            {
                result.splice(begin - 1, 0, "0", "."); //$NON-NLS-1$
                for (var i:int = 0; i < -exponent - 1; i++)
                {
                    result.splice(begin + 1, 0, "0");
                }
            }
        }
        else
        {
            if (end - begin >= 1)
            {
                result.splice(begin, 0, '.');
                end++;
            }
            result.splice(end, 0, 'E');
            if (exponent > 0)
            {
                result.splice(++end, 0, '+');
            }
            result.splice(++end, 0, String(exponent));
        }
        return result.join("");
    }

    /**
     * Returns a string representation of this <code>BigDecimal</code>. This
     * representation always prints all significant digits of this value.
     * <p>
     * If the scale is negative or if <code>scale - precision >= 6</code> then
     * engineering notation is used. Engineering notation is similar to the
     * scientific notation except that the exponent is made to be a multiple of
     * 3 such that the integer part is >= 1 and < 1000.
     *
     * @return a string representation of <code>this</code> in engineering notation
     *         if necessary.
     */
    public function toEngineeringString():String
    {
        const result:Vector.<String> = Vector.<String>(mant);
        if (ind < 0)
        {
            result.splice(0, 0, "-");
        }
        if (exp == 0)
        {
            return result.join("");
        }

        var begin:int = (ind < 0) ? 2 : 1;
        var end:int = result.length;
        var exponent:int = exp + end - begin;

        if (-exp > 0 && exponent >= -6)
        {
            if (exponent >= 0)
            {
                result.splice(end - scale(), 0, '.');
            }
            else
            {
                result.splice(begin - 1, 0, "0", "."); //$NON-NLS-1$
                for (var i:int = 0; i < -exponent - 1; i++)
                {
                    result.splice(begin + 1, 0, "0");
                }
            }
        }
        else
        {
            var delta:int = end - begin;
            var rem:int = int(exponent % 3);

            if (rem != 0)
            {
                // adjust exponent so it is a multiple of three
                if (ind == 0)
                {
                    // zero value
                    rem = (rem < 0) ? -rem : 3 - rem;
                    exponent += rem;
                }
                else
                {
                    // nonzero value
                    rem = (rem < 0) ? rem + 3 : rem;
                    exponent -= rem;
                    begin += rem;
                }
                if (delta < 3)
                {
                    for (i = rem - delta; i > 0; i--)
                    {
                        result.splice(end++, 0, '0');
                    }
                }
            }
            if (end - begin >= 1)
            {
                result.splice(begin, 0, '.');
                end++;
            }
            if (exponent != 0)
            {
                result.splice(end, 0, 'E');
                if (exponent > 0)
                {
                    result.splice(++end, 0, '+');
                }
                result.splice(++end, 0, String(exponent));
            }
        }
        return result.join("");
    }

    /**
     * Returns a string representation of this <code>BigDecimal</code>. No scientific
     * notation is used. This methods adds zeros where necessary.
     * <p>
     * If this string representation is used to create a new instance, this
     * instance is generally not identical to <code>this</code> as the precision
     * changes.
     * <p>
     * <code>x.equals(new BigDecimal(x.toPlainString())</code> usually returns
     * <code>false</code>.
     * <p>
     * <code>x.compareTo(new BigDecimal(x.toPlainString())</code> returns <code>0</code>.
     *
     * @return a string representation of <code>this</code> without exponent part.
     */
    public function toPlainString():String
    {
        var len:int = 0;
        const v:Vector.<String> = new Vector.<String>();
        if (ind < 0)
        {
            v[len++] = "-";
        }
        var dot:int = -1;
        if (exp < 0)
        {
            if (-exp >= mant.length)
            {
                v[len++] = "0.";
                var pad:int = -exp - mant.length;
                v.length += pad;
                while (pad-- > 0)
                {
                    v[len++] = "0";
                }
            }
            else
            {
                dot = mant.length + exp;
            }
        }
        for (var i:int = 0; i < mant.length; i++)
        {
            if (i == dot)
            {
                v[len++] = ".";
            }
            v[len++] = mant[i];
        }
        if (exp > 0)
        {
            pad = exp;
            v.length += pad;
            while (pad-- > 0)
            {
                v[len++] = "0";
            }
        }
        return v.join("");
    }

    /**
     * Returns the number as a <code>BigInteger</code> after removing the
     * scale.
     * That is, the number is expressed as a plain number, any decimal
     * point is then removed (retaining the digits of any decimal part),
     * and the result is then converted to a <code>BigInteger</code>.
     *
     * @return The <code>java.math.BigInteger</code> equal in value to
     * this <code>BigDecimal</code> multiplied by ten to the
     * power of <code>this.scale()</code>.
     * @stable ICU 2.0
     */
    /* ActionScript : WONT PORT

     public java.math.BigInteger JavaDoc unscaledValue(){
     com.ibm.icu.math.BigDecimal res=null;
     if (exp>=0)
     res=this;
     else
     {
     res=clone(this); // safe copy
     res.exp=0; // drop scale
     }
     return res.toBigInteger();
     }

     /**
     * Translates a <code>double</code> to a <code>BigDecimal</code>.
     * <p>
     * Returns a <code>BigDecimal</code> which is the decimal
     * representation of the 64-bit signed binary floating point
     * parameter. If the parameter is infinite, or is not a number (NaN),
     * a <code>NumberFormatException</code> is thrown.
     * <p>
     * The number is constructed as though <code>num</code> had been
     * converted to a <code>String</code> using the
     * <code>Double.toString()</code> method and the
     * {@link #BigDecimal(java.lang.String)} constructor had then been used.
     * This is typically not an exact conversion.
     *
     * @param dub The <code>double</code> to be translated.
     * @return The <code>BigDecimal</code> equal in value to
     * <code>dub</code>.
     * @throws NumberFormatException if the parameter is infinite or
     * not a number.
     * @stable ICU 2.0
     */
    /* ActionScript : WONT PORT use constructor

     public static function valueOf(dub:Number):BigDecimal{
     // Reminder: a zero double returns '0.0', so we cannot fastpath to
     // use the constant ZERO. This might be important enough to justify
     // a factory approach, a cache, or a few private constants, later.
     return new BigDecimal(dub.toString());
     }
     */

    /* ---------------------------------------------------------------- */
    /* Private methods */
    /* ---------------------------------------------------------------- */

    /* <sgml> Return char array value of a BigDecimal (conversion from
     BigDecimal to laid-out canonical char array).
     <p>The mantissa will either already have been rounded (following an
     operation) or will be of length appropriate (in the case of
     construction from an int, for example).
     <p>We must not alter the mantissa, here.
     <p>'form' describes whether we are to use exponential notation (and
     if so, which), or if we are to lay out as a plain/pure numeric.
     </sgml> */

    private function layout():Array
    {
        var cmant:Array;
        var i:int;
        var sb:String = null;
        var euse:int = 0;
        var sig:int = 0;
        var csign:String = "";
        var rec:Array = null;
        var needsign:int;
        var mag:int;
        var len:int = 0;

        cmant = new Array(mant.length); // copy byte[] to a char[]

        var $18:int = mant.length;
        i = 0;
        for (; $18 > 0; $18--, i++)
        {
            cmant[i] = String(mant[i]);
        }

        if (form != MathContext.NOTATION_PLAIN)
        {
            /* exponential notation needed */
            sb = "";
            if (ind == isneg)
            {
                sb += "-";
            }
            euse = (exp + cmant.length) - 1; // exponent to use
            /* setup sig=significant digits and copy to result */
            if (form == MathContext.NOTATION_SCIENTIFIC)
            {
                // [default]
                sb += cmant[0]; // significant character
                if (cmant.length > 1)
                {
                    // have decimal part
                    sb += ".";
                    sb += cmant.slice(1).join("");
                }
            }
            else /* engineering */
            {
                sig = euse % 3; // common
                if (sig < 0)
                {
                    sig = 3 + sig; // negative exponent
                }
                euse = euse - sig;
                sig++;
                if (sig >= cmant.length)
                {
                    // zero padding may be needed
                    sb += cmant.join("");
                    {
                        var $19:int = sig - cmant.length;
                        for (; $19 > 0; $19--)
                        {
                            sb += "0";
                        }
                    }
                }
                else
                {
                    // decimal point needed
                    sb += cmant.slice(0, sig).join("");
                    sb += ".";
                    sb += cmant.slice(sig).join("");
                }
            }
            /*engineering*/

            if (euse != 0)
            {
                if (euse < 0)
                {
                    csign = "-";
                    euse = -euse;
                }
                else
                {
                    csign = "+";
                }
                sb += "E";
                sb += csign;
                sb += euse;
            }

            return sb.split("");
        }

        /* Here for non-exponential (plain) notation */
        if (exp == 0)
        {
            /* easy */
            if (ind >= 0)
            {
                return cmant; // non-negative integer
            }
            rec = new Array(cmant.length + 1);
            rec[0] = "-";
            arraycopy(cmant, 0, rec, 1, cmant.length);

            return rec;
        }

        /* Need a '.' and/or some zeros */
        needsign = ((ind == isneg) ? 1 : 0); // space for sign? 0 or 1

        /* MAG is the position of the point in the mantissa (index of the
         character it follows) */
        mag = exp + cmant.length;

        if (mag < 1)
        {
            /* 0.00xxxx form */
            len = (needsign + 2) - exp;
            rec = new Array(len);
            if (needsign != 0)
            {
                rec[0] = "-";
            }
            rec[needsign] = "0";
            rec[needsign + 1] = ".";
            var $20:int = -mag;
            i = needsign + 2;
            for (; $20 > 0; $20--, i++)
            {
                // maybe none
                rec[i] = "0";
            }

            arraycopy(cmant, 0, rec, (needsign + 2) - mag, cmant.length);
            return rec;
        }

        if (mag > cmant.length)
        {
            /* xxxx0000 form */
            len = needsign + mag;
            rec = new Array(len);
            if (needsign != 0)
            {
                rec[0] = "-";
            }

            arraycopy(cmant, 0, rec, needsign, cmant.length);

            var $21:int = mag - cmant.length;
            i = needsign + cmant.length;
            for (; $21 > 0; $21--, i++)
            {
                // never 0
                rec[i] = "0";
            }

            return rec;
        }

        /* decimal point is in the middle of the mantissa */
        len = (needsign + 1) + cmant.length;
        rec = new Array(len);

        if (needsign != 0)
        {
            rec[0] = '-';
        }

        arraycopy(cmant, 0, rec, needsign, mag);
        rec[needsign + mag] = ".";
        arraycopy(cmant, mag, rec, (needsign + mag) + 1, cmant.length - mag);

        return rec;
    }

    /* <sgml> Carry out division operations. </sgml> */
    /*
     Arg1 is operation code: D=divide, I=integer divide, R=remainder
     Arg2 is the rhs.
     Arg3 is the context.
     Arg4 is explicit scale iff code='D' or 'I' (-1 if none).

     Underlying algorithm (complications for Remainder function and
     scaled division are omitted for clarity):

     Test for x/0 and then 0/x
     Exp =Exp1 - Exp2
     Exp =Exp +len(var1) -len(var2)
     Sign=Sign1 * Sign2
     Pad accumulator (Var1) to double-length with 0's (pad1)
     Pad Var2 to same length as Var1
     B2B=1st two digits of var2, +1 to allow for roundup
     have=0
     Do until (have=digits+1 OR residue=0)
     if exp<0 then if integer divide/residue then leave
     this_digit=0
     Do forever
     compare numbers
     if <0 then leave inner_loop
     if =0 then (- quick exit without subtract -) do
     this_digit=this_digit+1; output this_digit
     leave outer_loop; end
     Compare lengths of numbers (mantissae):
     If same then CA=first_digit_of_Var1
     else CA=first_two_digits_of_Var1
     mult=ca*10/b2b -- Good and safe guess at divisor
     if mult=0 then mult=1
     this_digit=this_digit+mult
     subtract
     end inner_loop
     if have\=0 | this_digit\=0 then do
     output this_digit
     have=have+1; end
     var2=var2/10
     exp=exp-1
     end outer_loop
     exp=exp+1 -- set the proper exponent
     if have=0 then generate answer=0
     Return to FINISHED
     Result defined by MATHV1

     For extended commentary, see DMSRCN.
     */

    private function dodivide(code:String, rhs:BigDecimal, context:MathContext, scale:int):BigDecimal
    {
        var lhs:BigDecimal;
        var reqdig:int;
        var newexp:int;
        var res:BigDecimal;
        var newlen:int;
        var var1:Array;
        var var1len:int;
        var var2:Array;
        var var2len:int;
        var b2b:int;
        var have:int;
        var thisdigit:int;
        var i:int = 0;
        var v2:int = 0;
        var ba:int = 0;
        var mult:int;
        var start:int;
        var padding:int = 0;
        var d:int = 0;
        var newvar1:Array = null;
        var lasthave:int = 0;
        var actdig:int = 0;
        var newmant:Array = null;

        if (context.lostDigits)
        {
            checkdigits(rhs, context.digits);
        }

        lhs = this; // name for clarity

        // [note we must have checked lostDigits before the following checks]
        if (rhs.ind == 0)
        {
            throw new ArithmeticError("Division by zero"); // includes 0/0
        }

        if (lhs.ind == 0)
        {
            // 0/x => 0 [possibly with .0s]
            if (context.form != MathContext.NOTATION_PLAIN)
            {
                return ZERO;
            }
            if (scale == (-1))
            {
                return lhs;
            }
            return lhs.setScale(scale);
        }

        /* Prepare numbers according to BigDecimal rules */
        reqdig = context.digits; // local copy (heavily used)

        if (reqdig > 0)
        {
            if (lhs.mant.length > reqdig)
            {
                lhs = clone(lhs).roundContext(context);
            }
            if (rhs.mant.length > reqdig)
            {
                rhs = clone(rhs).roundContext(context);
            }
        }
        else
        {
            /* scaled divide */
            if (scale == (-1))
            {
                scale = lhs.scale();
            }
            // set reqdig to be at least large enough for the computation
            reqdig = lhs.mant.length; // base length
            // next line handles both positive lhs.exp and also scale mismatch
            if (scale != (-lhs.exp))
            {
                reqdig = (reqdig + scale) + lhs.exp;
            }
            reqdig = (reqdig - ((rhs.mant.length - 1))) - rhs.exp; // reduce by RHS effect
            if (reqdig < lhs.mant.length)
            {
                reqdig = lhs.mant.length; // clamp
            }
            if (reqdig < rhs.mant.length)
            {
                reqdig = rhs.mant.length; // ..
            }
        }

        /* precalculate exponent */
        newexp = ((lhs.exp - rhs.exp) + lhs.mant.length) - rhs.mant.length;
        /* If new exponent -ve, then some quick exits are possible */
        if (newexp < 0)
        {
            if (code != "D")
            {
                if (code == "I")
                {
                    return ZERO; // easy - no integer part
                }
                /* Must be 'R'; remainder is [finished clone of] input value */
                return clone(lhs).finish(context, false);
            }
        }

        /* We need slow division */
        res = new BigDecimal(); // where we'll build result
        res.ind = (lhs.ind * rhs.ind); // final sign (for D/I)
        res.exp = newexp; // initial exponent (for D/I)
        res.mant = createArrayWithZeros(reqdig + 1); // where build the result

        /* Now [virtually pad the mantissae with trailing zeros */
        // Also copy the LHS, which will be our working array
        newlen = (reqdig + reqdig) + 1;
        var1 = extend(lhs.mant, newlen); // always makes longer, so new safe array
        var1len = newlen; // [remaining digits are 0]

        var2 = rhs.mant;
        var2len = newlen;

        /* Calculate first two digits of rhs (var2), +1 for later estimations */
        b2b = (var2[0] * 10) + 1;
        if (var2.length > 1)
        {
            b2b = b2b + var2[1];
        }

        /* start the long-division loops */
        have = 0;

        outer:for (; ;)
        {
            thisdigit = 0;
            /* find the next digit */
            inner:for (; ;) /*inner*/
            {
                if (var1len < var2len)
                {
                    break /*inner*/; // V1 too low
                }
                if (var1len == var2len)
                {
                    // compare needed
                    compare:{
                        // comparison
                        var $22:int = var1len;
                        i = 0;
                        for (; $22 > 0; $22--, i++)
                        {
                            // var1len is always <= var1.length
                            if (i < var2.length)
                            {
                                v2 = var2[i];
                            }
                            else
                            {
                                v2 = 0;
                            }
                            if (var1[i] < v2)
                            {
                                break inner; // V1 too low
                            }
                            if (var1[i] > v2)
                            {
                                break compare; // OK to subtract
                            }
                        }

                        /* reach here if lhs and rhs are identical; subtraction will
                         increase digit by one, and the residue will be 0 so we
                         are done; leave the loop with residue set to 0 (in case
                         code is 'R' or ROUND_UNNECESSARY or a ROUND_HALF_xxxx is
                         being checked) */
                        thisdigit++;
                        res.mant[have] = thisdigit;
                        have++;
                        var1[0] = 0; // residue to 0 [this is all we'll test]
                        // var1len=1 -- [optimized out]
                        break outer;
                    }
                    /*compare*/

                    /* prepare for subtraction. Estimate BA (lengths the same) */
                    ba = var1[0]; // use only first digit
                } /* lengths the same */
                else
                {
                    /* lhs longer than rhs */
                    /* use first two digits for estimate */
                    ba = var1[0] * 10;
                    if (var1len > 1)
                    {
                        ba = ba + var1[1];
                    }
                }

                /* subtraction needed; V1>=V2 */
                mult = int(ba * 10) / b2b;
                if (mult == 0)
                {
                    mult = 1;
                }
                thisdigit = thisdigit + mult;
                // subtract; var1 reusable
                var1 = byteaddsub(var1, var1len, var2, var2len, -mult, true);

                if (var1[0] != 0)
                {
                    continue /*inner*/; // maybe another subtract needed
                }
                /* V1 now probably has leading zeros, remove leading 0's and try
                 again. (It could be longer than V2) */
                var $23:int = var1len - 2;
                start = 0;
                for (; start <= $23; start++) /* start */
                {
                    if (var1[start] != 0)
                    {
                        break;
                        /* start */
                    }
                    var1len--;
                }
                /*start*/

                if (start == 0)
                {
                    continue /*inner*/;
                }
                // shift left
                arraycopy(var1, start, var1, 0, var1len);
            }
            /*inner*/

            /* We have the next digit */
            if (have != 0 || thisdigit != 0)
            {
                // put the digit we got
                res.mant[have] = thisdigit;
                have++;
                if (have == (reqdig + 1))
                {
                    break /*outer*/; // we have all we need
                }
                if (var1[0] == 0)
                {
                    break /*outer*/; // residue now 0
                }
            }
            /* can leave now if a scaled divide and exponent is small enough */
            if (scale >= 0)
            {
                if ((-res.exp) > scale)
                {
                    break /*outer*/;
                }
            }

            /* can leave now if not Divide and no integer part left */
            if (code != "D")
            {
                if (res.exp <= 0)
                {
                    break /*outer*/;
                }
            }
            res.exp = res.exp - 1; // reduce the exponent
            /* to get here, V1 is less than V2, so divide V2 by 10 and go for
             the next digit */
            var2len--;
        }
        /*outer*/

        /* here when we have finished dividing, for some reason */
        // have is the number of digits we collected in res.mant
        if (have == 0)
        {
            have = 1; // res.mant[0] is 0; we always want a digit
        }

        if (code == "I" || code == "R")
        {
            /* check for integer overflow needed */
            if ((have + res.exp) > reqdig)
            {
                throw new Error("Integer overflow");
            }

            if (code == "R") /*remainder*/
            {
                /* We were doing Remainder -- return the residue */
                if (res.mant[0] == 0)
                {
                    // no integer part was found
                    return clone(lhs).finish(context, false); // .. so return lhs, canonical
                }
                if (var1[0] == 0)
                {
                    return ZERO; // simple 0 residue
                }
                res.ind = lhs.ind; // sign is always as LHS
                /* Calculate the exponent by subtracting the number of padding zeros
                 we added and adding the original exponent */
                padding = ((reqdig + reqdig) + 1) - lhs.mant.length;
                res.exp = (res.exp - padding) + lhs.exp;

                /* strip insignificant padding zeros from residue, and create/copy
                 the resulting mantissa if need be */
                d = var1len;
                i = d - 1;
                for (; i >= 1; i--)
                {
                    if (!((res.exp < lhs.exp) && (res.exp < rhs.exp)))
                    {
                        break;
                    }
                    if (var1[i] != 0)
                    {
                        break;
                    }
                    d--;
                    res.exp = res.exp + 1;
                }

                if (d < var1.length)
                {
                    /* need to reduce */
                    newvar1 = new Array(d);
                    arraycopy(var1, 0, newvar1, 0, d); // shorten
                    var1 = newvar1;
                }
                res.mant = var1;
                return res.finish(context, false);
            }
            /*remainder*/
        }
        else
        {
            /* 'D' -- no overflow check needed */
            // If there was a residue then bump the final digit (iff 0 or 5)
            // so that the residue is visible for ROUND_UP, ROUND_HALF_xxx and
            // ROUND_UNNECESSARY checks (etc.) later.
            // [if we finished early, the residue will be 0]
            if (var1[0] != 0)
            {
                // residue not 0
                lasthave = res.mant[have - 1];
                if ((lasthave % 5) == 0)
                {
                    res.mant[have - 1] = (lasthave + 1);
                }
            }
        }

        /* Here for Divide or Integer Divide */
        // handle scaled results first ['I' always scale 0, optional for 'D']
        if (scale >= 0) /*scaled*/
        {
            // say 'scale have res.exp len' scale have res.exp res.mant.length
            if (have != res.mant.length)
            {
                // already padded with 0's, so just adjust exponent
                res.exp = res.exp - ((res.mant.length - have));
            }
            // calculate number of digits we really want [may be 0]
            actdig = res.mant.length - (((-res.exp) - scale));
            res.round(actdig, context.roundingMode); // round to desired length
            // This could have shifted left if round (say) 0.9->1[.0]
            // Repair if so by adding a zero and reducing exponent
            if (res.exp != (-scale))
            {
                res.mant = extend(res.mant, res.mant.length + 1);
                res.exp = res.exp - 1;
            }
            return res.finish(context, true); // [strip if not PLAIN]
        }
        /*scaled*/

        // reach here only if a non-scaled
        if (have == res.mant.length)
        {
            // got digits+1 digits
            res.roundContext(context);
        }
        else
        {
            /* have<=reqdig */
            if (res.mant[0] == 0)
            {
                return ZERO; // fastpath
            }
            // make the mantissa truly just 'have' long
            // [we could let finish do this, during strip, if we adjusted
            // the exponent; however, truncation avoids the strip loop]
            newmant = new Array(have); // shorten
            arraycopy(res.mant, 0, newmant, 0, have);
            res.mant = newmant;
        }

        return res.finish(context, true);
    }


    /* <sgml> Report a conversion exception. </sgml> */

    private static function bad(s:String):void
    {
        throw new ArgumentError("Not a number: " + s);
    }

    /* <sgml> Extend byte array to given length, padding with 0s. If no
     extension is required then return the same array. </sgml>

     Arg1 is the source byte array
     Arg2 is the new length (longer)
     */

    private static function extend(inarr:Array, newlen:int):Array
    {
        var newarr:Array;
        if (inarr.length == newlen)
        {
            return inarr;
        }
        newarr = createArrayWithZeros(newlen);
        //--java.lang.System.arraycopy((java.lang.Object)inarr,0,(java.lang.Object)newarr,0,inarr.length);
        arraycopy(inarr, 0, newarr, 0, inarr.length);
        // 0 padding is carried out by the JVM on allocation initialization
        return newarr;
    }

    /* <sgml> Add or subtract two >=0 integers in byte arrays
     <p>This routine performs the calculation:
     <pre>
     C=A+(B*M)
     </pre>
     Where M is in the range -9 through +9
     <p>
     If M<0 then A>=B must be true, so the result is always
     non-negative.

     Leading zeros are not removed after a subtraction. The result is
     either the same length as the longer of A and B, or 1 longer than
     that (if a carry occurred).

     A is not altered unless Arg6 is 1.
     B is never altered.

     Arg1 is A
     Arg2 is A length to use (if longer than A, pad with 0's)
     Arg3 is B
     Arg4 is B length to use (if longer than B, pad with 0's)
     Arg5 is M, the multiplier
     Arg6 is 1 if A can be used to build the result (if it fits)

     This routine is severely performance-critical; *any* change here
     must be measured (timed) to assure no performance degradation.
     */
    // 1996.02.20 -- enhanced version of DMSRCN algorithm (1981)
    // 1997.10.05 -- changed to byte arrays (from char arrays)
    // 1998.07.01 -- changed to allow destructive reuse of LHS
    // 1998.07.01 -- changed to allow virtual lengths for the arrays
    // 1998.12.29 -- use lookaside for digit/carry calculation
    // 1999.08.07 -- avoid multiply when mult=1, and make db an int
    // 1999.12.22 -- special case m=-1, also drop 0 special case

    private static function byteaddsub(a:Array, avlen:int, b:Array, bvlen:int, m:int, reuse:Boolean):Array
    {
        var alength:int;
        var blength:int;
        var ap:int;
        var bp:int;
        var maxarr:int;
        var reb:Array;
        var quickm:Boolean;
        var digit:int;
        var op:int;
        var dp90:int = 0;
        var newarr:Array;
        var i:int = 0;

        // We'll usually be right if we assume no carry
        alength = a.length; // physical lengths
        blength = b.length; // ..
        ap = avlen - 1; // -> final (rightmost) digit
        bp = bvlen - 1; // ..
        maxarr = bp;

        if (maxarr < ap)
        {
            maxarr = ap;
        }

        reb = null; // result byte array

        if (reuse)
        {
            if ((maxarr + 1) == alength)
            {
                reb = a; // OK to reuse A
            }
        }
        if (reb == null)
        {
            reb = createArrayWithZeros(maxarr + 1); // need new array
        }

        quickm = false; // 1 if no multiply needed

        if (m == 1)
        {
            quickm = true; // most common
        }
        else if (m == (-1))
        {
            quickm = true; // also common
        }

        digit = 0; // digit, with carry or borrow

        op = maxarr;
        for (; op >= 0; op--) /*op*/
        {
            if (ap >= 0)
            {
                if (ap < alength)
                {
                    digit = digit + a[ap]; // within A
                }
                ap--;
            }
            if (bp >= 0)
            {
                if (bp < blength)
                {
                    // within B
                    if (quickm)
                    {
                        if (m > 0)
                        {
                            digit = digit + b[bp]; // most common
                        }
                        else
                        {
                            digit = digit - b[bp]; // also common
                        }
                    }
                    else
                    {
                        digit = digit + (b[bp] * m);
                    }
                }
                bp--;
            }

            /* result so far (digit) could be -90 through 99 */
            if (digit < 10)
            {
                if (digit >= 0) /*quick*/
                {
                    // 0-9
                    reb[op] = digit;
                    digit = 0; // no carry
                    continue /*op*/;
                }
                /*quick*/
            }

            dp90 = digit + 90;
            reb[op] = bytedig[dp90]; // this digit
            digit = bytecar[dp90]; // carry or borrow
        }
        /*op*/

        if (digit == 0)
        {
            return reb; // no carry
        }
        // following line will become an Assert, later
        // if digit<0 then signal ArithmeticException("internal.error ["digit"]")

        /* We have carry -- need to make space for the extra digit */
        newarr = null;
        if (reuse)
        {
            if ((maxarr + 2) == a.length)
            {
                newarr = a; // OK to reuse A
            }
        }
        if (newarr == null)
        {
            newarr = new Array(maxarr + 2);
        }
        newarr[0] = digit; // the carried digit ..
        // .. and all the rest [use local loop for short numbers]
        if (maxarr < 10)
        {
            var $24:int = maxarr + 1;
            i = 0;
            for (; $24 > 0; $24--, i++)
            {
                newarr[i + 1] = reb[i];
            }
        }
        else
        {
            arraycopy(reb, 0, newarr, 1, maxarr + 1);
        }

        return newarr;
    }

    /* <sgml> Initializer for digit array properties (lookaside). </sgml>
     Returns the digit array, and initializes the carry array. */

    private static function diginit():Array
    {
        var work:Array;
        var op:int;
        var digit:int = 0;

        work = new Array((90 + 99) + 1);
        op = 0;
        for (; op <= (90 + 99); op++) /*op*/
        {
            digit = op - 90;
            if (digit >= 0)
            {
                work[op] = (digit % 10);
                bytecar[op] = int(digit / 10); // calculate carry
                continue /*op*/;
            }

            // borrowing...
            digit = digit + 100; // yes, this is right [consider -50]
            work[op] = (digit % 10);
            bytecar[op] = (int(digit / 10) - 10); // calculate borrow [NB: - after %]
        }
        /*op*/
        return work;
    }

    /* <sgml> Create a copy of BigDecimal object for local use.
     <p>This does NOT make a copy of the mantissa array.
     </sgml>
     Arg1 is the BigDecimal to clone (non-null)
     */

    private static function clone(dec:BigDecimal):BigDecimal
    {
        const copy:BigDecimal = new BigDecimal(null);
        copy.ind = dec.ind;
        copy.exp = dec.exp;
        copy.form = dec.form;
        copy.mant = dec.mant;
        return copy;
    }

    /* <sgml> Check one or two numbers for lost digits. </sgml>
     Arg1 is RHS (or null, if none)
     Arg2 is current DIGITS setting
     returns quietly or throws an exception */

    private function checkdigits(rhs:BigDecimal, dig:int):void
    {
        if (dig == 0)
        {
            return; // don't check if digits=0
        }
        // first check lhs...
        if (this.mant.length > dig)
        {
            if ((!(allzero(this.mant, dig))))
            {
                throw new Error("Too many digits:" + " " + this.toString());
            }
        }
        if (rhs == null)
        {
            return; // monadic
        }
        if (rhs.mant.length > dig)
        {
            if ((!(allzero(rhs.mant, dig))))
            {
                throw new Error("Too many digits:" + " " + rhs.toString());
            }
        }
    }

    /* <sgml> Round to specified digits, if necessary. </sgml>
     Arg1 is requested MathContext [with length and rounding mode]
     returns this, for convenience */

    private function roundContext(context:MathContext):BigDecimal
    {
        return round(context.digits, context.roundingMode);
    }

    /* <sgml> Round to specified digits, if necessary.
     Arg1 is requested length (digits to round to)
     [may be <=0 when called from format, dodivide, etc.]
     Arg2 is rounding mode
     returns this, for convenience

     ind and exp are adjusted, but not cleared for a mantissa of zero

     The length of the mantissa returned will be Arg1, except when Arg1
     is 0, in which case the returned mantissa length will be 1.
     </sgml>
     */

    private function round(len:int, mode:int):BigDecimal
    {
        var adjust:int;
        var sign:int;
        var oldmant:Array;
        var reuse:Boolean = false;
        var first:int = 0;
        var increment:int;
        var newmant:Array = null;

        adjust = mant.length - len;
        if (adjust <= 0)
        {
            return this; // nowt to do
        }

        exp = exp + adjust; // exponent of result
        sign = ind; // save [assumes -1, 0, 1]
        oldmant = mant; // save

        if (len > 0)
        {
            // remove the unwanted digits
            mant = new Array(len);
            arraycopy(oldmant, 0, mant, 0, len);
            reuse = true; // can reuse mantissa
            first = oldmant[len]; // first of discarded digits
        }
        else
        {
            /* len<=0 */
            mant = ZERO.mant;
            ind = iszero;
            reuse = false; // cannot reuse mantissa
            if (len == 0)
                first = oldmant[0];
            else
                first = 0; // [virtual digit]
        }

        // decide rounding adjustment depending on mode, sign, and discarded digits
        increment = 0; // bumper

        /*modes*/
        if (mode == MathContext.ROUND_HALF_UP)
        {
            // default first [most common]
            if (first >= 5)
            {
                increment = sign;
            }
        }
        else if (mode == MathContext.ROUND_UNNECESSARY)
        {
            // default for setScale()
            // discarding any non-zero digits is an error
            if (!allzero(oldmant, len))
            {
                throw new ArithmeticError("Rounding necessary");
            }
        }
        else if (mode == MathContext.ROUND_HALF_DOWN)
        {
            // 0.5000 goes down
            if (first > 5)
            {
                increment = sign;
            }
            else if (first == 5)
            {
                if (!allzero(oldmant, len + 1))
                {
                    increment = sign;
                }
            }
        }
        else if (mode == MathContext.ROUND_HALF_EVEN)
        {
            // 0.5000 goes down if left digit even
            if (first > 5)
            {
                increment = sign;
            }
            else if (first == 5)
            {
                if (!allzero(oldmant, len + 1))
                {
                    increment = sign;
                }
                else /* 0.5000 */ if (((mant[mant.length - 1]) % 2) == 1)
                {
                    increment = sign;
                }
            }
        }
        else if (mode == MathContext.ROUND_DOWN)
        {
            // never increment
        }
        else if (mode == MathContext.ROUND_UP)
        {
            // increment if discarded non-zero
            if (!allzero(oldmant, len))
            {
                increment = sign;
            }
        }
        else if (mode == MathContext.ROUND_CEILING)
        {
            // more positive
            if (sign > 0)
            {
                if (!allzero(oldmant, len))
                {
                    increment = sign;
                }
            }
        }
        else if (mode == MathContext.ROUND_FLOOR)
        {
            // more negative
            if (sign < 0)
            {
                if (!allzero(oldmant, len))
                {
                    increment = sign;
                }
            }
        }
        else
        {
            throw new ArgumentError("Bad round value: " + mode);
        }
        /*modes*/

        if (increment != 0) /*bump*/
        {
            if (ind == iszero)
            {
                // we must not subtract from 0, but result is trivial anyway
                mant = ONE.mant;
                ind = increment;
            }
            else
            {
                // mantissa is non-0; we can safely add or subtract 1
                if (ind == isneg)
                {
                    increment = -increment;
                }
                newmant = byteaddsub(mant, mant.length, ONE.mant, 1, increment, reuse);
                if (newmant.length > mant.length)
                {
                    // had a carry
                    // drop rightmost digit and raise exponent
                    exp++;
                    // mant is already the correct length
                    arraycopy(newmant, 0, mant, 0, mant.length);
                }
                else
                {
                    mant = newmant;
                }
            }
        }
        /*bump*/
        // rounding can increase exponent significantly
        if (exp > MaxExp)
        {
            throw new ArithmeticError("Overflow: " + exp);
        }
        return this;
    }

    /* <sgml> Test if rightmost digits are all 0.
     Arg1 is a mantissa array to test
     Arg2 is the offset of first digit to check
     [may be negative; if so, digits to left are 0's]
     returns 1 if all the digits starting at Arg2 are 0

     Arg2 may be beyond array bounds, in which case 1 is returned
     </sgml> */

    private static function allzero(array:Array, i:int):Boolean
    {
        if (i < 0)
        {
            i = 0;
        }

        var $25:int = array.length - 1;
        for (; i <= $25; i++)
        {
            if (array[i] != 0)
            {
                return false;
            }
        }

        return true;
    }

    /* <sgml> Carry out final checks and canonicalization
     <p>
     This finishes off the current number by:
     1. Rounding if necessary (NB: length includes leading zeros)
     2. Stripping trailing zeros (if requested and \PLAIN)
     3. Stripping leading zeros (always)
     4. Selecting exponential notation (if required)
     5. Converting a zero result to just '0' (if \PLAIN)
     In practice, these operations overlap and share code.
     It always sets form.
     </sgml>
     Arg1 is requested MathContext (length to round to, trigger, and FORM)
     Arg2 is 1 if trailing insignificant zeros should be removed after
     round (for division, etc.), provided that set.form isn't PLAIN.
     returns this, for convenience
     */

    private function finish(context:MathContext, strip:Boolean):BigDecimal
    {
        var d:int = 0;
        var i:int = 0;
        var newmant:Array = null;
        var mag:int = 0;
        var sig:int = 0;

        /* Round if mantissa too long and digits requested */
        if (context.digits != 0)
        {
            if (this.mant.length > context.digits)
            {
                this.roundContext(context);
            }
        }

        /* If strip requested (and standard formatting), remove
         insignificant trailing zeros. */
        if (strip)
        {
            if (context.form != MathContext.NOTATION_PLAIN)
            {
                d = this.mant.length;
                /* see if we need to drop any trailing zeros */
                i = d - 1;
                for (; i >= 1; i--)
                {
                    if (this.mant[i] != 0)
                    {
                        break;
                    }
                    d--;
                    exp++;
                }

                if (d < this.mant.length)
                {
                    /* need to reduce */
                    newmant = new Array(d);
                    arraycopy(this.mant, 0, newmant, 0, d);
                    this.mant = newmant;
                }
            }
        }

        form = MathContext.NOTATION_PLAIN; // preset

        /* Now check for leading- and all- zeros in mantissa */
        var $26:int = this.mant.length;
        i = 0;
        for (; $26 > 0; $26--, i++) /*i*/
        {
            if (this.mant[i] != 0)
            {
                // non-0 result; ind will be correct
                // remove leading zeros [e.g., after subtract]
                if (i > 0) /*delead*/
                {
                    newmant = new Array(this.mant.length - i);
                    arraycopy(this.mant, i, newmant, 0, this.mant.length - i);
                    this.mant = newmant;
                }
                /*delead*/

                // now determine form if not PLAIN
                mag = exp + mant.length;
                if (mag > 0)
                {
                    // most common path
                    if (mag > context.digits)
                    {
                        if (context.digits != 0)
                        {
                            form = context.form;
                        }
                    }
                    if ((mag - 1) <= MaxExp)
                    {
                        return this; // no overflow; quick return
                    }
                }
                else if (mag < (-5))
                {
                    form = context.form;
                }
                /* check for overflow */
                mag--;
                if ((mag < MinExp) || (mag > MaxExp))
                {
                    overflow:{
                        // possible reprieve if form is engineering
                        if (form == MathContext.NOTATION_ENGINEERING)
                        {
                            sig = mag % 3; // leftover
                            if (sig < 0)
                            {
                                sig = 3 + sig; // negative exponent
                            }
                            mag = mag - sig; // exponent to use
                            // 1999.06.29: second test here must be MaxExp
                            if (mag >= MinExp)
                            {
                                if (mag <= MaxExp)
                                {
                                    break overflow;
                                }
                            }
                        }
                        throw new ArithmeticError("Underflow");
                    }
                }
                /*overflow*/

                return this;
            }
        }
        /*i*/

        // Drop through to here only if mantissa is all zeros
        ind = iszero;

        if (context.form != MathContext.NOTATION_PLAIN)
        {
            exp = 0; // standard result; go to '0'
        }
        else if (exp > 0)
        {
            exp = 0; // +ve exponent also goes to '0'
        }
        else
        {
            // a plain number with -ve exponent; preserve and check exponent
            if (exp < MinExp)
            {
                throw new ("Exponent Overflow:" + " " + exp);
            }
        }

        mant = ZERO.mant; // canonical mantissa
        return this;
    }
}
}