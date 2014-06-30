with Ada.Text_IO; use Ada.Text_IO;
with Test; use Test;

package body TestB is
	procedure TestC is
		VarA : access Test.TestA;
	begin
		VarA := new TestA;
		VarA.TestProc;
	end;

begin
	TestC;
end TestB;