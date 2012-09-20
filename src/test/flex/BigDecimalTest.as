package
{
    import org.flexunit.Assert;

    public class BigDecimalTest
    {
        [Test]
        public function testSomme():void
        {
            var chiffre1:BigDecimal = new BigDecimal("555.50");
            var chiffre2:BigDecimal = new BigDecimal("45.55");

            total = chiffre1.add(chiffre2);

            var string:String = total.toString();
            Assert.assertTrue(string == "601.05");

            var aClass1:BigDecimal = new BigDecimal("0.15015");
            var aClass2:BigDecimal = new BigDecimal("0.34567");
            var aClass3:BigDecimal = new BigDecimal("0.26897");

            var total:BigDecimal = aClass1.add(aClass2).add(aClass3);

            Assert.assertEquals(0.76479, total.numberValue());
            total = total.setScale(3, MathContext.ROUND_HALF_UP);

            Assert.assertEquals(0.765, total.numberValue());
        }

        [Test]
        public function testSubstract():void
        {
            var chiffre1:BigDecimal = new BigDecimal("555.50");
            var chiffre2:BigDecimal = new BigDecimal("45.55");

            var total:BigDecimal = chiffre1.subtract(chiffre2);

            var string:String = total.toString();
            Assert.assertTrue(string == "509.95");

            var aClass1:BigDecimal = new BigDecimal("0.15015");
            var aClass2:BigDecimal = new BigDecimal("0.34567");
            var aClass3:BigDecimal = new BigDecimal("0.26897");

            total = aClass1.subtract(aClass2).subtract(aClass3);

            Assert.assertEquals(-0.46449, total.numberValue());
        }

        [Test]
        public function testMultiply():void
        {
            var chiffre1:BigDecimal = new BigDecimal("555.50");
            var chiffre2:BigDecimal = new BigDecimal("45.55");

            var total:BigDecimal = chiffre1.multiply(chiffre2);

            var string:String = total.toString();
            Assert.assertTrue(string == "25303.0250");

            var aClass1:BigDecimal = new BigDecimal("0.15015");
            var aClass2:BigDecimal = new BigDecimal("0.34567");
            var aClass3:BigDecimal = new BigDecimal("0.26897");


            total = aClass1.multiply(aClass2).multiply(aClass3);

            var number:Number = total.numberValue();
            Assert.assertEquals(0.013960175213985, number);

            //Test envoyes par NDiaga
            number = new BigDecimal("2.3").multiply(new BigDecimal("0.95")).numberValue();
            Assert.assertEquals(2.185, number);
            number = new BigDecimal("2.3").multiply(new BigDecimal("0.18")).numberValue();
            Assert.assertEquals(0.414, number);
            number = new BigDecimal("2.3").multiply(new BigDecimal("0.21")).numberValue();
            Assert.assertEquals(0.483, number);
            number = new BigDecimal("2.3").multiply(new BigDecimal("0.24")).numberValue();
            Assert.assertEquals(0.552, number);
            number = new BigDecimal("2.3").multiply(new BigDecimal("0.29")).numberValue();
            Assert.assertEquals(0.667, number);
            number = new BigDecimal("75").multiply(new BigDecimal("95")).numberValue();
            Assert.assertEquals(7125, number);

            //Tests envoyes par Simon
            number = new BigDecimal("8490.675").multiply(new BigDecimal("100")).numberValue();
            Assert.assertEquals(849067.5, number);
        }

        [Test]
        public function testDivide():void
        {
            var chiffre1:BigDecimal = new BigDecimal(555.50);
            var chiffre2:BigDecimal = new BigDecimal("45.55");

            var total:BigDecimal = chiffre1.divide(chiffre2);

            var string:String = total.toString();
            Assert.assertTrue(string == "12.1953896817");

            var aClass1:BigDecimal = new BigDecimal("0.15015");
            aClass1 = aClass1.setScale(31);
            var aClass2:BigDecimal = new BigDecimal("0.34567");
            var aClass3:BigDecimal = new BigDecimal("0.26897");


            total = aClass1.divide(aClass2).divide(aClass3);
            string = total.toString();

            Assert.assertEquals(string, "1.6149526889472623986174998258858");
        }

        [Test]
        public function testAbs():void
        {
            var chiffre1:BigDecimal = new BigDecimal("-555.567");

            var total:BigDecimal = chiffre1.abs();

            var string:String = total.toString();

            Assert.assertTrue(string == "555.567");
        }

        [Test]
        public function testPow():void
        {
            var chiffre1:BigDecimal = new BigDecimal("-55.50");
            var chiffre2:BigDecimal = new BigDecimal("3");

            var total:BigDecimal = chiffre1.pow(chiffre2);

            var string:String = total.toString();
            Assert.assertTrue(string == "-170953.875000");

        }

        [Test]
        public function testRoundEquals():void
        {
            var chiffre1:BigDecimal = (new BigDecimal(5.5)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(6)));
            chiffre1 = (new BigDecimal(2.5)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(3)));
            chiffre1 = (new BigDecimal(1.6)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(2)));
            chiffre1 = (new BigDecimal(1.1)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(1)));
            chiffre1 = (new BigDecimal(1.0)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(1)));
            chiffre1 = (new BigDecimal(-1.0)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(-1)));
            chiffre1 = (new BigDecimal(-1.1)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(-1)));
            chiffre1 = (new BigDecimal(-1.6)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(-2)));
            chiffre1 = (new BigDecimal(-2.5)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(-3)));
            chiffre1 = (new BigDecimal(-5.5)).setScale(0, MathContext.ROUND_HALF_UP);
            Assert.assertTrue(chiffre1.equals(new BigDecimal(-6)));
        }
    }


}
