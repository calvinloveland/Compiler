#include "Node.hpp"

namespace ast {
	class Block : public Node {
	public:
		Block(Node *sl) : statementList(sl) {}

		Node *statementList;
	};
}