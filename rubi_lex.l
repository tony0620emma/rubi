%{
#include <stdio.h>
#include "y.tab.h"
extern void yyerror(const char *);
%} 

%%

"#".* {/* consume comment */}

\n {return NEW_LINE;}
"string" {return STRING;}
"def" {return DEF;}
"for" {return FOR;}
"while" {return WHILE;}
"if"  {return IF;}
"elsif" {return ELSIF;}
"else" {return ELSE;}
"break" {return BREAK;}
"end" {return END;}
"(" {return '(';}
")" {return ')';}
"[" {return '[';}
"]" {return ']';}
";" {return ';';}
"," {return ',';}
"$" {return '$';}
"++" {return INC;}
"--" {return DEC;}
"&&" {return AND;}
"||" {return OR;}
"!=" {return NE;}
"==" {return EQ;}
">=" {return GE;}
"<=" {return LE;}
">" {return '>';}
"<" {return '<';}
"+" {return '+';}
"-" {return '-';}
"*" {return '*';}
"/" {return '/';}
"%" {return '%';}
"|" {return '|';}
"&" {return '&';}
"!" {return '!';}
[1-9]+[0-9]* {return NUMBER;}
[a-zA-Z_]+[0-9a-zA-Z_]* {return VARIABLE;}
[ \t]  { /* nothing */}

%%

int yywrap(void)
{
	return 1;
}
