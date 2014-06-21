with Token; use Token;

package body Lexer is
   Filename          : String := "start.asm";
   InputFile         : Ada.Text_IO.File_Type;
   Mode              : File_Mode := Ada.Text_IO.In_File;
   Char              : Character;
   DiscardedChar     : Character;
   EOL               : Boolean;
   
   Token             : Unbounded_String;

   procedure Initialise is
   begin
      Open (InputFile, Mode, FileName);
   end Initialise;

   procedure ReadCharIntoToken is
   begin
      Get (InputFile, Char);
      Token := Token & Char;
   end ReadCharIntoToken;
 
   procedure LookAhead is
   begin
      Look_Ahead (InputFile, Char, EOL);
   end LookAhead;

   procedure Discard is
   begin
      Get (InputFile, Char);
   end Discard;

   function FetchToken return TokenRecord is
      Token1 : TokenRecord;
   begin

--      Initialise;

      while not End_Of_File (InputFile) loop
         Token             := To_Unbounded_String ("");
         EOL               := False;

         LookAhead;

         if EOL then
--            Put_Line ("<EOL>");
            Ada.text_IO.Skip_Line (InputFile);
         else
            case Char is
   -- TAB / SPACE
               when Character'Val (9) |
                    ' ' =>
                  Discard;
               when '[' =>
--                  Put_Line ("<LEFTBRACKET>");
                  Discard;
               when ']' =>
--                  Put_Line ("<RIGHTBRACKET>");
                  Discard;
               when ',' =>
--                  Put_Line ("<COMMA>");
                  Discard;

               when ';' =>
                  Discard;
                  ReadCharIntoToken;
                  loop
                     LookAhead;
                     if EOL then
                        Ada.text_IO.Skip_Line (InputFile);
                        exit;
                     else
                        Discard;
                     end if;
                  end loop;

               when 'a' .. 'z' |
                    'A' .. 'Z' =>
                  ReadCharIntoToken;

                  loop
                     LookAhead;
                     case Char is
                        when 'a' .. 'z' |
                             'A' .. 'Z' |
                             '0' .. '9' |
                             '_' =>
                           ReadCharIntoToken;
                        when ':' =>
   -- LABEL
                           ReadCharIntoToken;
--                           Put_Line("<LABEL> - " & To_String (Token));
                           Token1.TokenString := Token;
                           Token1.TypeOfToken := StringLabel;
                           return Token1;
--                           exit;
                        when others =>
--                           Put_Line("<TOKEN> - " & To_String (Token));
                           Token1.TokenString := Token;
                           Token1.TypeOfToken := StringToken;
                           return Token1;
--                           exit;
                     end case;
                  end loop;

   -- LOCAL LABEL??
               when '.' =>
                  ReadCharIntoToken;
                  loop
                     LookAhead;
                     case Char is
                        when 'a' .. 'z' |
                             'A' .. 'Z' |
                             '0' .. '9' |
                             '_' =>
                           ReadCharIntoToken;
                        when ':' =>
   -- LABEL                     
                           exit;
                        when others =>
                           exit;
                     end case;
                  end loop;
--                  Put_Line("<LOCALLABEL> - " & To_String (Token));
               when '0' .. '9' =>
                  ReadCharIntoToken;
                  loop
                     LookAhead;
                     case Char is
                        when 'a' .. 'z' |
                             'A' .. 'Z' |
                             '0' .. '9' |
                             '_' =>
                           ReadCharIntoToken;

                        when others =>
                           exit;
                     end case;
                  end loop;
--                  Put_Line("<NUMBER> - " & To_String (Token));

               when others =>
--                  Put_Line ("other: '" & Char & "'");
                  Discard;
            end case;
         end if;
      end loop;


      return Token1;
   end FetchToken;
end Lexer;