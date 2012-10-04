/*
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
/**
 * @author Elena Semukhina
 */
package
{
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;

/**
 * Class:  BigDecimal
 * Methods: abs, compareTo, equals, hashCode,
 * max, min, negate, signum
 */
public class BigDecimalCompareTest
{
    [Test]
    /**
     * Abs() of a negative BigDecimal
     */
    public function testAbsNeg():void
    {
        var a:String = "-123809648392384754573567356745735.63567890295784902768787678287E+21";
        var aNumber:BigDecimal = new BigDecimal(a);
        var result:String = "123809648392384754573567356745735635678902957849027687.87678287";
        assertEquals("incorrect value", result, aNumber.abs().toString());
    }

    [Test]
    /**
     * Abs() of a positive BigDecimal
     */
    public function testAbsPos():void
    {
        var a:String = "123809648392384754573567356745735.63567890295784902768787678287E+21";
        var aNumber:BigDecimal = new BigDecimal(a);
        var result:String = "123809648392384754573567356745735635678902957849027687.87678287";
        assertEquals("incorrect value", result, aNumber.abs().toString());
    }

    [Test]
    /**
     * Abs(MathContext) of a negative BigDecimal
     */
    public function testAbsMathContextNeg():void
    {
        var a:String = "-123809648392384754573567356745735.63567890295784902768787678287E+21";
        var aNumber:BigDecimal = new BigDecimal(a);
        var precision:int = 15;
//    var rm:RoundingMode = RoundingMode.HALF_DOWN;
        var mc:MathContext = new MathContext(precision, MathContext.NOTATION_SCIENTIFIC, false, MathContext.ROUND_HALF_DOWN);
        var result:String = "1.23809648392385E+53";
        var resScale:int = -39;
        var res:BigDecimal = aNumber.abs(mc);
        assertEquals("incorrect value", result, res.toString());
        assertEquals("incorrect scale", resScale, res.scale());
    }

    [Test]
    /**
     * Abs(MathContext) of a positive BigDecimal
     */
    public function testAbsMathContextPos():void
    {
        var a:String = "123809648392384754573567356745735.63567890295784902768787678287E+21";
        var aNumber:BigDecimal = new BigDecimal(a);
        var precision:int = 41;
//    var rm:RoundingMode = RoundingMode.HALF_EVEN;
        var mc:MathContext = new MathContext(precision, MathContext.NOTATION_SCIENTIFIC, false, MathContext.ROUND_HALF_EVEN);
        var result:String = "1.2380964839238475457356735674573563567890E+53";
        var resScale:int = -13;
        var res:BigDecimal = aNumber.abs(mc);
        assertEquals("incorrect value", result, res.toString());
        assertEquals("incorrect scale", resScale, res.scale());
    }

    [Test]
    /**
     * Compare to a number of an equal scale
     */
    public function testCompareEqualScale1():void
    {
        var a:String = "12380964839238475457356735674573563567890295784902768787678287";
        var aScale:int = 18;
        var b:String = "4573563567890295784902768787678287";
        var bScale:int = 18;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:int = 1;
        assertEquals("incorrect result", result, aNumber.compareTo(bNumber));
    }

    [Test]
    /**
     * Compare to a number of an equal scale
     */
    public function testCompareEqualScale2():void
    {
        var a:String = "12380964839238475457356735674573563567890295784902768787678287";
        var aScale:int = 18;
        var b:String = "4573563923487289357829759278282992758247567890295784902768787678287";
        var bScale:int = 18;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:int = -1;
        assertEquals("incorrect result", result, aNumber.compareTo(bNumber));
    }

    [Test]
    /**
     * Compare to a number of an greater scale
     */
    public function testCompareGreaterScale1():void
    {
        var a:String = "12380964839238475457356735674573563567890295784902768787678287";
        var aScale:int = 28;
        var b:String = "4573563567890295784902768787678287";
        var bScale:int = 18;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:int = 1;
        assertEquals("incorrect result", result, aNumber.compareTo(bNumber));
    }

    [Test]
    /**
     * Compare to a number of an greater scale
     */
    public function testCompareGreaterScale2():void
    {
        var a:String = "12380964839238475457356735674573563567890295784902768787678287";
        var aScale:int = 48;
        var b:String = "4573563567890295784902768787678287";
        var bScale:int = 2;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:int = -1;
        assertEquals("incorrect result", result, aNumber.compareTo(bNumber));
    }

    [Test]
    /**
     * Compare to a number of an less scale
     */
    public function testCompareLessScale1():void
    {
        var a:String = "12380964839238475457356735674573563567890295784902768787678287";
        var aScale:int = 18;
        var b:String = "4573563567890295784902768787678287";
        var bScale:int = 28;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:int = 1;
        assertEquals("incorrect result", result, aNumber.compareTo(bNumber));
    }

    [Test]
    /**
     * Compare to a number of an less scale
     */
    public function testCompareLessScale2():void
    {
        var a:String = "12380964839238475457356735674573";
        var aScale:int = 36;
        var b:String = "45735635948573894578349572001798379183767890295784902768787678287";
        var bScale:int = 48;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:int = -1;
        assertEquals("incorrect result", result, aNumber.compareTo(bNumber));
    }

    [Test]
    /**
     * Equals() for unequal BigDecimals
     */
    public function testEqualsUnequal1():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = -24;
        var b:String = "7472334223847623782375469293018787918347987234564568";
        var bScale:int = 13;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        assertFalse(aNumber.equals(bNumber));
    }

    [Test]
    /**
     * Equals() for unequal BigDecimals
     */
    public function testEqualsUnequal2():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = -24;
        var b:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var bScale:int = 13;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        assertFalse(aNumber.equals(bNumber));
    }

    [Test]
    /**
     * Equals() for unequal BigDecimals
     */
    public function testEqualsUnequal3():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = -24;
        var b:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        assertFalse(aNumber.equals(b));
    }

    [Test]
    /**
     * equals() for equal BigDecimals
     */
    public function testEqualsEqual():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = -24;
        var b:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var bScale:int = -24;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        // todo was assertEquals(aNumber, bNumber);
        assertTrue(aNumber.equals(bNumber));
    }

    [Test]
    /**
     * equals() for equal BigDecimals
     */
    public function testEqualsNull():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = -24;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        assertFalse(aNumber.equals(null));
    }

