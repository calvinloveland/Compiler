%{
#include <iostream>
#include <map>

#include "symbol_table.hpp"

extern int yylex();
void yyerror(const char*);
%}

%union
{
float val;
char* id;
}

%token SPLUS
%token SMINUS
%token SMULT
%token SDIV
%token SNUMBER
%token SID
%token SEQUAL
%token SOPENPAREN
%token SCLOSEPAREN
%token SSEMICOLON
%token SNEWLINE
%token SPERIOD
%token SCOMMA
%token SPIPE
%token SAMPERSAND
%token SOPENANGLE
%token SCLOSEANGLE
%token SPERCENTAGE
%token STILDE
%token SCOLON
%token SOPENSQUARE
%token SCLOSESQUARE

%token KARRAY
%token KBEGIN
%token KCHR
%token KCONST
%token KDO
%token KDOWNTO
%token KELSE
%token KELSEIF
%token KEND
%token KFOR
%token KFORWARD
%token KFUNCTION
%token KIF
%token KOF
%token KORD
%token KPRED
%token KPROCEDURE
%token KREAD
%token KRECORD
%token KREF
%token KREPEAT
%token KRETURN
%token KSTOP
%token KSUCC
%token KTHEN
%token KTO
%token KTYPE
%token KUNTIL
%token KVAR
%token KWHILE
%token KWRITE


%type <val> NUMBER
%type <val> Expression
%type <id> IDENTIFIER

%%

Program : OptConstantDecl OptTypeDecl OptVarDecl FuncOrProcDecl Block SPERIOD;

OptConstantDecl : KCONST SubConstantDecl
		;
	       
SubConstantDecl : IDENTIFIER SEQUAL Expression SSEMICOLON OptSubConstantDecl {std::cerr << "OptConstDecl";}
		;

OptSubConstantDecl : SubConstantDecl
		   |
		   ;

OptTypeDecl : KTYPE SubTypeDecl
	    |
	    ;
	   
SubTypeDecl : IDENTIFIER SEQUAL Type SSEMICOLON OptSubTypeDecl {std::cerr<<"TypeDecl";}
	    ;

OptSubTypeDecl : SubTypeDecl
	       |
	       ;

OptVarDecl : KVAR SubVarDecl
	   |
	   ;

SubVarDecl : IdentifierList SCOLON Type SSEMICOLON OptSubVarDecl {std::cerr<<"VarDecl"};

OptSubVarDecl : SubVarDecl
	      |
	      ;

FuncOrProcDecl : FunctionDecl
	       | ProcedureDecl
	       ;

ProcedureDecl : KPROCEDURE IDENTIFIER SOPENPAREN FormalParameters SCLOSEPAREN SSEMICOLON KFORWARD SSEMICOLON
	      | KPROCEDURE IDENTIFIER SOPENPAREN FormalParameters SCLOSEPAREN SSEMICOLON Body SSEMICOLON
	      ;

FunctionDecl : KFUNCTION IDENTIFIER SOPENPAREN FormalParameters SCLOSEPAREN SCOLON Type SSEMICOLON KFORWARD SSEMICOLON
	     | KFUNCTION IDENTIFIER SOPENPAREN FormalParameters SCLOSEPAREN SCOLON Type SSEMICOLON Body SSEMICOLON
	     ;

FormalParameters : VarOrRef IdentifierList SCOLON Type OptFormalParameter
		 |
		 ;
		
OptFormalParameter : SSEMICOLON VarOrRef IdentifierList SCOLON Type
		   | OptFormalParameter OptFormalParameter
		   ;

VarOrRef : KVAR
	 | KREF
	 | 
	 ;

Body : OptConstantDecl OptTypeDecl OptVarDecl Block;

Block : KBEGIN StatementSequence KEND;

OptTypeDecl : KTYPE IDENTIFIER SEQUAL Type SSEMICOLON OptSubTypeDecl
	    |
	    ;

OptSubTypeDecl : IDENTIFIER SEQUAL Type SSEMICOLON OptSubTypeDecl
	       |
	       ;

Type : SimpleType
     | RecordType
     | ArrayType
     ;

SimpleType : IDENTIFIER;

RecordType : KRECORD OptRecordType KEND;

OptRecordType : IdentifierList SCOLON Type SSEMICOLON OptRecordType
	      |
	      ;

ArrayType : KARRAY SOPENSQUARE Expression SCOLON Expression SCLOSESQUARE KOF Type;

IdentifierList : IDENTIFIER OptIdentifier;

OptIdentifier : SCOMMA IDENTIFIER OptIdentifier
	      |
	      ;

StatementSequence : Statement OptStatement;

OptStatement : SSEMICOLON Statement OptStatement
	     |
	     ;

Statement : Assignment
	  | IfStatement
	  | RepeatStatement
	  | ForStatement
	  | StopStatement
	  | ReturnStatement
	  | ReadStatement
	  | WriteStatement
	  | ProcedureCall
	  | NullStatement
	  ;

Assignment : LValue SCOLON SEQUAL Expression;

IfStatement : KIF Expression KTHEN StatementSequence OptElseIf OptElse KEND

OptElseIf : KELSEIF Expression KTHEN StatementSequence OptElseIf
	  |
	  ;

OptElse : KELSE StatementSequence
	|
	;

WhileStatement : KWHILE Expression KDO StatementSequence KEND;

RepeatStatement : KREPEAT StatementSequence KUNTIL Expression;

ForStatement : KFOR IDENTIFIER SCOLON SEQUAL Expression ToOrDownto Expression KDO StatementSequence KEND;

ToOrDownto : KTO
	   | KDOWNTO
	   ;

StopStatement : KSTOP;

ReturnStatement : KRETURN OptExpression;

ReadStatement : KREAD SOPENPAREN LValue OptLValue SCLOSEPAREN;

WriteStatement : KWRITE SOPENPAREN Expression OptAddExpression SCLOSEPAREN;

ProcedureCall : IDENTIFIER SOPENPAREN OptExpression SCLOSEPAREN;

NullStatement :;

Expression : Expression SPIPE Expression
	   | Expression SAMPERSAND Expression
	   | Expression SEQUAL Expression
	   | Expression SOPENANGLE SCLOSEANGLE Expression
	   | Expression SOPENANGLE SEQUAL Expression
	   | Expression SCLOSEANGLE SEQUAL Expression
	   | Expression SOPENANGLE Expression
	   | Expression SCLOSEANGLE Expression
	   | Expression SPLUS Expression
	   | Expression SMINUS Expression
	   | Expression SMULT Expression
	   | Expression SDIV Expression
	   | Expression SPERCENTAGE Expression
	   | STILDE Expression
	   | SMINUS Expression
	   | SOPENPAREN Expression SCLOSEPAREN
	   | IDENTIFIER SOPENPAREN Expression OptAddExpression SCLOSEPAREN
	   | KCHR SOPENPAREN Expression SCLOSEPAREN
	   | KORD SOPENPAREN Expression SCLOSEPAREN
	   | KPRED SOPENPAREN Expression SCLOSEPAREN
	   | KSUCC SOPENPAREN Expression SCLOSEPAREN
	   | LValue

OptLValue : LValue
	  |
	  ;

LValue : IDENTIFIER OptIdOrExpression;

OptIdOrExpression : SPERIOD IDENTIFIER
		  | SOPENSQUARE Expression SCLOSESQUARE
		  | 
		  ;

OptExpression : Expression
	      |
	      ;

OptAddExpression : SCOMMA Expression OptAddExpression
		 |
		 ;

%%

void yyerror(const char* msg)
{
  std::cerr << msg << std::endl;
}

