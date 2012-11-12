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
import org.flexunit.asserts.fail;

/**
 * Class:  BigDecimal
 * Methods: constructors and fields
 */
public class BigDecimalConstructorsTest
{
    [Test]
    /**
     * check ONE
     */
    public function testFieldONE():void
    {
        var oneS:String = "1";
        var oneD:Number = 1.0;
        assertEquals("incorrect string value", oneS, BigDecimal.ONE.toCanonicalString());
        assertEquals("incorrect double value", oneD, BigDecimal.ONE.numberValue()); //, 0);
    }

    [Test]
    /**
     * check TEN
     */
    public function testFieldTEN():void
    {
        var oneS:String = "10";
        var oneD:Number = 10.0;
        assertEquals("incorrect string value", oneS, BigDecimal.TEN.toCanonicalString());
        assertEquals("incorrect double value", oneD, BigDecimal.TEN.numberValue()); //, 0);
    }

    [Test]
    /**
     * check ZERO
     */
    public function testFieldZERO():void
    {
        var oneS:String = "0";
        var oneD:Number = 0.0;
        assertEquals("incorrect string value", oneS, BigDecimal.ZERO.toCanonicalString());
        assertEquals("incorrect double value", oneD, BigDecimal.ZERO.numberValue()); //, 0);
    }

//    [Test]
//    /**
//     * new BigDecimal(BigInteger value)
//     */
//    public function testConstrBI():void {
//        var a:String = "1231212478987482988429808779810457634781384756794987";
//        var bA:BigInteger = new BigInteger(a);
//        var aNumber:BigDecimal = new BigDecimal(bA);
//        assertEquals("incorrect value", bA, aNumber.unscaledValue());
//        assertEquals("incorrect scale", 0, aNumber.scale());
//
//        try {
//            new BigDecimal((BigInteger) null);
//            fail("No NullPointerException");
//        } catch (NullPointerException e) {
//            //expected
//        }
//    }
//
//    [Test]
//    /**
//     * new BigDecimal(BigInteger value, int scale)
//     */
//public function testConstrBIScale():void {
//    var a:String = "1231212478987482988429808779810457634781384756794987";
//    var bA:BigInteger = new BigInteger(a);
//    var aScale:int = 10;
//    var aNumber:BigDecimal = new BigDecimal(bA, aScale);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(BigInteger value, MathContext)
//     */
//public function testConstrBigIntegerMathContext():void {
//    var a:String = "1231212478987482988429808779810457634781384756794987";
//    var bA:BigInteger = new BigInteger(a);
//    var precision:int = 46;
//    var rm:RoundingMode = RoundingMode.CEILING;
//    var mc:MathContext = new MathContext(precision, rm);
//    var res:String = "1231212478987482988429808779810457634781384757";
//    var resScale:int = -6;
//    var result:BigDecimal = new BigDecimal(bA, mc);
//    assertEquals("incorrect value", res, result.unscaledValue().toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(BigInteger value, int scale, MathContext)
//     */
//public function testConstrBigIntegerScaleMathContext():void {
//    var a:String = "1231212478987482988429808779810457634781384756794987";
//    var bA:BigInteger = new BigInteger(a);
//    var aScale:int = 10;
//    var precision:int = 46;
//    var rm:RoundingMode = RoundingMode.CEILING;
//    var mc:MathContext = new MathContext(precision, rm);
//    var res:String = "1231212478987482988429808779810457634781384757";
//    var resScale:int = 4;
//    var result:BigDecimal = new BigDecimal(bA, aScale, mc);
//    assertEquals("incorrect value", res, result.unscaledValue().toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(char[] value);
//     */
//public function testConstrChar():void {
//    var value[]:char = {'-', '1', '2', '3', '8', '0', '.', '4', '7', '3', '8', 'E', '-', '4', '2', '3'};
//    var result:BigDecimal = new BigDecimal(value);
//    var res:String = "-1.23804738E-419";
//    var resScale:int = 427;
//    assertEquals("incorrect value", res, result.toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//
//    try {
//        // Regression for HARMONY-783
//        new BigDecimal(new char[] {});
//        fail("NumberFormatException has not been thrown");
//    } catch (NumberFormatException e) {
//    }
//}
//
//    [Test]
//    /**
//     * new BigDecimal(char[] value, int offset, int len);
//     */
//public function testConstrCharIntInt():void {
//    var value[]:char = {'-', '1', '2', '3', '8', '0', '.', '4', '7', '3', '8', 'E', '-', '4', '2', '3'};
//    var offset:int = 3;
//    var len:int = 12;
//    var result:BigDecimal = new BigDecimal(value, offset, len);
//    var res:String = "3.804738E-40";
//    var resScale:int = 46;
//    assertEquals("incorrect value", res, result.toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//
//    try {
//        // Regression for HARMONY-783
//        new BigDecimal(new char[] {}, 0, 0);
//        fail("NumberFormatException has not been thrown");
//    } catch (NumberFormatException e) {
//    }
//}
//
//    [Test]
//    /**
//     * new BigDecimal(char[] value, int offset, int len, MathContext mc);
//     */
//public function testConstrCharIntIntMathContext():void {
//    var value[]:char = {'-', '1', '2', '3', '8', '0', '.', '4', '7', '3', '8', 'E', '-', '4', '2', '3'};
//    var offset:int = 3;
//    var len:int = 12;
//    var precision:int = 4;
//    var rm:RoundingMode = RoundingMode.CEILING;
//    var mc:MathContext = new MathContext(precision, rm);
//    var result:BigDecimal = new BigDecimal(value, offset, len, mc);
//    var res:String = "3.805E-40";
//    var resScale:int = 43;
//    assertEquals("incorrect value", res, result.toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//
//    try {
//        // Regression for HARMONY-783
//        new BigDecimal(new char[] {}, 0, 0, MathContext.DECIMAL32);
//        fail("NumberFormatException has not been thrown");
//    } catch (NumberFormatException e) {
//    }
//}
//
//    [Test]
//    /**
//     * new BigDecimal(char[] value, int offset, int len, MathContext mc);
//     */
//public function testConstrCharIntIntMathContextException1():void {
//    var value[]:char = {'-', '1', '2', '3', '8', '0', '.', '4', '7', '3', '8', 'E', '-', '4', '2', '3'};
//    var offset:int = 3;
//    var len:int = 120;
//    var precision:int = 4;
//    var rm:RoundingMode = RoundingMode.CEILING;
//    var mc:MathContext = new MathContext(precision, rm);
//    try {
//        new BigDecimal(value, offset, len, mc);
//        fail("NumberFormatException has not been thrown");
//    } catch (NumberFormatException e) {
//    }
//}
//
//    [Test]
//    /**
//     * new BigDecimal(char[] value, int offset, int len, MathContext mc);
//     */
//public function testConstrCharIntIntMathContextException2():void {
//    var value[]:char = {'-', '1', '2', '3', '8', '0', ',', '4', '7', '3', '8', 'E', '-', '4', '2', '3'};
//    var offset:int = 3;
//    var len:int = 120;
//    var precision:int = 4;
//    var rm:RoundingMode = RoundingMode.CEILING;
//    var mc:MathContext = new MathContext(precision, rm);
//    try {
//        new BigDecimal(value, offset, len, mc);
//        fail("NumberFormatException has not been thrown");
//    } catch (NumberFormatException e) {
//    }
//}
//
//    [Test]
//    /**
//     * new BigDecimal(char[] value, MathContext mc);
//     */
//public function testConstrCharMathContext():void {
//    try {
//        // Regression for HARMONY-783
//        new BigDecimal(new char[] {}, MathContext.DECIMAL32);
//        fail("NumberFormatException has not been thrown");
//    } catch (NumberFormatException e) {
//    }
//}
//
    [Test]
    /**
     * new BigDecimal(Number) when value is NaN
     */
    public function testConstrDoubleNaN():void
    {
        var a:Number = NaN;
        try
        {
            new BigDecimal(a);
            fail("ArgumentError has not been caught");
        } catch (e:ArgumentError)
        {
            assertEquals("Improper exception message", "Infinite or NaN", e.message);
        }
    }


