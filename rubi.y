%{// Declarations of C code

%}

%token STRING
%token DEF FOR WHILE IF ELSIF ELSE BREAK END RETURN
%token INC DEC AND OR NE EQ GE LE
%token NUMBER VARIABLE GLOBAL_VARIABLE
%start input

%%

input:
  global_declaration main
| input global_declaration main
;

global_declaration: 
  /* might be no global defs */
| global_difinition
| function_difinitions
;

function_difinitions:
  function_difinitions function_difinition
| function_difinition
;

function_difinition:
  DEF function_name function_arguments statement_list END
; 

function_arguments:
  /* might be no arguments */
| '(' argument_list ')'
;

argument_list:
  argument_list ',' VARIABLE
| VARIABLE
;

global_difinition:
  global_difinition global_statement
| global_statement
;

global_statement:
  GLOBAL_VARIABLE '=' right_expression
;

statement_list:
/* might be no statement */
| statement_list statement
;

statement:
  assign_statement
| condition_statement
| return_statement
;

assign_statement:
  VARIABLE '=' right_expression
| VARIABLE INC
| VARIABLE DEC
;

condition_statement:
  while_statement
| for_statement
| if_statement
;

while_statement:
  WHILE relational_expression statement_list END
;

for_statement:
  FOR assign_expression ',' relational_expression ',' assign_statement 
  statement_list END
;

if_statement:
  IF relational_expression statement_list END
| IF relational_expression statement_list else_statement END
;

else_statement:
  ELSIF relational_expression statement_list else_statement
| ELSE statement_list
;

relational_expression:
  unary_expression relational_operator right_expression
| right_expression relational_operator unary_expression
;

relational_operator:
  EQ
| NE
| GE
| LE
| '>'
| '<'
;

main:
  statement_list
;

%%
#include <stdio.h>

extern char yytext[];

void yyerror(char *s)
{
	fprintf(stderr, "error!! processing: \"%s\"\n", s);
}

int main(int argc, char *argv[])
{
	yyparse();
	return 0;
}
