#pragma once

#include "../Node.hpp"
#include <iostream>

namespace ast{
class Statement: public Node{
public:
    virtual void emit(){
        std::cout << "PUT MIPS HERE";
    }
};
}
