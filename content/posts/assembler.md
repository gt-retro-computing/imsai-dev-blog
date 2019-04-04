---
title: "GWASM - The 8080 Assembler"
date: 2019-04-02T12:23:09-04:00
draft: false
toc: false
author: Codetector
tags: 
  - Software
  - 8080Assembler
---

On the software side, to build an operating system, we will definitly need a compiler and an assembler. 
As the assembler is the simpler task of the two, we decided to start with this. 

The finished assembler can be found on our [Github repository](https://github.com/gt-retro-computing/gwasm)

# Lexer / Tokenizer
The first part of any compiler (assembler) is to lex the source language. This is done using flex.

<details><summary>Flex rules</summary>
```

%{
    #include "helpers.h"
    #include "parser.h"
%}

%option outfile="lexer.c" header-file="lexer.h"

%option noyywrap

COMMA ","
COLON ":"
COMMENT ";"[^\n\r]*
DOT "\."
WHITE_SPACE [ \t]*
LINE_BREAK [\n\r]

IDENT [A-Za-z_][A-Za-z0-9_\-]*

HEX 0[Xx][0-9A-Fa-f]+
OCT 0[0-7]+
DEC [0-9]+

%%

{WHITE_SPACE} {}
{LINE_BREAK} {yylineno++; return TOKEN_LINEBREAK; }
{COMMENT} {}
{COMMA} {return TOKEN_COMMA;}
{COLON} {return TOKEN_COLON;}
{DOT} {return TOKEN_DOT;}
{DEC} { sscanf(yytext, "%i", &yylval.num); return TOKEN_NUM; }
{OCT} { sscanf(yytext, "%o", &yylval.num); return TOKEN_NUM; }
{HEX} { sscanf(yytext, "%x", &yylval.num); return TOKEN_NUM; }
{IDENT} { yylval.ident = copy_str(yytext); return TOKEN_IDENT;}

%%

int yyerror(const char* msg)
{    
    fprintf(stderr,"Error text = %s | Line: %d\n%s\n",yytext, yylineno, msg);
    return 0;
}
```
</details>

# Parsing
After the flex parsed the input, we can use the generated tokens to parse the assembly. The strucutre is essentially made of three types of element in the abstract syntax (Tree): ```instruction```, ```label```, and ```directive```
## First Pass
the goal of the first pass is to generate the symbol table, as well as identify every instruction (Also detecting illegal instructions) as well as its respective arguments. However, due to the fact we are creating symbol table in this pass, thus we can not detect references to invalid labels (yet).
Below is a sample program [fib.s]({{<ref "first_program.md">}}).
<details><summary>Output After First Pass 1</summary>
```
(D[1]): .org (ADDR 0x0) 
(L) [0x0] init
(I[0]): sphl 
(I[2]): mvi (REG a)(IMM 0) 
(I[2]): mvi (REG b)(IMM 1) 
(I[2]): mvi (REG l)(IMM 255) 
(L) [0x7] fib
(I[2]): mov (REG c)(REG a)
(I[1]): add (REG b)
(I[1]): jc (ADDR [init]) 
(I[1]): xra (REG l)
(I[1]): out (ADDR 0xFF) 
(I[1]): xra (REG l)
(I[2]): mov (REG b)(REG c)
(I[2]): mov (REG h)(REG a)
(I[2]): lxi (REGP bc)(IMM 65535) 
(L) [0x15] delay
(I[1]): dcx (REGP bc)
(I[2]): mov (REG a)(REG d)
(I[1]): ora (REG e)
(I[1]): jnz (ADDR [delay]) 
(I[2]): mov (REG a)(REG h)
(I[1]): jmp (ADDR [fib]) 

```
 This is part of the assembler's debug output. Format reads as follow: (Type: D:Directive, I:Instruction, L:Label. [Number of Arguments Associated With This Node]): [Resolved Label Address]
</details>


## Pass 2: Address Subsistution 

As you can see from the output of 1st pass, it still looks very much like the original assembly input. This is very close to the final output, as an assembler is a very simple compiler. It is really close
to the final output of the progarm, the missing step is to backfill the label reference and translate the mnemonic into binary instruction.

<details><summary>Output from stage 2</summary>
```
(D[1]): .org (ADDR 0x0) 
(L) [0x0] init
(I[0]): sphl 
(I[2]): mvi (REG a)(IMM 0) 
(I[2]): mvi (REG b)(IMM 1) 
(I[2]): mvi (REG l)(IMM 255) 
(L) [0x7] fib
(I[2]): mov (REG c)(REG a)
(I[1]): add (REG b)
(I[1]): jc (ADDR 0x0) 
(I[1]): xra (REG l)
(I[1]): out (ADDR 0xFF) 
(I[1]): xra (REG l)
(I[2]): mov (REG b)(REG c)
(I[2]): mov (REG h)(REG a)
(I[2]): lxi (REGP bc)(IMM 65535) 
(L) [0x15] delay
(I[1]): dcx (REGP bc)
(I[2]): mov (REG a)(REG d)
(I[1]): ora (REG e)
(I[1]): jnz (ADDR 0x15) 
(I[2]): mov (REG a)(REG h)
(I[1]): jmp (ADDR 0x7) 
```
</details>
