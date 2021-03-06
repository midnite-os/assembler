with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Maps.Constants;
with Ada.Strings.Fixed;

with Lexer;
with Token; use Token;

with Instruction;

package body Parser is
   procedure Parse is
      Token1 : Token.TokenRecord;

      Token2 : Token.TokenRecord;

      NumberOfOperands : Integer;
      OperandsToFetch  : Integer;

      OperandToken : Token.TokenRecord;
   begin

      Lexer.Initialise;

      loop
         Token1 := Lexer.FetchToken;

         if Token1.TypeOfToken = StringToken then
            Token2 := ParseToken (Token1);

            if Token2.TypeOfToken = StringReservedWord then
               Put_Line ("<RESERVED-WORD> - " & To_String(Token2.TokenString));
            end if;

            if Token2.TypeOfToken = StringInstruction then
               NumberOfOperands := Instruction.GetNumberOfOperands(Token2);
               OperandsToFetch  := NumberOfOperands;

               Put_Line ("<INSTRUCTION>   - " & To_String(Token2.TokenString) & " - " & Integer'Image(NumberOfOperands));

               if OperandsToFetch > 0 then
--               while OperandsToFetch > 0 loop
                  OperandToken := Lexer.FetchToken;
                  Put_Line ("<OPERAND 1>   - " & To_String(OperandToken.TokenString));

                  if OperandsToFetch = 2 then
                     OperandToken := Lexer.FetchToken;
                     Put_Line ("<OPERAND 2>   - " & To_String(OperandToken.TokenString));
                  end if;
--               end loop;
               end if;


            end if;

            if Token2.TypeOfToken = StringRegister then
               Put_Line ("<REGISTER>      - " & To_String(Token2.TokenString));
               exit;
            end if;

--            exit;
         end if;
      end loop;
   end Parse;

   function ParseToken (TokenToParse : TokenRecord) return TokenRecord is
      ModifiedToken : TokenRecord;
   begin

      if TokenIsReservedWord (TokenToParse) then
         ModifiedToken.TokenString := TokenToParse.TokenString;
         ModifiedToken.TypeOfToken := StringReservedWord;
         return ModifiedToken;
      end if;

      if TokenIsInstruction (TokenToParse) then
         ModifiedToken.TokenString := TokenToParse.TokenString;
         ModifiedToken.TypeOfToken := StringInstruction;
         return ModifiedToken;
      end if;

      if TokenIsRegister (TokenToParse) then
         ModifiedToken.TokenString := TokenToParse.TokenString;
         ModifiedToken.TypeOfToken := StringRegister;
         return ModifiedToken;
      end if;

      return ModifiedToken;
   end ParseToken;

   function TokenIsReservedWord (TokenToCheck : TokenRecord) return Boolean is
   begin

      if To_String (TokenToCheck.TokenString) = "SECTION" then
         return True;
      end if;

      return False;
   end TokenIsReservedWord;

   function TokenIsInstruction (TokenToCheck : TokenRecord) return Boolean is
   begin

      for Index in 0 .. (Instruction.InstructionList'Length - 1) loop
         if Ada.Strings.Fixed.Translate(To_String(Instruction.InstructionList(Index).InstructionString),
     Ada.Strings.Maps.Constants.Upper_Case_Map) = Ada.Strings.Fixed.Translate(To_String(TokenToCheck.TokenString),
     Ada.Strings.Maps.Constants.Upper_Case_Map) then
            return True;
         end if;
      end loop;

      return False;
   end TokenIsInstruction;

   function TokenIsRegister (TokenToCheck : TokenRecord) return Boolean is
   begin

      if To_String (TokenToCheck.TokenString) = "EAX" then
         return True;
      end if;

      if To_String (TokenToCheck.TokenString) = "EBX" then
         return True;
      end if;

      if To_String (TokenToCheck.TokenString) = "ECX" then
         return True;
      end if;

      if To_String (TokenToCheck.TokenString) = "EDX" then
         return True;
      end if;

      if To_String (TokenToCheck.TokenString) = "ESP" then
         return True;
      end if;

      return False;
   end TokenIsRegister;

end Parser;