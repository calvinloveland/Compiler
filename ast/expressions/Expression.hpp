#pragma once

#include "../Node.hpp"

namespace ast {
    class Expression : public Node {
    public:
        Expression() {}

        Expression(Expression *left, Expression *right) {
            l = left;
            r = right;
        }

        bool isConst() { return false; }

        virtual float value();

        Expression *l;
        Expression *r;
    };
}
