#include "Node.hpp"
#include <vector>

namespace ast {
	class StatementSequence : public Node {
	public:
		StatementSequence(Node *n) { add(n); }

		void add(Node *n) { statements.push_back(n); }

		std::vector<Node *> statements;

	};


	StatementSequence *MakeStatementSequence(Node *statement, Node *statementSequence) {
		StatementSequence *ss = dynamic_cast<StatementSequence *>(statementSequence);
		if (ss) {
			ss->add(statement);
			return ss;

		} else {
			return new StatementSequence(statement);
		}

	}
}