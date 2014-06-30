package body Opcode is
   function  getOpcode (This : Object) return Unbounded_String is
   begin
      return This.Value;
   end getOpcode;

	procedure setOpcode (This : in out Object; V : Unbounded_String) is
	begin
		This.Value := V;
	end setOpcode;
end Opcode;