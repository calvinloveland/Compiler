#include "../shared/Node.hpp"

class Multiplication : public Node
{
	public:
		Multiplication(std::shared_ptr<Node> leftNode, std::shared_ptr<Node> rightNode) 
		{
			left = leftNode;
			right = rightNode;
		}
		void mips(){}
};
