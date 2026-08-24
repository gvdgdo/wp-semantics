% Copyright (c) 2026, Guido Governatori.

% clingraph definitions for the visualisation of a 
% WP-argumentation framework

node(X) :- argument(X).
edge((X,Y)) :- attacks(X,Y).
edge((X,Y)) :- subargument(X,Y), X!= Y.

attr(node,X,shape,square) :- imaginaryArgument(X).
attr(node,X,shape,circle) :- naturalArgument(X).
attr(node,X,style,filled) :- node(X).
attr(node,X,fillcolor,red) :- rejected(X).
attr(node,X,fillcolor,green) :- justified(X).
attr(edge,(X,Y),style,dashed) :- subargument(X,Y), X!= Y.
attr(edge,(X,Y),style,solid) :- attacks(X,Y).
