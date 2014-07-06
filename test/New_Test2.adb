with Aunit.Test_Cases.Registration; use AUnit.Test_Cases.Registration;
with AUnit.Assertions;              use AUnit.Assertions;
package body New_Test2 is

   ------------
   -- Set_Up --
   ------------

   procedure Set_Up (T : in out Test_Case) is
      pragma Unreferenced (T);
   begin
      null;
   end Set_Up;

   ---------------
   -- Tear_Down --
   ---------------

   procedure Tear_Down (T : in out Test_Case) is
      pragma Unreferenced (T);
   begin
      null;
   end Tear_Down;

   ----------
   -- Name --
   ----------

   function Name (T : Test_Case)
                  return String_Access is
   begin
      return new String'("(no description)");
   end Name;

   --------------------
   -- Register_Tests --
   --------------------

   procedure Register_Tests (T : in out Test_Case) is
   begin
      null;
   end Register_Tests;

end New_Test2;
