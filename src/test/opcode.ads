with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Opcode is
	type Object is tagged
      record
         Value : Unbounded_String;
      end record;
   function  getOpcode (This : Object) return Unbounded_String;
	procedure setOpcode (This : in out Object; V : Unbounded_String);

end Opcode;