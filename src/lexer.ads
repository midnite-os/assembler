with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Lexer is
	   procedure Initialise;
	   procedure ReadCharIntoToken;
	   procedure LookAhead;
	   procedure Discard;
	   procedure FetchToken;
end Lexer;