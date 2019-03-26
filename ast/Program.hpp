#pragma once

#include "Node.hpp"
#include "Block.hpp"
#include <iostream>

namespace ast {
	class Program : public Node {
	public:
		Program(Block *b) : block(b){}
		void emit(){std::cerr<<"Emitting Program"; block->emit();}
		Block *block;
	};



}