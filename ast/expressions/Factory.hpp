#pragma once

#include "Addition.hpp"
#include "Division.hpp"
#include "Subtraction.hpp"
#include "Multiplication.hpp"

Addition makeAdd(Expression* l, Expression *r){

	if(l->isConst() && r->isConst()){
		return new Value(l->value() + r->value());
}
else{
	return new Addition(l,r);
}

}

Addition makeMult(Expression* l, Expression *r){

	if(l->isConst() && r->isConst()){
		return new Value(l->value() * r->value());
}
else{
	return new Multiplication(l,r);
}


}


Division makeDiv(Expression* l, Expression *r){

	if(l->isConst() && r->isConst()){
		return new Value(l->value() / r->value());
}
else{
	return new Division(l,r);
}

}

Addition makeSub(Expression* l, Expression *r){

	if(l->isConst() && r->isConst()){
		return new Value(l->value() - r->value());
}
else{
	return new Subtraction(l,r);
}

}
