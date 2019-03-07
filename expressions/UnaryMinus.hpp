#include "../shared/Node.hpp"

class UnaryMinus : public Node
{
	public:
		UnaryMinus(std::shared_ptr<Node> rightNode) {right = rightNode;}
		void mips(){}
};
