BigDecimal.as
=============

*Now with added _enterpriseyness_!!*

This project is a continuation of the de-facto [ActionScript3 BigDecimal](http://code.google.com/p/bigdecimal/) implementation focusing on

* Correctness
* Performance
* Cleanliness

Benchmarks
----------

Initial benchmarks show the current version is 25-50% faster and uses around 30% less memory. See the `bench` directory for details.

Changes made
------------

Here's a summary of the interesting internal and API changes made since [http://code.google.com/p/bigdecimal/](http://code.google.com/p/bigdecimal/).

__`ArithmeticError.as`__

* Added new `Error` type, `ArithmeticError`

__`BigDecimal.as`__

* Added `createFromUnscaledInteger()` static factory method for when you have an unscaled integer and a separate scale
* Added `toEngineeringString()`, `toPlainString()` and `toCanonicalString()` methods for different `String` representations
* Added implementation of `IExternalizable`
* Removed `format()`; it or something like it may later come back to allow performant `BigDecimal` formatting
* Removed `form` private variable; numbers are now form-agnostic
* Changed constructor's handling of `Number` parameters: it no longer sets the scale to 10. You should use `String`/`int` arguments instead of `Number` at all times
* Changed `scale()` to allow returning negative values; before the return value was always positive
* Changed maximum range of integer exponents from `-99,9999,999 .. 99,999,9999` to `-2,147,483,648 .. 2,147,483,647` (`int.MIN_VALUE .. int.MAX_VALUE`)
* Changed some methods to throw `ArithmeticError` and/or `ArgumentError` instead of plain `Error`
* Changed `pow()`'s exponent argument from `BigDecimal` to `int`
* Changed internal storage of mantissa digits from `Array` to `Vector.<int>`
* Changed from using AS3 code to create, extend and copy `Arrays` to use native `Vector` methods instead

__`MathContext.as`__

* Removed property-shadowing `getXxx()` methods; use the property-named getters instead
* Removed `form` property and `NOTATION_PLAIN`, `NOTATION_SCIENTIFIC` and `NOTATION_ENGINEERING` constants

__Tests__

* Added lots of unit tests from the Apache Harmony project; code coverage is currently 87%

TODO
----

In no particular order, the roadmap includes the following, depending on user feedback:

* Provide a fast BigDecimalFormatter, avoiding intermediary String munging
* Benchmark more public methods, eg, add, subtract, multiply, divide, toString, setScale; add pretty charts for benchmark results; Publish bencmark app
* More refactoring/performance tuning
