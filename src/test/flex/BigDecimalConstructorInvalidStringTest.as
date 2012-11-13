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
