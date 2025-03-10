%{
#include "parser.tab.h"
#include <cstdio>
#include <cstdlib>
%}

identifier      [_a-zA-Z][_a-zA-Z0-9]*
number          [0-9]
int_value       [1-9]{number}*|{number}
real_value      {number}+"."{number}*|{number}*"."{number}+|{int_value}
string_value    "'".*"'"
string_value_x  x"'".*"'"
string_value_c  c"'".*"'"


%%

\n             { return EOL; }
[ \t]+          ;
"PCB"          { return PCB; }
"TYPE"         { return TYPE; }
"LTERM"        { return LTERM; }
"DBDNAME"      { return DBDNAME; }
"NAME"         { return NAME; }
"PROCOPT"      { return PROCOPT; }
"ALTRESP"      { return ALTRESP; }
"SAMETRM"      { return SAMETRM; }
"SB"           { return SB; }
"KEYLEN"       { return KEYLEN; }
"PROCSEQ"      { return PROCSEQ; }
"VIEW"         { return VIEW; }
"POS"          { return POS; }
"MODIFY"       { return MODIFY; }
"EXPRESS"      { return EXPRESS; }
"PCBNAME"      { return PCBNAME; }
"LIST"         { return LIST; }

"("            { return LPAREN; }
")"            { return RPAREN; }
","            { return COMMA; }
"="            { return EQUALS; }
"*"            { return STAR; }

{identifier}   { yylval.sval = strdup(yytext); return IDENTIFIER; }
{int_value}    { yylval.sval = strdup(yytext); return INTEGER; }
{real_value}   { yylval.sval = strdup(yytext); return REAL; }
{string_value} { yylval.sval = strdup(yytext); return STRING; }
{string_value_x} { yylval.sval = strdup(yytext); return STRING_X; }
{string_value_c} { yylval.sval = strdup(yytext); return STRING_C; }

.              { return SYMBOL; }

%%

int yywrap() {
    return 1;
}