//    [Test]
//    /**
//     * hashCode() for equal BigDecimals
//     */
//    public function testHashCodeEqual():void {
//        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var bScale:int = -24;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        assertEquals("incorrect value", aNumber.hashCode(), bNumber.hashCode());
//    }

//    [Test]
//    /**
//     * hashCode() for unequal BigDecimals
//     */
//    public function testHashCodeUnequal():void {
//        var a:String = "8478231212478987482988429808779810457634781384756794987";
//        var aScale:int = 41;
//        var b:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var bScale:int = -24;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        assertTrue("incorrect value", aNumber.hashCode() != bNumber.hashCode());
//    }

    [Test]
    /**
     * max() for equal BigDecimals
     */
    public function testMaxEqual():void
    {
        var a:String = "8478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var b:String = "8478231212478987482988429808779810457634781384756794987";
        var bScale:int = 41;
        var c:String = "8478231212478987482988429808779810457634781384756794987";
        var cScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.max(bNumber));
        assertTrue("incorrect value", cNumber.equals(aNumber.max(bNumber)));
    }

    [Test]
    /**
     * max() for unequal BigDecimals
     */
    public function testMaxUnequal1():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 24;
        var b:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var bScale:int = 41;
        var c:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var cScale:int = 24;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.max(bNumber));
        assertTrue("incorrect value", cNumber.equals(aNumber.max(bNumber)));
    }

    [Test]
    /**
     * max() for unequal BigDecimals
     */
    public function testMaxUnequal2():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var b:String = "94488478231212478987482988429808779810457634781384756794987";
        var bScale:int = 41;
        var c:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var cScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.max(bNumber));
        assertTrue("incorrect value", cNumber.equals(aNumber.max(bNumber)));
    }

    [Test]
    /**
     * min() for equal BigDecimals
     */
    public function testMinEqual():void
    {
        var a:String = "8478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var b:String = "8478231212478987482988429808779810457634781384756794987";
        var bScale:int = 41;
        var c:String = "8478231212478987482988429808779810457634781384756794987";
        var cScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.min(bNumber));
        assertTrue("incorrect value", cNumber.equals(aNumber.min(bNumber)));
    }

    [Test]
    /**
     * min() for unequal BigDecimals
     */
    public function testMinUnequal1():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 24;
        var b:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var bScale:int = 41;
        var c:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var cScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.min(bNumber));
        assertTrue("incorrect value", cNumber.equals(aNumber.min(bNumber)));
    }

    [Test]
    /**
     * min() for unequal BigDecimals
     */
    public function testMinUnequal2():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var b:String = "94488478231212478987482988429808779810457634781384756794987";
        var bScale:int = 41;
        var c:String = "94488478231212478987482988429808779810457634781384756794987";
        var cScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.min(bNumber));
        assertTrue("incorrect value", cNumber.equals(aNumber.min(bNumber)));
    }

    [Test]
    /**
     * plus() for a positive BigDecimal
     */
    public function testPlusPositive():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var c:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var cScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.plus());
        assertTrue("incorrect value", cNumber.equals(aNumber.plus()));
    }

    [Test]
    /**
     * plus(MathContext) for a positive BigDecimal
     */
    public function testPlusMathContextPositive():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var precision:int = 37;
