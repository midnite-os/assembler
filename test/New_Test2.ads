with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AUnit.Test_Cases;      use AUnit.Test_Cases;

package New_Test2 is

   type Test_Case is new AUnit.Test_Cases.Test_Case with null record;

   procedure Set_Up (T : in out Test_Case);
   --  Preparation performed before each routine

   procedure Tear_Down (T : in out Test_Case);
   --  Cleanup performed after each routine

   procedure Register_Tests (T : in out Test_Case);
   --  Register routines to be run

   function Name (T : Test_Case)
                  return String_Access;
   --  Returns name identifying the test case

end New_Test2;