    [Test]
    /**
     * new BigDecimal(double value) when value is positive infinity
     */
    public function testConstrDoublePosInfinity():void
    {
        var a:Number = Number.POSITIVE_INFINITY;
        try
        {
            new BigDecimal(a);
            fail("NumberFormatException has not been caught");
        } catch (e:ArgumentError)
        {
            assertEquals("Improper exception message", "Infinite or NaN", e.message);
        }
    }

    [Test]
    /**
     * new BigDecimal(double value) when value is positive infinity
     */
    public function testConstrDoubleNegInfinity():void {
        var a:Number = Number.NEGATIVE_INFINITY;
        try {
            new BigDecimal(a);
            fail("NumberFormatException has not been caught");
        } catch (e:ArgumentError) {
            assertEquals("Improper exception message", "Infinite or NaN", e.message);
        }
    }

//    [Test]
//    /**
//     * new BigDecimal(double value)
//     */
//    public function testConstrDouble():void {
//        var a:Number = 732546982374982347892379283571094797.287346782359284756;
//        var aScale:int = 0;
//        var bA:BigInteger = new BigInteger("732546982374982285073458350476230656");
//        var aNumber:BigDecimal = new BigDecimal(a);
//        assertEquals("incorrect value", bA, aNumber.unscaledValue());
//        assertEquals("incorrect scale", aScale, aNumber.scale());
//    }

//    [Test]
//    /**
//     * new BigDecimal(double, MathContext)
//     */
//public function testConstrDoubleMathContext():void {
//    var a:Number = 732546982374982347892379283571094797.287346782359284756;
//    var precision:int = 21;
//    var rm:RoundingMode = RoundingMode.CEILING;
//    var mc:MathContext = new MathContext(precision, rm);
//    var res:String = "732546982374982285074";
//    var resScale:int = -15;
//    var result:BigDecimal = new BigDecimal(a, mc);
//    assertEquals("incorrect value", res, result.unscaledValue().toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(0.1)
//     */
//public function testConstrDouble01():void {
//    var a:Number = 1.E-1;
//    var aScale:int = 55;
//    var bA:BigInteger = new BigInteger("1000000000000000055511151231257827021181583404541015625");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}

//    [Test]
//    /**
//     * new BigDecimal(0.555)
//     */
//public function testConstrDouble02():void {
//    var a:Number = 0.555;
//    var aScale:int = 53;
//    var bA:BigInteger = new BigInteger("55500000000000004884981308350688777863979339599609375");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(-0.1)
//     */
//public function testConstrDoubleMinus01():void {
//    var a:Number = -1.E-1;
//    var aScale:int = 55;
//    var bA:BigInteger = new BigInteger("-1000000000000000055511151231257827021181583404541015625");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(int value)
//     */
//public function testConstrInt():void {
//    var a:int = 732546982;
//    var res:String = "732546982";
//    var resScale:int = 0;
//    var result:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", res, result.unscaledValue().toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(int, MathContext)
//     */
//public function testConstrIntMathContext():void {
//    var a:int = 732546982;
//    var precision:int = 21;
//    var rm:RoundingMode = RoundingMode.CEILING;
//    var mc:MathContext = new MathContext(precision, rm);
//    var res:String = "732546982";
//    var resScale:int = 0;
//    var result:BigDecimal = new BigDecimal(a, mc);
//    assertEquals("incorrect value", res, result.unscaledValue().toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(long value)
//     */
//public function testConstrLong():void {
//    var a:long = 4576578677732546982L;
//    var res:String = "4576578677732546982";
//    var resScale:int = 0;
//    var result:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", res, result.unscaledValue().toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(long, MathContext)
//     */
//public function testConstrLongMathContext():void {
//    var a:long = 4576578677732546982L;
//    var precision:int = 5;
//    var rm:RoundingMode = RoundingMode.CEILING;
//    var mc:MathContext = new MathContext(precision, rm);
//    var res:String = "45766";
//    var resScale:int = -14;
//    var result:BigDecimal = new BigDecimal(a, mc);
//    assertEquals("incorrect value", res, result.unscaledValue().toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(double value) when value is denormalized
//     */
//public function testConstrDoubleDenormalized():void {
//    var a:Number = 2.274341322658976E-309;
//    var aScale:int = 1073;
//    var bA:BigInteger = new BigInteger("227434132265897633950269241702666687639731047124115603942986140264569528085692462493371029187342478828091760934014851133733918639492582043963243759464684978401240614084312038547315281016804838374623558434472007664427140169018817050565150914041833284370702366055678057809362286455237716100382057360123091641959140448783514464639706721250400288267372238950016114583259228262046633530468551311769574111763316146065958042194569102063373243372766692713192728878701004405568459288708477607744497502929764155046100964958011009313090462293046650352146796805866786767887226278836423536035611825593567576424943331337401071583562754098901412372708947790843318760718495117047155597276492717187936854356663665005157041552436478744491526494952982062613955349661409854888916015625");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
    [Test]
    /**
     * new BigDecimal(String value)
     * when value is not a valid representation of BigDecimal.
     */
    public function testConstrStringException():void {
        var a:String = "-238768.787678287a+10";
        try {
            new BigDecimal(a);
            fail("ArgumentError has not been caught");
        } catch (e:ArgumentError) {}
    }