//    var rm:RoundingMode = RoundingMode.FLOOR;
        var mc:MathContext = new MathContext(precision, MathContext.NOTATION_SCIENTIFIC, false, MathContext.ROUND_FLOOR);
        var c:String = "929487820944884782312124789.8748298842";
        var cScale:int = 10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var res:BigDecimal = aNumber.plus(mc);
        assertEquals("incorrect value", c, res.toString());
        assertEquals("incorrect scale", cScale, res.scale());
    }

    [Test]
    /**
     * plus() for a negative BigDecimal
     */
    public function testPlusNegative():void
    {
        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var c:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
        var cScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.plus());
        assertTrue("incorrect value", cNumber.equals(aNumber.plus()));
    }

    [Test]
    /**
     * plus(MathContext) for a negative BigDecimal
     */
    public function testPlusMathContextNegative():void
    {
        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 49;
        var precision:int = 46;
        //    var rm:RoundingMode = RoundingMode.CEILING;
        var mc:MathContext = new MathContext(precision, MathContext.NOTATION_SCIENTIFIC, false, MathContext.ROUND_CEILING);
        var c:String = "-9294878209448847823.121247898748298842980877981";
        var cScale:int = 27;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var res:BigDecimal = aNumber.plus(mc);
        assertEquals("incorrect value", c, res.toString());
        assertEquals("incorrect scale", cScale, res.scale());
    }

    [Test]
    /**
     * negate() for a positive BigDecimal
     */
    public function testNegatePositive():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var c:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
        var cScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.negate());
        assertTrue("incorrect value", cNumber.equals(aNumber.negate()));
    }

    [Test]
    /**
     * negate(MathContext) for a positive BigDecimal
     */
    public function testNegateMathContextPositive():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var precision:int = 37;
//    var rm:RoundingMode = RoundingMode.FLOOR;
        var mc:MathContext = new MathContext(precision, MathContext.NOTATION_SCIENTIFIC, false, MathContext.ROUND_FLOOR);
        var c:String = "-929487820944884782312124789.8748298842";
        var cScale:int = 10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var res:BigDecimal = aNumber.negate(mc);
        assertEquals("incorrect value", c, res.toString());
        assertEquals("incorrect scale", cScale, res.scale());
    }

    [Test]
    /**
     * negate() for a negative BigDecimal
     */
    public function testNegateNegative():void
    {
        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var c:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var cScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var cNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(c, cScale);
        // todo was assertEquals("incorrect value", cNumber, aNumber.negate());
        assertTrue("incorrect value", cNumber.equals(aNumber.negate()));
    }

    [Test]
    /**
     * negate(MathContext) for a negative BigDecimal
     */
    public function testNegateMathContextNegative():void
    {
        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 49;
        var precision:int = 46;
//    var rm:RoundingMode = RoundingMode.CEILING;
        var mc:MathContext = new MathContext(precision, MathContext.NOTATION_SCIENTIFIC, false, MathContext.ROUND_CEILING);
        var c:String = "9294878209448847823.121247898748298842980877981";
        var cScale:int = 27;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var res:BigDecimal = aNumber.negate(mc);
        assertEquals("incorrect value", c, res.toString());
        assertEquals("incorrect scale", cScale, res.scale());
    }

    [Test]
    /**
     * signum() for a positive BigDecimal
     */
    public function testSignumPositive():void
    {
        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        assertEquals("incorrect value", 1, aNumber.signum());
    }

    [Test]
    /**
     * signum() for a negative BigDecimal
     */
    public function testSignumNegative():void
    {
        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
        var aScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        assertEquals("incorrect value", -1, aNumber.signum());
    }

    [Test]
    /**
     * signum() for zero
     */
    public function testSignumZero():void
    {
        var a:String = "0";
        var aScale:int = 41;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        assertEquals("incorrect value", 0, aNumber.signum());
    }
}
}
