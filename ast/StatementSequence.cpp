#include "StatementSequence.hpp"

namespace ast {
    StatementSequence *MakeStatementSequence(Statement *statement, StatementSequence *statementSequence) {
        if (statementSequence) {
            statementSequence->add(statement);
            return statementSequence;

        } else {
            return new StatementSequence(statement);
        }
    }

    StatementSequence *MakeStatementSequence(Statement *statement) {
        return new StatementSequence(statement);
    }
}