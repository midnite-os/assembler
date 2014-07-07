-- my_tests.adb
with Ahven;

package body My_Tests is
   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "My tests");
      Ahven.Framework.Add_Test_Routine
        (T, Test_Addition'Access, "Addition");
   end Initialize;

   procedure Test_Addition is
   begin
      null;
   end Test_Addition;
end My_Tests;
--
