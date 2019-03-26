#pragma once

#include "statements/Statement.hpp"
#include "StatementSequence.hpp"
#include <vector>

namespace ast {
	class StatementSequence : public Node {
	public:
		StatementSequence(Statement *n) { add(n); }

		void add(Statement *n) { statements.push_back(n); }

		void emit(){
		    for(Statement* s : statements){
		    s->emit();
		}
		}

		std::vector<Statement *> statements;

	};


	StatementSequence *MakeStatementSequence(Statement *statement, StatementSequence *statementSequence);

    StatementSequence *MakeStatementSequence(Statement *statement);
}