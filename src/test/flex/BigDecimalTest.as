package
{
import flash.utils.ByteArray;
import flash.utils.IExternalizable;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;
import org.flexunit.asserts.fail;

public class BigDecimalTest
{
    [Test]
    public function constructor():void
    {
        var r:BigDecimal = new BigDecimal("-35453");
        assertEquals("-35453", r.toString());

        r = new BigDecimal("0.0000023423481");
        assertEquals("0.0000023423481", r.toString());

        r = new BigDecimal(53049580);
        assertEquals("53049580", r.toString());

        r = new BigDecimal(-423);
        assertEquals("-423", r.toString());

        try
        {
            new BigDecimal(null);
            fail("No ArgumentError");
        }
        catch (e:ArgumentError)
        {
        }

        try
        {
            new BigDecimal({not_valid:true});
            fail("No ArgumentError");
        }
        catch (e:ArgumentError)
        {
        }

        try
        {
            new BigDecimal("0", 0, -9);
            fail("No ArgumentError");
        }
        catch (e:ArgumentError)
        {
            assertEquals("Invalid offset/length: 0/-9 for string: 0", e.message);
        }
    }

    [Test]
    public function constructorExponentBoundaries():void
    {
        // Note: not quite the same as Java's which has different error messages
        // and doesn't like -ve exponents <= -2147483647
        var a:BigDecimal = new BigDecimal("1.0e2147483647");
        assertEquals("1.0E+2147483647", a.toString());

        try
        {
            new BigDecimal("1.0e2147483648");
            fail("Should throw NumberFormatException");
        }
        catch (e:ArgumentError)
        {
            assertEquals("Exponent too large: 1.0e2147483648", e.message);
        }

        a = new BigDecimal("1.0e-2147483646");
        assertEquals("1.0E-2147483646", a.toString());

        a = new BigDecimal("1.0e-2147483647");
        assertEquals("1.0E-2147483647", a.toString());

        try
        {
            new BigDecimal("1.0e-2147483648");
            fail("Should throw NumberFormatException");
        }
        catch (e:ArgumentError)
        {
            assertEquals("Exponent too large: 1.0e-2147483648", e.message);
        }

        try
        {
            new BigDecimal("1.0e-2147483649");
            fail("Should throw NumberFormatException");
        }
        catch (e:ArgumentError)
        {
            assertEquals("Exponent too large: 1.0e-2147483649", e.message);
        }
    }

    [Test]
    public function createFromUnscaledIntInvalidParams():void
    {
        // Most invalid string inputs handled mostly by constructor, so only bare minimum here
        try
        {
            BigDecimal.createFromUnscaledInteger(null, 0);
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            // pass
        }

        try
        {
            BigDecimal.createFromUnscaledInteger("234e3gh", 0);
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            // pass
        }

        // Specific to this method
        try
        {
            BigDecimal.createFromUnscaledInteger("1.234", 5);
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            assertEquals("The unscaledValue already has a scale: 1.234", e.message);
        }
    }

    [Test]
    public function toPlainStringDoesNotIncludeZeroPaddingWhenNumberZero():void
    {
        var a:BigDecimal = new BigDecimal("0.0e3");
        assertEquals(-2, a.scale());
        assertEquals("0E+2", a.toString());
        assertEquals("0", a.toPlainString());

        var b:BigDecimal = new BigDecimal("000");
        assertEquals(0, b.scale());
        assertEquals("0", b.toString());
        assertEquals("0", b.toPlainString());
    }

    [Test]
    public function add():void
    {
        var a:BigDecimal = new BigDecimal("555.50");
        var b:BigDecimal = new BigDecimal("45.55");

        total = a.add(b);
        assertEquals("601.05", total.toString());

        var c:BigDecimal = new BigDecimal("0.15015");
        var d:BigDecimal = new BigDecimal("0.34567");
        var e:BigDecimal = new BigDecimal("0.26897");

        var total:BigDecimal = c.add(d).add(e);

        assertEquals(0.76479, total.numberValue());
        total = total.setScale(3, MathContext.ROUND_HALF_UP);
        assertEquals(0.765, total.numberValue());
    }

    [Test]
    public function addWithContext():void
    {
        var a:BigDecimal = new BigDecimal("12333454e45");
        var b:BigDecimal = new BigDecimal("123e460");
        var mc:MathContext = new MathContext(100);
        var total:BigDecimal = a.add(b, mc);
        assertEquals("1.230000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E+462", total.toString());
    }

    [Test]
    public function addToZero():void
    {
        var a:BigDecimal = new BigDecimal("10.4");

        var r:BigDecimal = BigDecimal.ZERO.add(a);
        assertEquals("10.4", r.toPlainString());

        r = a.add(BigDecimal.ZERO);
        assertEquals("10.4", r.toPlainString());
    }

    [Test]
    public function subtract():void
    {
        var a:BigDecimal = new BigDecimal("555.50");
        var b:BigDecimal = new BigDecimal("45.55");

        var total:BigDecimal = a.subtract(b);
        assertEquals("509.95", total.toString());

        var c:BigDecimal = new BigDecimal("0.15015");
        var d:BigDecimal = new BigDecimal("0.34567");
        var e:BigDecimal = new BigDecimal("0.26897");

        total = c.subtract(d).subtract(e);

        assertEquals(-0.46449, total.numberValue());
    }

    [Test]
    public function multiply():void
    {
        var a:BigDecimal = new BigDecimal("555.50");
        var b:BigDecimal = new BigDecimal("45.55");

        var total:BigDecimal = a.multiply(b);
        assertEquals("25303.0250", total.toString());

        var c:BigDecimal = new BigDecimal("0.15015");
        var d:BigDecimal = new BigDecimal("0.34567");
        var e:BigDecimal = new BigDecimal("0.26897");


        total = c.multiply(d).multiply(e);

        var number:Number = total.numberValue();
        assertEquals(0.013960175213985, number);

        //Test envoyes par NDiaga
        number = new BigDecimal("2.3").multiply(new BigDecimal("0.95")).numberValue();
        assertEquals(2.185, number);
        number = new BigDecimal("2.3").multiply(new BigDecimal("0.18")).numberValue();
        assertEquals(0.414, number);
        number = new BigDecimal("2.3").multiply(new BigDecimal("0.21")).numberValue();
        assertEquals(0.483, number);
        number = new BigDecimal("2.3").multiply(new BigDecimal("0.24")).numberValue();
        assertEquals(0.552, number);
        number = new BigDecimal("2.3").multiply(new BigDecimal("0.29")).numberValue();
        assertEquals(0.667, number);
        number = new BigDecimal("75").multiply(new BigDecimal("95")).numberValue();
        assertEquals(7125, number);

        //Tests envoyes par Simon
        number = new BigDecimal("8490.675").multiply(new BigDecimal("100")).numberValue();
        assertEquals(849067.5, number);
    }

    [Test]
    public function divide():void
    {
        var a:BigDecimal = new BigDecimal(555.50).setScale(10);
        var b:BigDecimal = new BigDecimal("45.55");

        var total:BigDecimal = a.divide(b);

        assertEquals("12.1953896817", total.toString());

        var c:BigDecimal = new BigDecimal("0.15015");
        c = c.setScale(31);
        var d:BigDecimal = new BigDecimal("0.34567");
        var e:BigDecimal = new BigDecimal("0.26897");

        total = c.divide(d).divide(e);

        assertEquals("1.6149526889472623986174998258858", total.toString());
    }

    [Test]
    public function divideInteger():void
    {
        var c:BigDecimal = new BigDecimal("23").divideInteger(new BigDecimal("12"));
        assertEquals("1", c.toString());
    }

    [Test]
    public function divideRound():void
    {
        var c:BigDecimal = new BigDecimal("23").divideRound(new BigDecimal("12"), MathContext.ROUND_HALF_UP);
        assertEquals("2", c.toString());
    }

    [Test]
    public function divideScaleRound():void
    {
        var a:BigDecimal = new BigDecimal("9.999999999999");
        var b:BigDecimal = new BigDecimal("3");

        var r:BigDecimal = a.divideScaleRound(b, 3, MathContext.ROUND_DOWN);
        assertEquals("3.333", r.toString());

        r = a.divideScaleRound(b, 3, MathContext.ROUND_UP);
        assertEquals("3.334", r.toString());
    }

    [Test]
    public function remainder():void
    {
        var c:BigDecimal = new BigDecimal("23").remainder(new BigDecimal("12"));
        assertEquals("11", c.toString());
    }

    [Test]
    public function signum():void
    {
        assertEquals(0, new BigDecimal("0").signum());
        assertEquals(0, new BigDecimal("0").abs().signum());

        assertEquals(-1, new BigDecimal("-32.345").signum());
        assertEquals(1, new BigDecimal("-32.345").abs().signum());
//        assertEquals(1, new BigDecimal("-32.345").plus().signum());

        assertEquals(-1, new BigDecimal("32.345").negate().signum());
    }

    [Test]
    public function abs():void
    {
        var a:BigDecimal = new BigDecimal("-555.567");
        a = a.abs();
        assertEquals("555.567", a.toString());
    }

    [Test]
    public function plus():void
    {
        var a:BigDecimal = new BigDecimal("45.3234");
        assertEquals(a.toString(), a.plus().toString());

//        a = new BigDecimal("-42342.994");
//        a = a.plus();
//        assertEquals("42342.994", a.toString());
    }

    [Test]
    public function negate():void
    {
        var a:BigDecimal = new BigDecimal("45.3234");

        a = a.negate();
        assertEquals("-45.3234", a.toString());

        a = a.negate();
        assertEquals("45.3234", a.toString());
    }

    [Test]
    public function pow():void
    {
        var a:BigDecimal = new BigDecimal("-55.50");

        var total:BigDecimal = a.pow(3);
        assertEquals("-170953.875000", total.toString());

        try
        {
            a.pow(-3);
            fail("Should throw ArithmeticError");
        }
        catch (e:ArithmeticError)
        {
            assertEquals("Wrong error message", "Invalid Operation", e.message);
        }

        a = new BigDecimal("213.3420000");
        var mc:MathContext = new MathContext(1, false, MathContext.ROUND_DOWN);
        var b:BigDecimal = a.pow(2, mc);

        assertEquals("4E+4", b.toString());
    }

    [Test]
    public function roundEquals():void
    {
        var bd:BigDecimal = (new BigDecimal(5.5)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(6)));
        bd = (new BigDecimal(2.5)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(3)));
        bd = (new BigDecimal(1.6)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(2)));
        bd = (new BigDecimal(1.1)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(1)));
        bd = (new BigDecimal(1.0)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(1)));
        bd = (new BigDecimal(-1.0)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(-1)));
        bd = (new BigDecimal(-1.1)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(-1)));
        bd = (new BigDecimal(-1.6)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(-2)));
        bd = (new BigDecimal(-2.5)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(-3)));
        bd = (new BigDecimal(-5.5)).setScale(0, MathContext.ROUND_HALF_UP);
        assertTrue(bd.equals(new BigDecimal(-6)));
    }

    [Test]
    public function compareTo():void
    {
        assertEquals(0, new BigDecimal("1").compareTo(new BigDecimal("1")));
        assertEquals(0, new BigDecimal("1").compareTo(new BigDecimal("1.0")));
        assertEquals(0, new BigDecimal("1").compareTo(new BigDecimal("1.0E0")));
        assertEquals(-1, new BigDecimal("0.9").compareTo(new BigDecimal("1")));
        assertEquals(1, new BigDecimal("9").compareTo(new BigDecimal("0.E+11")));
        assertEquals(0, new BigDecimal("1234567890000000000000000").compareTo(new BigDecimal("1234567890.0e+15")));
    }

    [Test]
    public function equals():void
    {
        assertTrue(new BigDecimal("1").equals(new BigDecimal("1")));
        assertFalse(new BigDecimal("1").equals(new BigDecimal("1.0")));
        assertFalse(new BigDecimal("1").equals(new BigDecimal("1.000000")));
        assertFalse(new BigDecimal("1").equals(new BigDecimal("-1")));
        assertFalse(new BigDecimal("1").equals(new BigDecimal("-1")));
        assertFalse(new BigDecimal("0.9").equals(new BigDecimal("1")));
        assertTrue(new BigDecimal(".5").equals(new BigDecimal("0.5")));
        assertFalse(new BigDecimal("123456").equals(new BigDecimal("123457")));
    }

    [Test]
    public function scale():void
    {
        var a:BigDecimal = new BigDecimal("12.34");
        assertEquals(2, a.scale());

        a = new BigDecimal("-12.34");
        assertEquals(2, a.scale());

        a = new BigDecimal("12.345000");
        assertEquals(6, a.scale());

        a = new BigDecimal("1e5");
        assertEquals(-5, a.scale());

        a = new BigDecimal("1e-5");
        assertEquals(5, a.scale());

        a = new BigDecimal("905835.90345345E450");
        assertEquals(-442, a.scale());

        a = new BigDecimal("-905835.90345345E450");
        assertEquals(-442, a.scale());

        a = new BigDecimal("905835.90345345E-450");
        assertEquals(458, a.scale());

        a = new BigDecimal("-905835.90345345E-450");
        assertEquals(458, a.scale());
    }

    [Test]
    public function intValueExact():void
    {
        assertEquals(3341, new BigDecimal("3341").intValueExact());

        try
        {
            new BigDecimal("3341.00001").intValueExact();
            fail("Should throw Error");
        }
        catch (e:Error)
        {
            // ok
        }
    }

    [Test]
    public function max():void
    {
        var r:BigDecimal = new BigDecimal("100").max(new BigDecimal("200"));
        assertEquals("200", r.toString());

        r = new BigDecimal("-0.001").max(new BigDecimal("0.001"));
        assertEquals("0.001", r.toString());
    }

    [Test]
    public function min():void
    {
        var r:BigDecimal = new BigDecimal("100").min(new BigDecimal("200"));
        assertEquals("100", r.toString());

        r = new BigDecimal("-0.001").min(new BigDecimal("0.001"));
        assertEquals("-0.001", r.toString());
    }

    [Test]
    public function movePointLeft():void
    {
        var d:BigDecimal = new BigDecimal("43.234");

        var r:BigDecimal = d.movePointLeft(3);
        assertEquals("0.043234", r.toString());

        r = d.movePointLeft(-5);
        assertEquals("4323400", r.toString());
    }

    [Test]
    public function movePointRight():void
    {
        var d:BigDecimal = new BigDecimal("43.234");
        assertEquals("43234", d.movePointRight(3).toString());
        assertEquals("0.00043234", d.movePointRight(-5).toString());
    }

    [Test]
    public function strings():void
    {
        assertEquals("0", new BigDecimal("0").toString());
        assertEquals("-54", new BigDecimal("-54").toString());
        assertEquals("20.765", new BigDecimal("20.765").toString());
        assertEquals("0.003", new BigDecimal("+0.003").toString());
        assertEquals("0.89", new BigDecimal(".89").toString());
        assertEquals("7", new BigDecimal("7.").toString());
        assertEquals("1.234E+10", new BigDecimal("1.234E10").toString());
        assertEquals("1.234E-10", new BigDecimal("1.234e-10").toString());
        assertEquals("4535.4358051100394809", new BigDecimal("4535.4358051100394809").toString());
        assertEquals("2147483647", new BigDecimal("2147483647").toString()); // int.MAX_VALUE;
        assertEquals("-2147483648", new BigDecimal("-2147483648").toString()); // int.MIN_VALUE;
        assertEquals("2147483648", new BigDecimal("2147483648").toString()); // int.MAX_VALUE + 1;
        assertEquals("-2147483649", new BigDecimal("-2147483649").toString()); // int.MIN_VALUE - 1;
    }

    [Test]
    public function numberValue():void
    {
        var v:BigDecimal = new BigDecimal("1.234E10");
        assertEquals("1.234E+10", v.toString());

        var n:Number = v.numberValue();
        assertEquals(12340000000, n);
    }

    [Test]
    public function implementsIExternalizable():void
    {
        var a:IExternalizable = new BigDecimal("5353.2465464");
        var bs:ByteArray = new ByteArray();
        a.writeExternal(bs);
        bs.position = 0; // reset for read
        var b:IExternalizable = new BigDecimal();
        b.readExternal(bs);
        assertEquals("5353.2465464", String(b));
    }
}
}
