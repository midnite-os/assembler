with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

with Opcode;
-- with Operand; use Operand;

package OpcodeMap is

   subtype OpcodeMapIndex is Integer range 16#00# .. 16#FF#;

   type OpcodeAccess is access Opcode.Object;

   package OpcodeMapVectors is new Ada.Containers.Vectors
     (Element_Type => OpcodeAccess,
      Index_Type   => OpcodeMapIndex);

	type Object is tagged null record;
   procedure Add  (This : Object; O : OpcodeAccess);
   procedure Load (This : Object; FileName : Unbounded_String);
   procedure Display (This : Object);

   Index     : OpcodeMapIndex;
   OpcodeMap : OpcodeMapVectors.Vector;
end OpcodeMap;