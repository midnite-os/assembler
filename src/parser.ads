with Token; use Token;

package Parser is
   procedure Parse;
   function ParseToken (TokenToParse : TokenRecord) return TokenRecord;
   function TokenIsReservedWord (TokenToCheck : TokenRecord) return Boolean;
   function TokenIsInstruction (TokenToCheck : TokenRecord) return Boolean;
   function TokenIsRegister (TokenToCheck : TokenRecord) return Boolean;
end Parser;