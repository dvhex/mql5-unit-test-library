# UTLibrary-mql5
Unit Test Library for MQL5 programs.

## Use
In your script, create a UnitTestsCollection in order to regroup all unitTests.

    void OnStart(){
       CUnitTestsCollection utCollection();

       utCollection.AddUnitTests(TestFail());
       utCollection.AddUnitTests(TestSuccess());
    }

Then, you can regroup unit tests by themes in functions, in order
to add them to the collection.

    CUnitTests* TestSuccess(){
       CUnitTests* ut = new CUnitTests("TestSuccess");

       ut.IsFalse(__FILE__, __LINE__, false);
       ...
       ut.IsEquals(__FILE__, __LINE__, "Bonjour", "Bonjour");

       return ut;
    }

For more informations, see examples.

## Available tests

* Booleans
  * bool **IsTrue**(string file, int line, bool result);
  * bool **IsFalse**(string file, int line, bool result);
* Strings
  * bool **IsEquals**(string file, int line, string stringA, string stringB);
* Doubles
  * bool **IsAlmostEquals**(string file, int line, double valueA, double valueB, int digits);
* All types
  * template<typename T> bool **IsEquals**(string file, int line, T valueA, T valueB);
  * template<typename T> bool **IsNotEquals**(string file, int line, T valueA, T valueB);
* Others
  * void **SetFalse**(string file, int line, string message);

## Ameliorations
I will add tests when I need them. Feel free to propose yours.
