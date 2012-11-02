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
package
{
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.fail;

/**
 * Class:  BigDecimal
 * Methods: add, subtract, multiply, divide
 */
public class BigDecimalArithmeticTest
{
    [Test]
    /**
     * Add two numbers of equal positive scales
     */
    public function testAddEqualScalePosPos():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 10;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 10;
        var c:String = "123121247898748373566323807282924555312937.1991359555";
        var cScale:int = 10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.add(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Add two numbers of equal positive scales using MathContext
     */
    public function testAddMathContextEqualScalePosPos():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 10;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 10;
        var c:String = "1.2313E+41";
        var cScale:int = -37;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var mc:MathContext = new MathContext(5, false, MathContext.ROUND_UP);
        var result:BigDecimal = aNumber.add(bNumber, mc);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Add two numbers of equal negative scales
     */
    public function testAddEqualScaleNegNeg():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = -10;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = -10;
        var c:String = "1.231212478987483735663238072829245553129371991359555E+61";
        var cScale:int = -10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.add(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Add two numbers of equal negative scales using MathContext
     */
    public function testAddMathContextEqualScaleNegNeg():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = -10;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = -10;
        var c:String = "1.2312E+61";
        var cScale:int = -57;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var mc:MathContext = new MathContext(5, false, MathContext.ROUND_FLOOR);
        var result:BigDecimal = aNumber.add(bNumber, mc);
        assertEquals("incorrect value ", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Add two numbers of different scales; the first is positive
     */
    public function testAddDiffScalePosNeg():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = -10;
        var c:String = "7472334294161400358170962860775454459810457634.781384756794987";
        var cScale:int = 15;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.add(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Add two numbers of different scales using MathContext; the first is positive
     */
    public function testAddMathContextDiffScalePosNeg():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = -10;
        var c:String = "7.47233429416141E+45";
        var cScale:int = -31;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var mc:MathContext = new MathContext(15, false, MathContext.ROUND_CEILING);
        var result:BigDecimal = aNumber.add(bNumber, mc);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Add two numbers of different scales; the first is negative
     */
    public function testAddDiffScaleNegPos():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = -15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 10;
        var c:String = "1231212478987482988429808779810457634781459480137916301878791834798.7234564568";
        var cScale:int = 10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.add(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Add two zeroes of different scales; the first is negative
     */
    public function testAddDiffScaleZeroZero():void
    {
        var a:String = "0";
        var aScale:int = -15;
        var b:String = "0";
        var bScale:int = 10;
        var c:String = "0E-10";
        var cScale:int = 10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.add(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Subtract two numbers of equal positive scales
     */
    public function testSubtractEqualScalePosPos():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 10;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 10;
        var c:String = "123121247898748224119637948679166971643339.7522230419";
        var cScale:int = 10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.subtract(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Subtract two numbers of equal positive scales using MathContext
     */
    public function testSubtractMathContextEqualScalePosPos():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 10;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 10;
        var c:String = "1.23121247898749E+41";
        var cScale:int = -27;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var mc:MathContext = new MathContext(15, false, MathContext.ROUND_CEILING);
        var result:BigDecimal = aNumber.subtract(bNumber, mc);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Subtract two numbers of equal negative scales
     */
    public function testSubtractEqualScaleNegNeg():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = -10;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = -10;
        var c:String = "1.231212478987482241196379486791669716433397522230419E+61";
        var cScale:int = -10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.subtract(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Subtract two numbers of different scales; the first is positive
     */
    public function testSubtractDiffScalePosNeg():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = -10;
        var c:String = "-7472334291698975400195996883915836900189542365.218615243205013";
        var cScale:int = 15;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.subtract(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    // todo results different
    // incorrect value - expected:<-7.4723342916989754E+45> but was:<-74.723342916989753E+44>
//    [Test]
//    /**
//     * Subtract two numbers of different scales using MathContext;
//     *  the first is positive
//     */
//    public function testSubtractMathContextDiffScalePosNeg():void
//    {
//        var a:String = "1231212478987482988429808779810457634781384756794987";
//        var aScale:int = 15;
//        var b:String = "747233429293018787918347987234564568";
//        var bScale:int = -10;
//        var c:String = "-7.4723342916989754E+45";
//        var cScale:int = -29;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var mc:MathContext = new MathContext(17, MathContext.NOTATION_PLAIN, false, MathContext.ROUND_DOWN);
//        var result:BigDecimal = aNumber.subtract(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", cScale, result.scale());
//    }

    [Test]
    /**
     * Subtract two numbers of different scales; the first is negative
     */
    public function testSubtractDiffScaleNegPos():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = -15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 10;
        var c:String = "1231212478987482988429808779810457634781310033452057698121208165201.2765435432";
        var cScale:int = 10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.subtract(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Subtract two numbers of different scales using MathContext;
     *  the first is negative
     */
    public function testSubtractMathContextDiffScaleNegPos():void
    {
        var a:String = "986798656676789766678767876078779810457634781384756794987";
        var aScale:int = -15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 40;
        var c:String = "9.867986566767897666787678760787798104576347813847567949870000000000000E+71";
        var cScale:int = -2;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var mc:MathContext = new MathContext(70, false, MathContext.ROUND_HALF_DOWN);
        var result:BigDecimal = aNumber.subtract(bNumber, mc);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Multiply two numbers of positive scales
     */
    public function testMultiplyScalePosPos():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 10;
        var c:String = "92000312286217574978643009574114545567010139156902666284589309.1880727173060570190220616";
        var cScale:int = 25;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.multiply(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Multiply two numbers of positive scales using MathContext
     */
    public function testMultiplyMathContextScalePosPos():void
    {
        var a:String = "97665696756578755423325476545428779810457634781384756794987";
        var aScale:int = -25;
        var b:String = "87656965586786097685674786576598865";
        var bScale:int = 10;
        var c:String = "8.561078619600910561431314228543672720908E+108";
        var cScale:int = -69;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var mc:MathContext = new MathContext(40, false, MathContext.ROUND_HALF_DOWN);
        var result:BigDecimal = aNumber.multiply(bNumber, mc);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Multiply two numbers of negative scales
     */
    public function testMultiplyEqualScaleNegNeg():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = -15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = -10;
        var c:String = "9.20003122862175749786430095741145455670101391569026662845893091880727173060570190220616E+111";
        var cScale:int = -25;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.multiply(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * Multiply two numbers of different scales
     */
    public function testMultiplyDiffScalePosNeg():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 10;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = -10;
        var c:String = "920003122862175749786430095741145455670101391569026662845893091880727173060570190220616";
        var cScale:int = 0;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.multiply(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    // todo results differnt
    // incorrect value - expected:<7.3801839465418518653942222612429081498248509257207477E+68> but was:<7.3801839465418518653942222612429081498248509257207476E+68>
//    [Test]
//    /**
//     * Multiply two numbers of different scales using MathContext
//     */
//    public function testMultiplyMathContextDiffScalePosNeg():void
//    {
//        var a:String = "987667796597975765768768767866756808779810457634781384756794987";
//        var aScale:int = 100;
//        var b:String = "747233429293018787918347987234564568";
//        var bScale:int = -70;
//        var c:String = "7.3801839465418518653942222612429081498248509257207477E+68";
//        var cScale:int = -16;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var mc:MathContext = new MathContext(53, MathContext.NOTATION_PLAIN, false, MathContext.ROUND_HALF_UP);
//        var result:BigDecimal = aNumber.multiply(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", cScale, result.scale());
//    }

    [Test]
    /**
     * Multiply two numbers of different scales
     */
    public function testMultiplyDiffScaleNegPos():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = -15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 10;
        var c:String = "9.20003122862175749786430095741145455670101391569026662845893091880727173060570190220616E+91";
        var cScale:int = -5;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        var result:BigDecimal = aNumber.multiply(bNumber);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    // todo results different
    // incorrect value - expected:<3.6521591193960361339707130098174381429788164316E+98> but was:<3.6521591193960361339707130098174381429788164315E+98>
//    [Test]
//    /**
//     * Multiply two numbers of different scales using MathContext
//     */
//    public function testMultiplyMathContextDiffScaleNegPos():void
//    {
//        var a:String = "488757458676796558668876576576579097029810457634781384756794987";
//        var aScale:int = -63;
//        var b:String = "747233429293018787918347987234564568";
//        var bScale:int = 63;
//        var c:String = "3.6521591193960361339707130098174381429788164316E+98";
//        var cScale:int = -52;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var mc:MathContext = new MathContext(47, MathContext.NOTATION_PLAIN, false, MathContext.ROUND_HALF_UP);
//        var result:BigDecimal = aNumber.multiply(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", cScale, result.scale());
//    }

    [Test]
    /**
     * pow(int)
     */
    public function testPow():void
    {
        var a:String = "123121247898748298842980";
        var aScale:int = 10;
        var exp:int = 10;
        var c:String = "8004424019039195734129783677098845174704975003788210729597" +
                "4875206425711159855030832837132149513512555214958035390490" +
                "798520842025826.594316163502809818340013610490541783276343" +
                "6514490899700151256484355936102754469438371850240000000000";
        var cScale:int = 100;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var result:BigDecimal = aNumber.pow(exp);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * pow(0)
     */
    public function testPow0():void
    {
        var a:String = "123121247898748298842980";
        var aScale:int = 10;
        var exp:int = 0;
        var c:String = "1";
        var cScale:int = 0;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var result:BigDecimal = aNumber.pow(exp);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    [Test]
    /**
     * ZERO.pow(0)
     */
    public function testZeroPow0():void
    {
        var c:String = "1";
        var cScale:int = 0;
        var result:BigDecimal = BigDecimal.ZERO.pow(0);
        assertEquals("incorrect value", c, result.toString());
        assertEquals("incorrect scale", cScale, result.scale());
    }

    // todo results different
    // incorrect value - expected:<8.0044E+130> but was:<8.0036E+130>
//    [Test]
//    /**
//     * pow(int, MathContext)
//     */
//    public function testPowMathContext():void
//    {
//        var a:String = "123121247898748298842980";
//        var aScale:int = 10;
//        var exp:int = 10;
//        var c:String = "8.0044E+130";
//        var cScale:int = -126;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var mc:MathContext = new MathContext(5, MathContext.NOTATION_PLAIN, false, MathContext.ROUND_HALF_UP);
//        var result:BigDecimal = aNumber.pow(exp, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", cScale, result.scale());
//    }

    [Test]
    /**
     * Divide by zero
     */
    public function testDivideByZero():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 15;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = new BigDecimal(0);
        try
        {
            aNumber.divide(bNumber);
            fail("ArithmeticException has not been caught");
        } catch (e:ArithmeticError)
        {
            assertEquals("Improper exception message", "Division by zero", e.message);
        }
    }

    [Test]
    /**
     * Divide with ROUND_UNNECESSARY
     */
    public function testDivideExceptionRM():void
    {
        var a:String = "1231212478987482988429808779810457634781384756794987";
        var aScale:int = 15;
        var b:String = "747233429293018787918347987234564568";
        var bScale:int = 10;
        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
        try
        {
            aNumber.divide(bNumber, MathContext.roundUnnecessary());
            fail("ArithmeticException has not been caught");
        } catch (e:ArithmeticError)
        {
            assertEquals("Improper exception message", "Rounding necessary", e.message);
        }
    }

//    [Test]
//    /**
//     * Divide with invalid rounding mode
//     */
//    public function testDivideExceptionInvalidRM():void {
//        var a:String = "1231212478987482988429808779810457634781384756794987";
//        var aScale:int = 15;
//        var b:String = "747233429293018787918347987234564568";
//        var bScale:int = 10;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        try {
//            aNumber.divide(bNumber, 100);
//            fail("IllegalArgumentException has not been caught");
//        } catch (e:Error) {
//            assertEquals("Improper exception message", "Invalid rounding mode", e.message);
//        }
//    }

    // todo
//    [Test]
//    /**
//     * Divide: local variable exponent is less than zero
//     */
//    public function testDivideExpLessZero():void {
//        var a:String = "1231212478987482988429808779810457634781384756794987";
//        var aScale:int = 15;
//        var b:String = "747233429293018787918347987234564568";
//        var bScale:int = 10;
//        var c:String = "1.64770E+10";
//        var resScale:int = -5;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, MathContext.ROUND_CEILING);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }

//    [Test]
//    /**
//     * Divide: local variable exponent is equal to zero
//     */
//    public function testDivideExpEqualsZero():void {
//        var a:String = "1231212478987482988429808779810457634781384756794987";
//        var aScale:int = -15;
//        var b:String = "747233429293018787918347987234564568";
//        var bScale:int = 10;
//        var c:String = "1.64769459009933764189139568605273529E+40";
//        var resScale:int = -5;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_CEILING);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }

//    [Test]
//    /**
//     * Divide: local variable exponent is greater than zero
//     */
//    public function testDivideExpGreaterZero():void {
//        var a:String = "1231212478987482988429808779810457634781384756794987";
//        var aScale:int = -15;
//        var b:String = "747233429293018787918347987234564568";
//        var bScale:int = 20;
//        var c:String = "1.647694590099337641891395686052735285121058381E+50";
//        var resScale:int = -5;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_CEILING);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }

//    [Test]
//    /**
//     * Divide: remainder is zero
//     */
//    public function testDivideRemainderIsZero():void {
//        var a:String = "8311389578904553209874735431110";
//        var aScale:int = -15;
//        var b:String = "237468273682987234567849583746";
//        var bScale:int = 20;
//        var c:String = "3.5000000000000000000000000000000E+36";
//        var resScale:int = -5;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_CEILING);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }

//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_UP, result is negative
//     */
//    public function testDivideRoundUpNeg():void {
//        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "-1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_UP);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_UP, result is positive
//     */
//    public function testDivideRoundUpPos():void {
//        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_UP);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_DOWN, result is negative
//     */
//    public function testDivideRoundDownNeg():void {
//        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "-1.24390557635720517122423359799283E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_DOWN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_DOWN, result is positive
//     */
//    public function testDivideRoundDownPos():void {
//        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "1.24390557635720517122423359799283E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_DOWN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_FLOOR, result is positive
//     */
//    public function testDivideRoundFloorPos():void {
//        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "1.24390557635720517122423359799283E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_FLOOR);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_FLOOR, result is negative
//     */
//    public function testDivideRoundFloorNeg():void {
//        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "-1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_FLOOR);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_CEILING, result is positive
//     */
//    public function testDivideRoundCeilingPos():void {
//        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_CEILING);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_CEILING, result is negative
//     */
//    public function testDivideRoundCeilingNeg():void {
//        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "-1.24390557635720517122423359799283E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_CEILING);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_HALF_UP, result is positive; distance = -1
//     */
//    public function testDivideRoundHalfUpPos():void {
//        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_UP);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_HALF_UP, result is negative; distance = -1
//     */
//    public function testDivideRoundHalfUpNeg():void {
//        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "-1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_UP);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//     * Divide: rounding mode is ROUND_HALF_UP, result is positive; distance = 1
//     */
//    public function testDivideRoundHalfUpPos1():void {
//        var a:String = "92948782094488478231212478987482988798104576347813847567949855464535634534563456";
//        var aScale:int = -24;
//        var b:String = "74723342238476237823754692930187879183479";
//        var bScale:int = 13;
//        var c:String = "1.2439055763572051712242335979928354832010167729111113605E+76";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_UP);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_UP, result is negative; distance = 1
//         */
//    public function testDivideRoundHalfUpNeg1():void {
//        var a:String = "-92948782094488478231212478987482988798104576347813847567949855464535634534563456";
//        var aScale:int = -24;
//        var b:String = "74723342238476237823754692930187879183479";
//        var bScale:int = 13;
//        var c:String = "-1.2439055763572051712242335979928354832010167729111113605E+76";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_UP);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_UP, result is negative; equidistant
//         */
//    public function testDivideRoundHalfUpNeg2():void {
//        var a:String = "-37361671119238118911893939591735";
//        var aScale:int = 10;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 15;
//        var c:String = "-1E+5";
//        var resScale:int = -5;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_UP);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_DOWN, result is positive; distance = -1
//         */
//    public function testDivideRoundHalfDownPos():void {
//        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_DOWN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_DOWN, result is negative; distance = -1
//         */
//    public function testDivideRoundHalfDownNeg():void {
//        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "-1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_DOWN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_DOWN, result is positive; distance = 1
//         */
//    public function testDivideRoundHalfDownPos1():void {
//        var a:String = "92948782094488478231212478987482988798104576347813847567949855464535634534563456";
//        var aScale:int = -24;
//        var b:String = "74723342238476237823754692930187879183479";
//        var bScale:int = 13;
//        var c:String = "1.2439055763572051712242335979928354832010167729111113605E+76";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_DOWN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_DOWN, result is negative; distance = 1
//         */
//    public function testDivideRoundHalfDownNeg1():void {
//        var a:String = "-92948782094488478231212478987482988798104576347813847567949855464535634534563456";
//        var aScale:int = -24;
//        var b:String = "74723342238476237823754692930187879183479";
//        var bScale:int = 13;
//        var c:String = "-1.2439055763572051712242335979928354832010167729111113605E+76";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_DOWN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_UP, result is negative; equidistant
//         */
//    public function testDivideRoundHalfDownNeg2():void {
//        var a:String = "-37361671119238118911893939591735";
//        var aScale:int = 10;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 15;
//        var c:String = "0E+5";
//        var resScale:int = -5;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_DOWN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**    /**
//         * Divide: rounding mode is ROUND_HALF_EVEN, result is positive; distance = -1
//         */
//    public function testDivideRoundHalfEvenPos():void {
//        var a:String = "92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_EVEN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_EVEN, result is negative; distance = -1
//         */
//    public function testDivideRoundHalfEvenNeg():void {
//        var a:String = "-92948782094488478231212478987482988429808779810457634781384756794987";
//        var aScale:int = -24;
//        var b:String = "7472334223847623782375469293018787918347987234564568";
//        var bScale:int = 13;
//        var c:String = "-1.24390557635720517122423359799284E+53";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_EVEN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_EVEN, result is positive; distance = 1
//         */
//    public function testDivideRoundHalfEvenPos1():void {
//        var a:String = "92948782094488478231212478987482988798104576347813847567949855464535634534563456";
//        var aScale:int = -24;
//        var b:String = "74723342238476237823754692930187879183479";
//        var bScale:int = 13;
//        var c:String = "1.2439055763572051712242335979928354832010167729111113605E+76";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_EVEN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_EVEN, result is negative; distance = 1
//         */
//    public function testDivideRoundHalfEvenNeg1():void {
//        var a:String = "-92948782094488478231212478987482988798104576347813847567949855464535634534563456";
//        var aScale:int = -24;
//        var b:String = "74723342238476237823754692930187879183479";
//        var bScale:int = 13;
//        var c:String = "-1.2439055763572051712242335979928354832010167729111113605E+76";
//        var resScale:int = -21;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_EVEN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide: rounding mode is ROUND_HALF_EVEN, result is negative; equidistant
//         */
//    public function testDivideRoundHalfEvenNeg2():void {
//        var a:String = "-37361671119238118911893939591735";
//        var aScale:int = 10;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 15;
//        var c:String = "0E+5";
//        var resScale:int = -5;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, resScale, BigDecimal.ROUND_HALF_EVEN);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }

//    [Test]
//    /**
//         * Divide to BigDecimal
//         */
//    public function testDivideBigDecimal1():void {
//        var a:String = "-37361671119238118911893939591735";
//        var aScale:int = 10;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 15;
//        var c:String = "-5E+4";
//        var resScale:int = -4;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * Divide to BigDecimal
//         */
//    public function testDivideBigDecimal2():void {
//        var a:String = "-37361671119238118911893939591735";
//        var aScale:int = 10;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = -15;
//        var c:String = "-5E-26";
//        var resScale:int = 26;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, scale, RoundingMode)
//         */
//    public function testDivideBigDecimalScaleRoundingModeUP():void {
//        var a:String = "-37361671119238118911893939591735";
//        var aScale:int = 10;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = -15;
//        var newScale:int = 31;
//        RoundingMode rm = RoundingMode.UP;
//        var c:String = "-5.00000E-26";
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, newScale, rm);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", newScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, scale, RoundingMode)
//         */
//    public function testDivideBigDecimalScaleRoundingModeDOWN():void {
//        var a:String = "-37361671119238118911893939591735";
//        var aScale:int = 10;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 15;
//        var newScale:int = 31;
//        RoundingMode rm = RoundingMode.DOWN;
//        var c:String = "-50000.0000000000000000000000000000000";
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, newScale, rm);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", newScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, scale, RoundingMode)
//         */
//    public function testDivideBigDecimalScaleRoundingModeCEILING():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 100;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 15;
//        var newScale:int = 45;
//        RoundingMode rm = RoundingMode.CEILING;
//        var c:String = "1E-45";
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, newScale, rm);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", newScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, scale, RoundingMode)
//         */
//    public function testDivideBigDecimalScaleRoundingModeFLOOR():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 100;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 15;
//        var newScale:int = 45;
//        RoundingMode rm = RoundingMode.FLOOR;
//        var c:String = "0E-45";
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, newScale, rm);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", newScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, scale, RoundingMode)
//         */
//    public function testDivideBigDecimalScaleRoundingModeHALF_UP():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = -51;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 45;
//        var newScale:int = 3;
//        RoundingMode rm = RoundingMode.HALF_UP;
//        var c:String = "50000260373164286401361913262100972218038099522752460421" +
//                "05959924024355721031761947728703598332749334086415670525" +
//                "3761096961.670";
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, newScale, rm);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", newScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, scale, RoundingMode)
//         */
//    public function testDivideBigDecimalScaleRoundingModeHALF_DOWN():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 5;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 15;
//        var newScale:int = 7;
//        RoundingMode rm = RoundingMode.HALF_DOWN;
//        var c:String = "500002603731642864013619132621009722.1803810";
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, newScale, rm);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", newScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, scale, RoundingMode)
//         */
//    public function testDivideBigDecimalScaleRoundingModeHALF_EVEN():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 5;
//        var b:String = "74723342238476237823787879183470";
//        var bScale:int = 15;
//        var newScale:int = 7;
//        RoundingMode rm = RoundingMode.HALF_EVEN;
//        var c:String = "500002603731642864013619132621009722.1803810";
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, newScale, rm);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", newScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, MathContext)
//         */
//    public function testDivideBigDecimalScaleMathContextUP():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 15;
//        var b:String = "748766876876723342238476237823787879183470";
//        var bScale:int = 10;
//        var precision:int = 21;
//        RoundingMode rm = RoundingMode.UP;
//        MathContext mc = new MathContext(precision, rm);
//        var c:String = "49897861180.2562512996";
//        var resScale:int = 10;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, MathContext)
//         */
//    public function testDivideBigDecimalScaleMathContextDOWN():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 15;
//        var b:String = "748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var precision:int = 21;
//        RoundingMode rm = RoundingMode.DOWN;
//        MathContext mc = new MathContext(precision, rm);
//        var c:String = "4.98978611802562512995E+70";
//        var resScale:int = -50;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, MathContext)
//         */
//    public function testDivideBigDecimalScaleMathContextCEILING():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 15;
//        var b:String = "748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var precision:int = 21;
//        RoundingMode rm = RoundingMode.CEILING;
//        MathContext mc = new MathContext(precision, rm);
//        var c:String = "4.98978611802562512996E+70";
//        var resScale:int = -50;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, MathContext)
//         */
//    public function testDivideBigDecimalScaleMathContextFLOOR():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 15;
//        var b:String = "748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var precision:int = 21;
//        RoundingMode rm = RoundingMode.FLOOR;
//        MathContext mc = new MathContext(precision, rm);
//        var c:String = "4.98978611802562512995E+70";
//        var resScale:int = -50;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, MathContext)
//         */
//    public function testDivideBigDecimalScaleMathContextHALF_UP():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var precision:int = 21;
//        RoundingMode rm = RoundingMode.HALF_UP;
//        MathContext mc = new MathContext(precision, rm);
//        var c:String = "2.77923185514690367475E+26";
//        var resScale:int = -6;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, MathContext)
//         */
//    public function testDivideBigDecimalScaleMathContextHALF_DOWN():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var precision:int = 21;
//        RoundingMode rm = RoundingMode.HALF_DOWN;
//        MathContext mc = new MathContext(precision, rm);
//        var c:String = "2.77923185514690367475E+26";
//        var resScale:int = -6;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divide(BigDecimal, MathContext)
//         */
//    public function testDivideBigDecimalScaleMathContextHALF_EVEN():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var precision:int = 21;
//        RoundingMode rm = RoundingMode.HALF_EVEN;
//        MathContext mc = new MathContext(precision, rm);
//        var c:String = "2.77923185514690367475E+26";
//        var resScale:int = -6;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divide(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//
//    [Test]
//    /**
//         * BigDecimal.divide with a scale that's too large
//         *
//         * Regression test for HARMONY-6271
//         */
//    public function testDivideLargeScale():void {
//        var arg:BigDecimal1 = new BigDecimal("320.0E+2147483647");
//        var arg:BigDecimal2 = new BigDecimal("6E-2147483647");
//        try {
//            var result:BigDecimal = arg1.divide(arg2, Integer.MAX_VALUE,
//                    RoundingMode.CEILING);
//            fail("Expected ArithmeticException when dividing with a scale that's too large");
//        } catch (e:ArithmeticError) {
//            // expected behaviour
//        }
//    }
//
//    [Test]
//    /**
//         * divideToIntegralValue(BigDecimal)
//         */
//    public function testDivideToIntegralValue():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var c:String = "277923185514690367474770683";
//        var resScale:int = 0;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divideToIntegralValue(bNumber);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divideToIntegralValue(BigDecimal, MathContext)
//         */
//    public function testDivideToIntegralValueMathContextUP():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var precision:int = 32;
//        RoundingMode rm = RoundingMode.UP;
//        MathContext mc = new MathContext(precision, rm);
//        var c:String = "277923185514690367474770683";
//        var resScale:int = 0;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divideToIntegralValue(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divideToIntegralValue(BigDecimal, MathContext)
//         */
//    public function testDivideToIntegralValueMathContextDOWN():void {
//        var a:String = "3736186567876876578956958769675785435673453453653543654354365435675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var precision:int = 75;
//        RoundingMode rm = RoundingMode.DOWN;
//        MathContext mc = new MathContext(precision, rm);
//        var c:String = "2.7792318551469036747477068339450205874992634417590178670822889E+62";
//        var resScale:int = -1;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.divideToIntegralValue(bNumber, mc);
//        assertEquals("incorrect value", c, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * divideAndRemainder(BigDecimal)
//         */
//    public function testDivideAndRemainder1():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var r:Stringes = "277923185514690367474770683";
//        var resScale:int = 0;
//        var r:Stringem = "1.3032693871288309587558885943391070087960319452465789990E-15";
//        var remScale:int = 70;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal[] = aNumber.divideAndRemainder(bNumber);
//        assertEquals("incorrect quotient value", res, result[0].toString());
//        assertEquals("incorrect quotient scale", resScale, result[0].scale());
//        assertEquals("incorrect remainder value", rem, result[1].toString());
//        assertEquals("incorrect remainder scale", remScale, result[1].scale());
//    }
//
//    [Test]
//    /**
//         * divideAndRemainder(BigDecimal)
//         */
//    public function testDivideAndRemainder2():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = -45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var r:Stringes = "2779231855146903674747706830969461168692256919247547952" +
//                "2608549363170374005512836303475980101168105698072946555" +
//                "6862849";
//        var resScale:int = 0;
//        var r:Stringem = "3.4935796954060524114470681810486417234751682675102093970E-15";
//        var remScale:int = 70;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal[] = aNumber.divideAndRemainder(bNumber);
//        assertEquals("incorrect quotient value", res, result[0].toString());
//        assertEquals("incorrect quotient scale", resScale, result[0].scale());
//        assertEquals("incorrect remainder value", rem, result[1].toString());
//        assertEquals("incorrect remainder scale", remScale, result[1].scale());
//    }
//
//    [Test]
//    /**
//         * divideAndRemainder(BigDecimal, MathContext)
//         */
//    public function testDivideAndRemainderMathContextUP():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 70;
//        var precision:int = 75;
//        RoundingMode rm = RoundingMode.UP;
//        MathContext mc = new MathContext(precision, rm);
//        var r:Stringes = "277923185514690367474770683";
//        var resScale:int = 0;
//        var r:Stringem = "1.3032693871288309587558885943391070087960319452465789990E-15";
//        var remScale:int = 70;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal[] = aNumber.divideAndRemainder(bNumber, mc);
//        assertEquals("incorrect quotient value", res, result[0].toString());
//        assertEquals("incorrect quotient scale", resScale, result[0].scale());
//        assertEquals("incorrect remainder value", rem, result[1].toString());
//        assertEquals("incorrect remainder scale", remScale, result[1].scale());
//    }
//
//    [Test]
//    /**
//         * divideAndRemainder(BigDecimal, MathContext)
//         */
//    public function testDivideAndRemainderMathContextDOWN():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 20;
//        var precision:int = 15;
//        RoundingMode rm = RoundingMode.DOWN;
//        MathContext mc = new MathContext(precision, rm);
//        var r:Stringes = "0E-25";
//        var resScale:int = 25;
//        var r:Stringem = "3736186567876.876578956958765675671119238118911893939591735";
//        var remScale:int = 45;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal[] = aNumber.divideAndRemainder(bNumber, mc);
//        assertEquals("incorrect quotient value", res, result[0].toString());
//        assertEquals("incorrect quotient scale", resScale, result[0].scale());
//        assertEquals("incorrect remainder value", rem, result[1].toString());
//        assertEquals("incorrect remainder scale", remScale, result[1].scale());
//    }
//
//    [Test]
//    /**
//         * remainder(BigDecimal)
//         */
//    public function testRemainder1():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 10;
//        var r:Stringes = "3736186567876.876578956958765675671119238118911893939591735";
//        var resScale:int = 45;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.remainder(bNumber);
//        assertEquals("incorrect quotient value", res, result.toString());
//        assertEquals("incorrect quotient scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * remainder(BigDecimal)
//         */
//    public function testRemainder2():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = -45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 10;
//        var r:Stringes = "1149310942946292909508821656680979993738625937.2065885780";
//        var resScale:int = 10;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.remainder(bNumber);
//        assertEquals("incorrect quotient value", res, result.toString());
//        assertEquals("incorrect quotient scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * remainder(BigDecimal, MathContext)
//         */
//    public function testRemainderMathContextHALF_UP():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 10;
//        var precision:int = 15;
//        RoundingMode rm = RoundingMode.HALF_UP;
//        MathContext mc = new MathContext(precision, rm);
//        var r:Stringes = "3736186567876.876578956958765675671119238118911893939591735";
//        var resScale:int = 45;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.remainder(bNumber, mc);
//        assertEquals("incorrect quotient value", res, result.toString());
//        assertEquals("incorrect quotient scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * remainder(BigDecimal, MathContext)
//         */
//    public function testRemainderMathContextHALF_DOWN():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = -45;
//        var b:String = "134432345432345748766876876723342238476237823787879183470";
//        var bScale:int = 10;
//        var precision:int = 75;
//        RoundingMode rm = RoundingMode.HALF_DOWN;
//        MathContext mc = new MathContext(precision, rm);
//        var r:Stringes = "1149310942946292909508821656680979993738625937.2065885780";
//        var resScale:int = 10;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var bNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(b, bScale);
//        var result:BigDecimal = aNumber.remainder(bNumber, mc);
//        assertEquals("incorrect quotient value", res, result.toString());
//        assertEquals("incorrect quotient scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * round(BigDecimal, MathContext)
//         */
//    public function testRoundMathContextHALF_DOWN():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = -45;
//        var precision:int = 75;
//        RoundingMode rm = RoundingMode.HALF_DOWN;
//        MathContext mc = new MathContext(precision, rm);
//        var r:Stringes = "3.736186567876876578956958765675671119238118911893939591735E+102";
//        var resScale:int = -45;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var result:BigDecimal = aNumber.round(mc);
//        assertEquals("incorrect quotient value", res, result.toString());
//        assertEquals("incorrect quotient scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * round(BigDecimal, MathContext)
//         */
//    public function testRoundMathContextHALF_UP():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var precision:int = 15;
//        RoundingMode rm = RoundingMode.HALF_UP;
//        MathContext mc = new MathContext(precision, rm);
//        var r:Stringes = "3736186567876.88";
//        var resScale:int = 2;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var result:BigDecimal = aNumber.round(mc);
//        assertEquals("incorrect quotient value", res, result.toString());
//        assertEquals("incorrect quotient scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * round(BigDecimal, MathContext) when precision = 0
//         */
//    public function testRoundMathContextPrecision0():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var precision:int = 0;
//        RoundingMode rm = RoundingMode.HALF_UP;
//        MathContext mc = new MathContext(precision, rm);
//        var r:Stringes = "3736186567876.876578956958765675671119238118911893939591735";
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var result:BigDecimal = aNumber.round(mc);
//        assertEquals("incorrect quotient value", res, result.toString());
//        assertEquals("incorrect quotient scale", aScale, result.scale());
//    }
//
//
//    [Test]
//    /**
//         * ulp() of a positive BigDecimal
//         */
//    public function testUlpPos():void {
//        var a:String = "3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = -45;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var result:BigDecimal = aNumber.ulp();
//        var r:Stringes = "1E+45";
//        var resScale:int = -45;
//        assertEquals("incorrect value", res, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * ulp() of a negative BigDecimal
//         */
//    public function testUlpNeg():void {
//        var a:String = "-3736186567876876578956958765675671119238118911893939591735";
//        var aScale:int = 45;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var result:BigDecimal = aNumber.ulp();
//        var r:Stringes = "1E-45";
//        var resScale:int = 45;
//        assertEquals("incorrect value", res, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
//
//    [Test]
//    /**
//         * ulp() of a negative BigDecimal
//         */
//    public function testUlpZero():void {
//        var a:String = "0";
//        var aScale:int = 2;
//        var aNumber:BigDecimal = BigDecimal.createFromUnscaledInteger(a, aScale);
//        var result:BigDecimal = aNumber.ulp();
//        var r:Stringes = "0.01";
//        var resScale:int = 2;
//        assertEquals("incorrect value", res, result.toString());
//        assertEquals("incorrect scale", resScale, result.scale());
//    }
}
}
