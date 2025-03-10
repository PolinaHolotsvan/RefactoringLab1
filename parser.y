%{
#include <iostream>
#include <cstdlib>
#include <cstring>
#include "PCBClass.h"

using namespace std;

extern int yylex();
void yyerror(const char *s) { cerr << "Error: " << s << endl; }

PCBClass psb_parsed;
string file_name;
%}

%union {
    int ival;
    char *sval;
}

%type <sval> key_value key_value_atomic value_list key_value_list
%token <sval> IDENTIFIER INTEGER REAL STRING STRING_X STRING_C STAR
%token PCB TYPE LTERM DBDNAME NAME PROCOPT ALTRESP SAMETRM SB KEYLEN PROCSEQ VIEW POS MODIFY
%token EXPRESS PCBNAME LIST LPAREN RPAREN COMMA EQUALS EOL SYMBOL

%%

pcb:
    pcb_head pcb_attr_list EOL {
        psb_parsed.writeJSON(file_name);

        cout << "Record successfully parsed, data written to file " << file_name << endl;
        YYACCEPT;
    }
;

pcb_head:
    label PCB
    | PCB
;

label: SYMBOL
;

pcb_attr_list:
    pcb_attr_list COMMA pcb_attr
    | pcb_attr
;

pcb_attr:
    TYPE EQUALS key_value    { psb_parsed.type = $3; }
    | LTERM EQUALS key_value   { psb_parsed.lterm = $3; }
    | DBDNAME EQUALS key_value { psb_parsed.dbdname = $3; }
    | NAME EQUALS key_value    { psb_parsed.name = $3; }
    | PROCOPT EQUALS key_value { psb_parsed.procopt = $3; }
    | ALTRESP EQUALS key_value { psb_parsed.altresp = $3; }
    | SAMETRM EQUALS key_value { psb_parsed.sametrm = $3; }
    | SB EQUALS key_value      { psb_parsed.sb = $3; }
    | KEYLEN EQUALS key_value  { psb_parsed.keylen = $3; }
    | PROCSEQ EQUALS key_value { psb_parsed.procseq = $3; }
    | VIEW EQUALS key_value    { psb_parsed.view = $3; }
    | POS EQUALS key_value     { psb_parsed.pos = $3; }
    | MODIFY EQUALS key_value  { psb_parsed.modify = $3; }
    | EXPRESS EQUALS key_value { psb_parsed.express = $3; }
    | PCBNAME EQUALS key_value { psb_parsed.pcbname = $3; }
    | LIST EQUALS key_value    { psb_parsed.list = $3; }
    | /* empty */
;

key_value:
    key_value_list { $$ = $1; }
    | key_value_atomic { $$ = $1; }
;

key_value_list:
    LPAREN value_list RPAREN {
        string formatted_list = "(" + string($2) + ")";
        $$ = strdup(formatted_list.c_str());
    }
;

value_list:
    key_value_atomic { $$ = strdup($1); }
    | value_list COMMA key_value_atomic {
        string combined = string($1) + "," + string($3);
        $$ = strdup(combined.c_str());
    }
;

key_value_atomic:
    IDENTIFIER { $$ = strdup($1); }
    | INTEGER { $$ = strdup($1); }
    | REAL { $$ = strdup($1); }
    | STRING { $$ = strdup($1); }
    | STRING_X { $$ = strdup($1); }
    | STRING_C { $$ = strdup($1); }
    | STAR { $$ = strdup($1); }
    | /* empty */
;

%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        cerr << "Usage: " << argv[0] << " <file_name>" << endl;
        return 1;
    }

    file_name = argv[1];

    if (yyparse() == 0) {
        PCBClass psb_read(file_name);
        cout << "PCB object from file " << file_name << " :" << endl;
        psb_read.printInfo();
    } else {
        cerr << "Parsing failed. PCB object was not created." << endl;
    }

    return 0;
}
