#include "../shared/Node.hpp"

class Division : public Node
{
	public:
		Division(std::shared_ptr<Node> leftNode, std::shared_ptr<Node> rightNode) 
		{
			left = leftNode;
			right = rightNode;
		}
		void mips(){}
};
