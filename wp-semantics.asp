%% Copyright (c) 2026, Guido Governatori.

% An argument is supported (by the support extension) is all its 
% proper subarguments are in the support extension. This also
% means that an argument is supported if all its proper 
% subarguments are justified.
supported(A) :- argument(A),
    justified(B) : subargument(B,A), B != A.

% An argument is undercut if there is a proper subargument that is
% attacked by a supported argument.
undercut(A) :- argument(A),
    subargument(B,A), B!=A, naturalArgument(B),
    argument(C), supported(C), attacks(C,B).

% An imaginary argument is justified if all the arguments that 
% attack it are rejected.
justified(A) :- imaginaryArgument(A), 
    rejected(B) : argument(B), attacks(B,A).

% A natural argument is justified if it is supported and all the
% arguments that attack it are undercut
justified(A) :- naturalArgument(A), supported(A), 
    undercut(B) : attacks(B,A).
% An imaginary argument is rejected if there is a justified 
% argument that attacks it.
rejected(A) :- imaginaryArgument(A),
    justified(B), attacks(B,A).

% A natural argument is rejected if one of its proper subargument 
% is rejected, 
rejected(A) :- naturalArgument(A), 
    subargument(B,A), A != B, rejected(B).
% or if there is a a supported argument that attacks it. 
rejected(A) :- naturalArgument(A), 
    supported(B), attacks(B,A).

% an imaginary argument does not attack any argument
:- argument(A), imaginaryArgument(B), attacks(B,A).
% imaginary arguments do not have proper subarguments
:- imaginaryArgument(A), subargument(B,A), A != B.
