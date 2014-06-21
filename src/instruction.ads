with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Token; use Token;

package Instruction is

   type InstructionRecord is
      record
         InstructionString : Unbounded_String;
         NumberOfOperands  : Integer;
      end record;

   type InstructionListArray is array (Integer range <>) of InstructionRecord;

   InstructionList : InstructionListArray := (
      0 => (
         InstructionString => To_Unbounded_String ( "MOV" ),
         NumberOfOperands => 2 
      ),
      1 => (
         InstructionString => To_Unbounded_String ( "NOP" ),
         NumberOfOperands => 0
      ),
      2 => (
         InstructionString => To_Unbounded_String ( "JMP" ),
         NumberOfOperands => 1
      )
   );

   function IsValidInstruction (TokenToCheck : TokenRecord) return Boolean;
   function GetNumberOfOperands (TokenToCheck : TokenRecord) return Integer;

end Instruction;