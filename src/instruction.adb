with Token; use Token;

package body Instruction is
   function IsValidInstruction (TokenToCheck : TokenRecord) return Boolean is
   begin
      return True;
   end IsValidInstruction;

   function GetNumberOfOperands (TokenToCheck : TokenRecord) return Integer is
   begin

      for Index in Integer range 0 .. 2 loop
         if To_String(TokenToCheck.TokenString) = To_String(InstructionList ( Index ).InstructionString) then
            return InstructionList (Index).NumberOfOperands;
         end if;
      end loop;

      return 0;
   end GetNumberOfOperands;

end Instruction;