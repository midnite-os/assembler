with Ada.Text_IO; use Ada.Text_IO;

package body Test is

	protected body TestA is
		procedure TestProc is
		begin
			Put_Line("test");
		end TestProc;
	end TestA;

end Test;