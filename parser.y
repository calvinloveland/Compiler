%{
#include <iostream>
#include <map>

#include "expressions/Expressions.hpp"
#include "symbol_table.hpp"

extern int yylex();
void yyerror(const char*);
%}

%union
{
float val;
char* id;
}

%token SNOTEQUAL
%token SLESSEQUAL
%token SGREATEREQUAL
%token SASSIGNMENT

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

%token IDENTIFIER
%token CHARACTER
%token STRING
%token NUMBER

%left SMULT
%left SDIV
%left SPLUS
%left SMINUS
%left SPERCENT
%left SAMPERSAND
%left SPIPE

%nonassoc SNOTEQUAL
%nonassoc SLESSEQUAL
%nonassoc SGREATEREQUAL
%nonassoc SOPENANGLE
%nonassoc SCLOSEANGLE
%nonassoc SEQUAL

%right UNARYMINUS
%right STILDE

%%

Program : OptConstantDecl OptTypeDecl OptVarDecl OptFuncOrProcDecl Block SPERIOD {std::cerr << "Program\n";};

OptConstantDecl : KCONST SubConstantDecl
		|
		;
	       
SubConstantDecl : IDENTIFIER SEQUAL Expression SSEMICOLON OptSubConstantDecl {std::cerr << "OptConstDecl\n";}
		;

OptSubConstantDecl : SubConstantDecl
		   |
		   ;

OptVarDecl : KVAR SubVarDecl
	   |
	   ;

SubVarDecl : IdentifierList SCOLON Type SSEMICOLON OptSubVarDecl {std::cerr<<"VarDecl\n";};

OptSubVarDecl : SubVarDecl
	      |
	      ;

OptFuncOrProcDecl : FunctionDecl OptFuncOrProcDecl
 	          | ProcedureDecl OptFuncOrProcDecl
		  |
	          ;

ProcedureDecl : KPROCEDURE IDENTIFIER SOPENPAREN FormalParameters SCLOSEPAREN SSEMICOLON KFORWARD SSEMICOLON
	      | KPROCEDURE IDENTIFIER SOPENPAREN FormalParameters SCLOSEPAREN SSEMICOLON Body SSEMICOLON
	      ;

FunctionDecl : KFUNCTION IDENTIFIER SOPENPAREN FormalParameters SCLOSEPAREN SCOLON Type SSEMICOLON KFORWARD SSEMICOLON
	     | KFUNCTION IDENTIFIER SOPENPAREN FormalParameters SCLOSEPAREN SCOLON Type SSEMICOLON Body SSEMICOLON
	     ;

FormalParameters : VarOrRef IdentifierList SCOLON Type OptFormalParameters
		 |
		 ;
		
OptFormalParameters : SSEMICOLON VarOrRef IdentifierList SCOLON Type OptFormalParameters
		    |
		    ;

VarOrRef : KVAR
	 | KREF
	 | 
	 ;

Body : OptConstantDecl OptTypeDecl OptVarDecl Block;

Block : KBEGIN StatementSequence KEND {std::cerr<<"Block\n";};

OptTypeDecl : KTYPE SubTypeDecl
	    |
	    ;

SubTypeDecl : IDENTIFIER SEQUAL Type SSEMICOLON SubTypeDecl
	       | IDENTIFIER SEQUAL Type SSEMICOLON
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

StatementSequence : Statement
		  | Statement SSEMICOLON StatementSequence
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
	  | WhileStatement
	  {std::cerr << "Statement\n";};

Assignment : LValue SASSIGNMENT Expression;

IfStatement : KIF Expression KTHEN StatementSequence OptElseIf OptElse KEND;

OptElseIf : KELSEIF Expression KTHEN StatementSequence OptElseIf
	  |
	  ;

OptElse : KELSE StatementSequence
	|
	;

WhileStatement : KWHILE Expression KDO StatementSequence KEND;

RepeatStatement : KREPEAT StatementSequence KUNTIL Expression;

ForStatement : KFOR IDENTIFIER SASSIGNMENT Expression ToOrDownto Expression KDO StatementSequence KEND;

ToOrDownto : KTO
	   | KDOWNTO
	   ;

StopStatement : KSTOP;

ReturnStatement : KRETURN OptExpression;

ReadStatement : KREAD SOPENPAREN LValue OptLValue SCLOSEPAREN;

WriteStatement : KWRITE SOPENPAREN Expression OptAddExpression SCLOSEPAREN {std::cerr<<"WriteStatement\n";};

ProcedureCall : IDENTIFIER SOPENPAREN OptExpressions SCLOSEPAREN;

NullStatement : {std::cerr<<"NullStatement\n";};

Expression : SMINUS Expression %prec UNARYMINUS
	   | Expression SPERCENTAGE Expression
	   | Expression SDIV Expression
	   | Expression SMULT Expression
	   | Expression SPLUS Expression
	   | Expression SMINUS Expression
	   | Expression SEQUAL Expression
	   | Expression SNOTEQUAL Expression
	   | Expression SGREATEREQUAL Expression
	   | Expression SLESSEQUAL Expression
	   | Expression SOPENANGLE Expression
	   | Expression SCLOSEANGLE Expression
	   | STILDE Expression
	   | Expression SAMPERSAND Expression
	   | Expression SPIPE Expression
	   | SOPENPAREN Expression SCLOSEPAREN
	   | IDENTIFIER SOPENPAREN OptExpressions SCLOSEPAREN
	   | KCHR SOPENPAREN Expression SCLOSEPAREN
	   | KORD SOPENPAREN Expression SCLOSEPAREN
	   | KPRED SOPENPAREN Expression SCLOSEPAREN
	   | KSUCC SOPENPAREN Expression SCLOSEPAREN
	   | LValue
	   | STRING
	   | CHARACTER
	   | NUMBER
	    {std::cerr<<"Expression\n";};

OptLValue : SCOMMA LValue OptLValue
	  |
	  ;


OptIdOrExpression : SPERIOD IDENTIFIER OptIdOrExpression
		  | SOPENSQUARE Expression SCLOSESQUARE OptIdOrExpression
		  | 
		  ;
OptExpressions : Expression OptAddExpression
	       |
	       ;

OptExpression : Expression
	      |
	      ;

OptAddExpression : SCOMMA Expression OptAddExpression
		 |
		 ;

LValue : IDENTIFIER OptIdOrExpression;

%%

void yyerror(const char* msg)
{
  std::cerr << msg << std::endl;
}

