#include "Node.hpp"

namespace ast {
	class Program : public Node {
	public:
		Program(Node *b) : block(b) {}

		Node *block;
	};
}