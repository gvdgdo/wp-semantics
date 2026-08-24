%% copyright (c) 2026 Guido Governatori.

% an argument is either a natural argument or an imaginary argument
argument(X) :- naturalArgument(X).
argument(X) :- imaginaryArgument(X).

% for every atom X there ae two imaginary arguments per(X) and per(-(X))
% corresponding to the literal X and its negation -X
imaginaryArgument(per(X)) :- atom(X).
imaginaryArgument(per(-(X))) :- atom(X).

% every fact is an argument
naturalArgument(X) :- fact(X).

% a natural argument is build from a rule R such that there is an 
% argument for every element in the body of the rule 
naturalArgument((R,X)) :- rule(R,X), 
    hasArgument(Y) : body(R,Y).

% 'argument' is a unary predicate. Its argument is a 
% a literal for argument corresponding to facts, and imaginary 
% arguments, and a pair (R,X) for natural arguments, where R is a
% rule and X is the conclusion of the rule.

% the predicate hasArgument is use to specify that there is an
% argument for a literal X.
hasArgument(X) :- imaginaryArgument(X).
hasArgument(X) :- fact(X).
hasArgument(X) :- naturalArgument((R,X)).

% if there is a natural argument for an obligation, there is 
% also a natural argument for the permission of the same literal 
% with the same rule. This implements the D axioms of deontic logic.
naturalArgument((R,per(X))) :- naturalArgument((R,obl(X))).

%% every natural argument has itself as a proper subargument
subargument(A,A) :- naturalArgument(A).

%% A is a proper subargument of B
subargument(A,B) :- 
    B == (R,X), rule(R,X), body(R,Y), 
    argument(A), A == (R',Y).

subargument(A,B) :- 
    B == (R,X), rule(R,X), body(R,Y), 
    argument(A), A==Y.

subargument(A,B) :- 
    B == (R,X), rule(R,X), body(R,Y), 
    argument(A), A == (R',Y), rule(R',Y).   

subargument(A,B) :- 
    B == (R,X), rule(R,X), body(R,A), 
    fact(A).

subargument(A,B) :- 
    B == (R,per(X)), A == (R,obl(X)), argument(A), argument(B).

subargument(A,B) :- 
    subargument(A,C), subargument(C,B), A != B.

% A is a conclusion of argument B
% base conditions for facts and imaginary arguments
argumentConclusion(A,A) :- imaginaryArgument(A).
argumentConclusion(A,A) :- fact(A).
% base conditions for argument built from a rule
argumentConclusion(A,B) :- 
    B == (R,A), rule(R,A), argument(B).
% recursive conditions; an argument inherits the conclusions 
% of its subarguments
argumentConclusion(A,B) :-
    argument(B), subargument(C,B), argumentConclusion(A,C).

%% conflicting literals
% here is the list of the pairs of conflicting literals. 
% notice that permissions conflict with obligations but 
% not with other permissions. The conflict relation is symmetric. 
conflict(A,B) :- atom(A), B == -A.
conflict(A,B) :- A == obl(C), B == obl(-C), atom(C).
conflict(A,B) :- A == obl(C), B == per(-C), atom(C).
conflict(A,B) :- A == obl(-C), B == obl(C), atom(C).
conflict(A,B) :- A == obl(-C), B == per(C), atom(C).
conflict(A,B) :- A == obl(C), B == -A, atom(C). 
conflict(A,B) :- A == per(C), B == -A, atom(C). 
conflict(A,B) :- A == obl(-C), B == -A, atom(C). 
conflict(A,B) :- A == per(-C), B == -A, atom(C). 
conflict(A,B) :- conflict(B,A).

%% Attacks
% an argument for an obligation attacks the corresponding 
% imaginary argument for the negation of the obligation
attacks(A,B) :- naturalArgument(A), imaginaryArgument(B), 
    A == (R,X), conflict(X,B).
% a natural argument attacks another natural argument if the 
% conclusion of the first argument is in conflict with one of 
% the conclusions of the second argument, and the second argument
% is not a fact. 
attacks(A,B) :- naturalArgument(A), naturalArgument(B), not fact(B), 
    A == (R,X), argumentConclusion(C,B), conflict(X,C).
 