with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with OpcodeMap;

package body Assembler is
   procedure Assembler is
      Instructions : OpcodeMap.Object;
   begin
      Instructions.Load( To_Unbounded_String ( "maps/intel.map" ) );
      Instructions.Display;
   end Assembler;

begin
   Assembler;
end Assembler;