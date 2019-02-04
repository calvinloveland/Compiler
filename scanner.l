%{
#include <cstdlib>

#include "parser.hpp"
%}

%option noyywrap

letter [a-zA-Z]
digit [0-9]
char [^]+-*/&|~=<>.,:;()[%"]

%%

"+" {return SPLUS;}
"-" {return SMINUS;}
"*" {return SMULT;}
"/" {return SDIV;}
"(" {return SOPENPAREN;}
")" {return SCLOSEPAREN;}
"[" {return SOPENSQUARE;}
"]" {return SCLOSESQUARE;}
"\n" {return SNEWLINE;}
";" {return SSEMICOLON;}
"=" {return SEQUAL;}
"." {return SPERIOD;}
"," {return SCOMMA;}
"|" {return SPIPE;}
"&" {return SAMPERSAND;}
"<" {return SOPENANGLE;}
">" {return SCLOSEANGLE;}
"%" {return SPERCENTAGE;}
"~" {return STILDE;}
":" {return SCOLON}

"ARRAY" {return KARRAY;}
"array" {return KARRAY;}
"BEGIN" {return KBEGIN;}
"begin" {return KBEGIN;}
"CHR" {return KCHR;}
"chr" {return KCHR;}
"CONST" {return KCONST;}
"const" {return KCONST;}
"DO" {return KDO;}
"do" {return KDO;}
"DOWNTO" {return KDOWNTO;}
"downto" {return KDOWNTO;}
"ELSE" {return KELSE;}
"else" {return KELSE;}
"ELSEIF" {return KELSEIF;}
"elseif" {return KELSEIF;}
"END" {return KEND;}
"end" {return KEND;}
"FOR" {return KFOR;}
"for" {return KFOR;}
"FORWARD" {return KFORWARD;}
"forward" {return KFORWARD;}
"FUNCTION" {return KFUNCTION;}
"function" {return KFUNCTION;}
"IF" {return KIF;}
"if" {return KIF;}
"OF" {return KOF;}
"of" {return KOF;}
"ORD" {return KORD;}
"ord" {return KORD;}
"PRED" {return KPRED;}
"pred" {return KPRED;}
"PROCEDURE" {return KPROCEDURE;}
"procedure" {return KPROCEDURE;}
"READ" {return KREAD;}
"read" {return KREAD;}
"RECORD" {return KRECORD;}
"record" {return KRECORD;}
"REF" {return KREF;}
"ref" {return KREF;}
"REPEAT" {return KREPEAT;}
"repeat" {return KREPEAT;}
"RETURN" {return KRETURN;}
"return" {return KRETURN;}
"STOP" {return KSTOP;}
"stop" {return KSTOP;}
"SUCC" {return KSUCC;}
"succ" {return KSUCC;}
"THEN" {return KTHEN;}
"then" {return KTHEN;}
"TO" {return KTO;}
"to" {return KTO;}
"TYPE" {return KTYPE;}
"type" {return KTYPE;}
"UNTIL" {return KUNTIL;}
"until" {return KUNTIL;}
"VAR" {return KVAR;}
"var" {return KVAR;}
"WHILE" {return KWHILE;}
"while" {return KWHILE;}
"WRITE" {return KWRITE;}
"write" {return KWRITE;}

[a-z] {yylval.id = strdup(yytext);return IDENTIFIER;}
_[a-zA-Z]+ {yylval.id = strdup(yytext+1);return IDENTIFIER;}
[ \t] {}

[0-9]*\.[0-9]* {yylval.val = atof(yytext);return NUMBER;}
[0-9]+ {yylval.val = atof(yytext);return NUMBER;}




%%
