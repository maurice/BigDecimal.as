package
{
import avmplus.factoryXml;

import flashx.textLayout.debug.assert;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;
import org.flexunit.asserts.fail;

public class BigDecimalTest
{
    [Test]
    public function add():void
    {
        var a:BigDecimal = new BigDecimal("555.50");
        var b:BigDecimal = new BigDecimal("45.55");

        total = a.add(b);

        var string:String = total.toString();
        assertTrue(string == "601.05");

        var c:BigDecimal = new BigDecimal("0.15015");
        var d:BigDecimal = new BigDecimal("0.34567");
        var e:BigDecimal = new BigDecimal("0.26897");

        var total:BigDecimal = c.add(d).add(e);

        assertEquals(0.76479, total.numberValue());
        total = total.setScale(3, MathContext.ROUND_HALF_UP);

        assertEquals(0.765, total.numberValue());
    }

    [Test]
    public function subtract():void
    {
        var a:BigDecimal = new BigDecimal("555.50");
        var b:BigDecimal = new BigDecimal("45.55");

        var total:BigDecimal = a.subtract(b);

        var string:String = total.toString();
        assertTrue(string == "509.95");

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

        var string:String = total.toString();
        assertTrue(string == "25303.0250");

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
        var a:BigDecimal = new BigDecimal(555.50);
        var b:BigDecimal = new BigDecimal("45.55");

        var total:BigDecimal = a.divide(b);

        var string:String = total.toString();
        assertTrue(string == "12.1953896817");

        var c:BigDecimal = new BigDecimal("0.15015");
        c = c.setScale(31);
        var d:BigDecimal = new BigDecimal("0.34567");
        var e:BigDecimal = new BigDecimal("0.26897");

        total = c.divide(d).divide(e);
        string = total.toString();

        assertEquals(string, "1.6149526889472623986174998258858");
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
        var string:String = a.toString();
        assertTrue(string == "555.567");
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
        var b:BigDecimal = new BigDecimal("3");

        var total:BigDecimal = a.pow(b);

        var string:String = total.toString();
        assertTrue(string == "-170953.875000");

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
        assertFalse(new BigDecimal("1").equals(new BigDecimal("-1")));
        assertFalse(new BigDecimal("1").equals(new BigDecimal("-1")));
        assertFalse(new BigDecimal("0.9").equals(new BigDecimal("1")));
        assertTrue(new BigDecimal(".5").equals(new BigDecimal("0.5")));
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
        assertEquals("0.043234", d.movePointLeft(3).toString());
        assertEquals("4323400", d.movePointLeft(-5).toString());
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
    }
}


}
