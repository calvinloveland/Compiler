#pragma once

#include "Node.hpp"
#include "StatementSequence.hpp"

namespace ast {
	class Block : public Node {
	public:
		Block(StatementSequence *sl) : statementList(sl) {}
		void emit(){statementList->emit();}
		StatementSequence *statementList;
	};
}