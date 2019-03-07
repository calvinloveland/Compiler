#pragma once

#include "../Node.hpp"

class Expression : public Node
{
  public:
     bool isConst(){ return false;}
};
