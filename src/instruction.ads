with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Token; use Token;

package Instruction is

   type InstructionRecord is
      record
         InstructionString : Unbounded_String;
         NumberOfOperands  : Integer;
         Operand1          : Unbounded_String;
         Operand2          : Unbounded_String;
      end record;

   type InstructionListArray is array (Integer range <>) of InstructionRecord;

   InstructionList : InstructionListArray := (
      16#00# => (
         InstructionString => To_Unbounded_String ( "ADD" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "Eb" ),
         Operand2          => To_Unbounded_String ( "Gb" )
      ),
      16#01# => (
         InstructionString => To_Unbounded_String ( "ADD" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "Ev" ),
         Operand2          => To_Unbounded_String ( "Gv" )
      ),
      16#02# => (
         InstructionString => To_Unbounded_String ( "ADD" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "Gb" ),
         Operand2          => To_Unbounded_String ( "Eb" )
      ),
      16#03# => (
         InstructionString => To_Unbounded_String ( "ADD" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "Gv" ),
         Operand2          => To_Unbounded_String ( "Ev" )
      ),
      16#04# => (
         InstructionString => To_Unbounded_String ( "ADD" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "AL" ),
         Operand2          => To_Unbounded_String ( "Ib" )
      ),
      16#05# => (
         InstructionString => To_Unbounded_String ( "ADD" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "rAX" ),
         Operand2          => To_Unbounded_String ( "Iz" )
      ),
      16#06# .. 16#87# => (
         InstructionString => To_Unbounded_String ( "" ),
         NumberOfOperands  => 0,
         Operand1          => To_Unbounded_String ( "" ),
         Operand2          => To_Unbounded_String ( "" )

      ),
      16#88# => (
         InstructionString => To_Unbounded_String ( "MOV" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "Eb" ),
         Operand2          => To_Unbounded_String ( "Gb" )
      ),
      16#89# => (
         InstructionString => To_Unbounded_String ( "MOV" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "Ev" ),
         Operand2          => To_Unbounded_String ( "Gv" )
      ),
      16#8A# => (
         InstructionString => To_Unbounded_String ( "MOV" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "Gb" ),
         Operand2          => To_Unbounded_String ( "Eb" )
      ),
      16#8B# => (
         InstructionString => To_Unbounded_String ( "MOV" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "Gv" ),
         Operand2          => To_Unbounded_String ( "Ev" )
      ),
      16#8C# => (
         InstructionString => To_Unbounded_String ( "MOV" ),
         NumberOfOperands  => 2,
         Operand1          => To_Unbounded_String ( "Ev" ),
         Operand2          => To_Unbounded_String ( "Sw" )
      )
   );

   function IsValidInstruction (TokenToCheck : TokenRecord) return Boolean;
   function GetNumberOfOperands (TokenToCheck : TokenRecord) return Integer;

end Instruction;