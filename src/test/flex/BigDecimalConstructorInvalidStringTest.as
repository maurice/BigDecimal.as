package
{
import org.flexunit.asserts.fail;

public class BigDecimalConstructorInvalidStringTest
{
    [Test]
    public function emptyString():void
    {
        try
        {
            new BigDecimal("");
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            // pass
        }
    }

    [Test]
    public function signOnly():void
    {
        try
        {
            new BigDecimal("+");
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            // pass
        }

        try
        {
            new BigDecimal("-");
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            // pass
        }
    }

    [Test]
    public function extraDots():void
    {
        const strs:Array = [
            "..",
            ".1.",
            "1..",
            "0.1.",
            "..1",
            "00.1.001"
        ];
        for each (var str:String in strs)
        {
            try
            {
                new BigDecimal(str);
                fail("Should throw ArgumentError");
            }
            catch (e:ArgumentError)
            {
                // pass
            }
        }
    }

    [Test]
    public function junkAfterExponent():void
    {
        try
        {
            new BigDecimal("34.4534e54x");
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            // pass
        }

        try
        {
            new BigDecimal("1242321E-th");
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            // pass
        }

        try
        {
            new BigDecimal("1242321E- ");
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            // pass
        }
    }

    [Test]
    public function noDigits():void
    {
        try
        {
            new BigDecimal("-.");
            fail("Should throw ArgumentError");
        }
        catch (e:ArgumentError)
        {
            // pass
        }
    }
}
}
