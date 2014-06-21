with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Token; use Token;

package Lexer is
	   procedure Initialise;
	   procedure ReadCharIntoToken;
	   procedure LookAhead;
	   procedure Discard;
	   function FetchToken return TokenRecord;
end Lexer;