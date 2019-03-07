#include <memory>

class Node
{
  public:
	  std::shared_ptr<Node> left;
	  std::shared_ptr<Node> right;
	  virtual void mips();
};
