with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Token is

   type TokenType is
     (CharacterComma,
      CharacterLabel,
      CharacterLeftSquareBracket,
      CharacterLeftBracket,
      CharacterRightSquareBracket,
      CharacterRightBracket,
      StringLabel,
      StringToken,
      StringNumber,
      StringReservedWord,
      StringInstruction,
      StringRegister);

   type TokenRecord is
      record
         TokenString : Unbounded_String;
         TypeOfToken : TokenType;
      end record;

end Token;