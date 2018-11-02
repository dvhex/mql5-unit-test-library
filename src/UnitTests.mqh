//+------------------------------------------------------------------+
//|                                                 MQL5UnitTest.mqh |
//|                                     Copyright 2014, Louis Fradin |
//|                                      http://en.louis-fradin.net/ |
//+------------------------------------------------------------------+

#property copyright "Copyright 2014, Louis Fradin"
#property link      "http://en.louis-fradin.net/"
#property version   "1.1"

#include <Object.mqh>
#include <Arrays\List.mqh>
#include "FailedUnitTest.mqh"

//+------------------------------------------------------------------+
//| Prototype
//+------------------------------------------------------------------+

class CUnitTests: public CObject{
   private:
      string m_name;
      CList m_failedTestsList;
      
      void AddFailedTest(string file, int line, string message);

   public:
      CUnitTests(string testName);
      ~CUnitTests();
      
      // Tests
      bool IsTrue(string file, int line, bool result);
      bool IsFalse(string file, int line, bool result);
      template<typename T> bool IsEquals(string file, int line, T valueA, T valueB);
      bool IsEquals(string file, int line, string stringA, string stringB);
      bool IsAlmostEquals(string file, int line, double valueA, double valueB, int digits = 6);
      template<typename T> bool IsNotEquals(string file, int line, T valueA, T valueB);
      void SetFalse(string file, int line, string message);
      
      // Failed tests
      CFailedUnitTest* GetFailedTest(int position);
      int TotalFailedTests();
      
      // Accessors
      string GetName();
};

//+------------------------------------------------------------------+
//| Constructor
//+------------------------------------------------------------------+

CUnitTests::CUnitTests(string testName){
   m_name = testName;
   Print(" => "+m_name);
}

//+------------------------------------------------------------------+
//| Destructor
//+------------------------------------------------------------------+

CUnitTests::~CUnitTests(){
   m_failedTestsList.Clear();
}

//+------------------------------------------------------------------+
//| Add a Failed Test to the intern list of failed tests
//+------------------------------------------------------------------+

void CUnitTests::AddFailedTest(string file, int line, string message){
   CFailedUnitTest *newFailedTest = new CFailedUnitTest(file,line);  
   
   // Add informations
   newFailedTest.SetResult(message);
   
   // Insert the failed Test
   m_failedTestsList.Add(newFailedTest);
}

//+------------------------------------------------------------------+
//| Unit test verifying if the argument is true
//| @param result Boolean to compare
//+------------------------------------------------------------------+

bool CUnitTests::IsTrue(string file, int line, bool result){
   if(result!=true){
      this.AddFailedTest(file, line, "isTrue(False)");
      return false;
   }
   else
      return true;
}

//+------------------------------------------------------------------+
//| Unit test verifying if the argument is true
//| @param result Boolean to compare
//+------------------------------------------------------------------+

bool CUnitTests::IsFalse(string file, int line, bool result){
   if(result!=false){
      this.AddFailedTest(file, line, "isFalse(True)");
      return false;
   }
   else
      return true;
}

//+------------------------------------------------------------------+
//| Unit test verifying if the two any arguments are equals
//| @param valueA First value to compare
//| @param valueB Second value to compare
//+------------------------------------------------------------------+

template<typename T> bool CUnitTests::IsEquals(string file, int line, T valueA, T valueB){
   if(valueA!=valueB){ // If values are differents
      string message = "IsEquals("+(string)valueA+","+(string)valueB+")";
      this.AddFailedTest(file, line, message); // Add a fail test
      return false;
   }
   else
      return true;
}

//+------------------------------------------------------------------+
//| Unit test verifying if the two string arguments are equals
//| @param stringA First string to compare
//| @param stringB Second string to compare
//+------------------------------------------------------------------+

bool CUnitTests::IsEquals(string file, int line, string stringA, string stringB){
   if(stringA!=stringB){ // If strings are differents
      string message = "IsEquals('"+stringA+"','"+stringB+"')";
      this.AddFailedTest(file, line, message); // Add a fail test
      return false;
   }
   else
      return true;
}

//+------------------------------------------------------------------+
//| Unit test verifying if the two double arguments are almost equals
//| @param valueA First value to compare
//| @param valueB Second value to compare
//| @param digits Number of decimal places
//+------------------------------------------------------------------+


bool CUnitTests::IsAlmostEquals(string file, int line, double valueA, double valueB, int digits) {
   double k = MathPow(10, digits);
   double intA = (int)MathRound(valueA * k);
   double intB = (int)MathRound(valueB * k);
   if (intA != intB) { // If values are differents
      string message = "IsEquals("+DoubleToString(intA / k)+","+DoubleToString(intB / k)+")";
      this.AddFailedTest(file, line, message); // Add a fail test
      return false;
   }
   else
      return true;
}

//+------------------------------------------------------------------+
//| Unit test verifying if the two double arguments are not equals
//| @param nbrA First double to compare
//| @param nbrB Second double to compare
//+------------------------------------------------------------------+

template<typename T> bool CUnitTests::IsNotEquals(string file, int line, T valueA, T valueB) {
   if(nbrA==nbrB){ // If strings are differents
      string message = "IsNotEquals("+(string)valueA+","+(string)valueB+")";
      this.AddFailedTest(file, line, message); // Add a fail test
      return false;
   }
   else
      return true;
} 

//+------------------------------------------------------------------+
//| Set the Unit Test as false directly for a certain reason
//| @param expected What was expected
//| @param reality What really happen
//+------------------------------------------------------------------+

void CUnitTests::SetFalse(string file, int line, string message){
   this.AddFailedTest(file, line, message); // Add a fail test
}

//+------------------------------------------------------------------+
//| Get the failed test by its position in the list
//| @return The failed if a test exists at this position, NULL otherwise
//+------------------------------------------------------------------+

CFailedUnitTest* CUnitTests::GetFailedTest(int position){
   return m_failedTestsList.GetNodeAtIndex(position);
}

//+------------------------------------------------------------------+
//| Get the total of failed tests
//| @return The total of failed tests
//+------------------------------------------------------------------+

int CUnitTests::TotalFailedTests(void){
   return m_failedTestsList.Total();
}

//+------------------------------------------------------------------+
//| Get the name of the unit test
//| @return The unit test name
//+------------------------------------------------------------------+

string CUnitTests::GetName(){
   return m_name;
}

//+------------------------------------------------------------------+