    [Test]
    /**
     * new BigDecimal(String value) when exponent is empty.
     */
    public function testConstrStringExceptionEmptyExponent1():void {
        var a:String = "-238768.787678287e";
        try {
            new BigDecimal(a);
            fail("ArgumentError has not been caught");
        } catch (e:ArgumentError) {}
    }

    [Test]
    /**
     * new BigDecimal(String value) when exponent is empty.
     */
    public function testConstrStringExceptionEmptyExponent2():void {
        var a:String = "-238768.787678287e-";
        try {
            new BigDecimal(a);
            fail("ArgumentError has not been caught");
        } catch (e:ArgumentError) {}
    }

    [Test]
    /**
     * new BigDecimal(String value) when exponent is greater than
     * Integer.MAX_VALUE.
     */
    public function testConstrStringExceptionExponentGreaterIntegerMax():void {
        var a:String = "-238768.787678287e214748364767876";
        try {
            new BigDecimal(a);
            fail("ArgumentError has not been caught");
        } catch (e:ArgumentError) {}
    }

    [Test]
    /**
     * new BigDecimal(String value) when exponent is less than
     * Integer.MIN_VALUE.
     */
    public function testConstrStringExceptionExponentLessIntegerMin():void {
        var a:String = "-238768.787678287e-214748364767876";
        try {
            new BigDecimal(a);
            fail("NumberFormatException has not been caught");
        } catch (e:ArgumentError) {}
    }

//    [Test]
//    /**
//     * new BigDecimal(String value)
//     * when exponent is Integer.MAX_VALUE.
//     */
//    public function testConstrStringExponentIntegerMax():void {
//        var a:String = "-238768.787678287e2147483647";
//        var aScale:int = -2147483638;
//        var bA:BigInteger = new BigInteger("-238768787678287");
//        var aNumber:BigDecimal = new BigDecimal(a);
//        assertEquals("incorrect value", bA, aNumber.unscaledValue());
//        assertEquals("incorrect scale", aScale, aNumber.scale());
//    }

//    [Test]
//    /**
//     * new BigDecimal(String value)
//     * when exponent is Integer.MIN_VALUE.
//     */
//    public function testConstrStringExponentIntegerMin():void {
//        var a:String = ".238768e-2147483648";
//        try {
//            new BigDecimal(a);
//            fail("NumberFormatException expected");
//        } catch (e:ArgumentError) {
////            assertEquals("Improper exception message","Scale out of range.", e.message);
//        }
//    }

//    [Test]
//    /**
//     * new BigDecimal(String value); value does not contain exponent
//     */
//public function testConstrStringWithoutExpPos1():void {
//    var a:String = "732546982374982347892379283571094797.287346782359284756";
//    var aScale:int = 18;
//    var bA:BigInteger = new BigInteger("732546982374982347892379283571094797287346782359284756");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value); value does not contain exponent
//     */
//public function testConstrStringWithoutExpPos2():void {
//    var a:String = "+732546982374982347892379283571094797.287346782359284756";
//    var aScale:int = 18;
//    var bA:BigInteger = new BigInteger("732546982374982347892379283571094797287346782359284756");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value); value does not contain exponent
//     */
//public function testConstrStringWithoutExpNeg():void {
//    var a:String = "-732546982374982347892379283571094797.287346782359284756";
//    var aScale:int = 18;
//    var bA:BigInteger = new BigInteger("-732546982374982347892379283571094797287346782359284756");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value); value does not contain exponent
//     * and decimal point
//     */
//public function testConstrStringWithoutExpWithoutPoint():void {
//    var a:String = "-732546982374982347892379283571094797287346782359284756";
//    var aScale:int = 0;
//    var bA:BigInteger = new BigInteger("-732546982374982347892379283571094797287346782359284756");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value); value contains exponent
//     * and does not contain decimal point
//     */
//public function testConstrStringWithExponentWithoutPoint1():void {
//    var a:String = "-238768787678287e214";
//    var aScale:int = -214;
//    var bA:BigInteger = new BigInteger("-238768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value); value contains exponent
//     * and does not contain decimal point
//     */
//public function testConstrStringWithExponentWithoutPoint2():void {
//    var a:String = "-238768787678287e-214";
//    var aScale:int = 214;
//    var bA:BigInteger = new BigInteger("-238768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value); value contains exponent
//     * and does not contain decimal point
//     */
//public function testConstrStringWithExponentWithoutPoint3():void {
//    var a:String = "238768787678287e-214";
//    var aScale:int = 214;
//    var bA:BigInteger = new BigInteger("238768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value); value contains exponent
//     * and does not contain decimal point
//     */
//public function testConstrStringWithExponentWithoutPoint4():void {
//    var a:String = "238768787678287e+214";
//    var aScale:int = -214;
//    var bA:BigInteger = new BigInteger("238768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value); value contains exponent
//     * and does not contain decimal point
//     */
//public function testConstrStringWithExponentWithoutPoint5():void {
//    var a:String = "238768787678287E214";
//    var aScale:int = -214;
//    var bA:BigInteger = new BigInteger("238768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value);
//     * value contains both exponent and decimal point
//     */
//public function testConstrStringWithExponentWithPoint1():void {
//    var a:String = "23985439837984782435652424523876878.7678287e+214";
//    var aScale:int = -207;
//    var bA:BigInteger = new BigInteger("239854398379847824356524245238768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value);
//     * value contains both exponent and decimal point
//     */
//public function testConstrStringWithExponentWithPoint2():void {
//    var a:String = "238096483923847545735673567457356356789029578490276878.7678287e-214";
//    var aScale:int = 221;
//    var bA:BigInteger = new BigInteger("2380964839238475457356735674573563567890295784902768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value);
//     * value contains both exponent and decimal point
//     */
//public function testConstrStringWithExponentWithPoint3():void {
//    var a:String = "2380964839238475457356735674573563567890.295784902768787678287E+21";
//    var aScale:int = 0;
//    var bA:BigInteger = new BigInteger("2380964839238475457356735674573563567890295784902768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value);
//     * value contains both exponent and decimal point
//     */
//public function testConstrStringWithExponentWithPoint4():void {
//    var a:String = "23809648392384754573567356745735635678.90295784902768787678287E+21";
//    var aScale:int = 2;
//    var bA:BigInteger = new BigInteger("2380964839238475457356735674573563567890295784902768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value);
//     * value contains both exponent and decimal point
//     */
//public function testConstrStringWithExponentWithPoint5():void {
//    var a:String = "238096483923847545735673567457356356789029.5784902768787678287E+21";
//    var aScale:int = -2;
//    var bA:BigInteger = new BigInteger("2380964839238475457356735674573563567890295784902768787678287");
//    var aNumber:BigDecimal = new BigDecimal(a);
//    assertEquals("incorrect value", bA, aNumber.unscaledValue());
//    assertEquals("incorrect scale", aScale, aNumber.scale());
//}
//
//    [Test]
//    /**
//     * new BigDecimal(String value, MathContext)
//     */
//public function testConstrStringMathContext():void {
//    var a:String = "-238768787678287e214";
//    var precision:int = 5;
//    var rm:RoundingMode = RoundingMode.CEILING;
//    var mc:MathContext = new MathContext(precision, rm);
//    var res:String = "-23876";
//    var resScale:int = -224;
//    var result:BigDecimal = new BigDecimal(a, mc);
//    assertEquals("incorrect value", res, result.unscaledValue().toString());
//    assertEquals("incorrect scale", resScale, result.scale());
//}
}
}
