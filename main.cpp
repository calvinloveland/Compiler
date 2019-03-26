#include "symbol_table.hpp"
#include "ast/Program.hpp"
#include "globals.hpp"
#include <iostream>


extern int yyparse();


int main()
{
  yyparse();
  std::cerr << "Done parsing. Now emitting";
  pNode->emit();
};
