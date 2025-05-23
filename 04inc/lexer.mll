(* lexer.mll - ocamllex source for lexer for inc
   Copyright (2023) Humberto Ortiz-Zuazaga <humberto.ortiz@upr.edu>
   See LICENSE for details
*)
{
open Parser

exception SyntaxError of string
}

let int = '-'?['0'-'9']+
let bin = "0b" ['0'-'1']+
let hex = "0x" ['0'-'9' 'a'-'f' 'A'-'F']+

rule read =
     parse
     | [' ' '\t']+      { read lexbuf }
     | '\r' | '\n' | "\r\n" {  read lexbuf }
     | int | bin | hex { INT (Int64.of_string (Lexing.lexeme lexbuf)) }
     | "++" { INCREMENT }
     | eof { EOF }
