with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada;

--package BTree
   procedure Tree is

      type Node;

      type Tree is access Node;

      type Node is record
         Item:  Integer;
         Left,Right:  Tree;
      end record;

      procedure Preorder (T: Tree) is
      begin
         if (T/=null) then
            Integer_Text_IO.Put (T.Item);
            Text_IO.New_Line;
            Preorder (T.Left);
            Preorder (T.Right);
         end if;
      end Preorder;

      procedure Inorder (T: Tree) is
      begin
         if (T/=null) then
            Inorder (T.Left);
            Integer_Text_IO.Put (T.Item);
            Text_IO.New_Line;
            Inorder (T.Right);
         end if;
      end Inorder;

      procedure Insert (I: Integer; T: in out Tree) is
      begin
         if T=null then
            T := new Node'(I, null, null);
         elsif I<T.Item then
            Insert (I, T.Left);
         else
            Insert (I, T.Right);
         end if;
      end Insert;

      type Item_Array is array (Integer range <>) of Integer;

      procedure Insert (A: Item_Array; T: in out Tree) is
      begin
         for I in A'Range loop
            Insert (A(I), T);
         end loop;
      end Insert;

      T    : Tree := null;
      Data : constant Item_Array := (16,5,2,8,7,19,18,22,20,21,23);

   begin
      Insert (Data, T);
      Preorder (T);
      Inorder (T);
   end Tree;
--end BTree;