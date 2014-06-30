with Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Strings.Fixed;
with Opcode;
-- with Operand;

package body OpcodeMap is
   procedure Add (This : Object; O : OpcodeAccess) is
   begin
--      OpcodeMap.Insert (Index, O);
      OpcodeMap.Append (O);
   end Add;

	procedure Load (This : Object; Filename : Unbounded_String) is
      O          : OpcodeAccess;
      InputFile  : Ada.Text_IO.File_Type;
      Line_Count : Integer := 0;
   begin
      Ada.Text_IO.Open (File => InputFile,
                        Mode => Ada.Text_IO.In_File,
                        Name => To_String(Filename));

      while not Ada.Text_IO.End_Of_File (InputFile) loop
         declare
            Line     : String  := Ada.Text_IO.Get_Line (InputFile);
            OpStart  : Natural := Ada.Strings.Fixed.Index (Line, " ");
            Code     : String  := Line (Line'First .. OpStart);
            Op       : String  := Line ((Opstart + 1) .. Ada.Strings.Fixed.Index (Line ((OpStart + 1) .. Line'Last), " "));
         begin

            if Op'Length > 0 then
               O := new Opcode.Object;
               O.setOpcode (To_Unbounded_String (Op));
               This.Add(O);
            end if;

         end;
      end loop;

      Ada.Text_IO.Close (InputFile);
   end Load;

   procedure Display (This : Object) is
      O_Cursor  : OpcodeMapVectors.Cursor;
   begin
      O_Cursor := OpcodeMapVectors.First (OpcodeMap);
      for i in OpcodeMap.First_Index .. OpcodeMap.Last_Index loop
-- Output the element of the current position.
         Ada.Text_IO.Put_Line (
            Item => OpcodeMapVectors.To_Index (Position => O_Cursor)'Img & " " &
            To_String(OpcodeMapVectors.Element (Position => O_Cursor).getOpcode)
         );
-- Move the cursor to the next position in the vector.
         OpcodeMapVectors.Next (Position => O_Cursor);
      end loop;
   end Display;
end OpcodeMap;