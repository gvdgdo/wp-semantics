# A Novel Deontic Argumentation Semantics

This repository contains an Answer Set Programming implementation of the novel WP-semantics for Deontic Argumentation.

The main feature of the WP-sematnics is its ability to handle weak permission (in paticuler in the presence of deontic conflicts). 

The wp-semantics is a bipolar sceptical semantics and  assumes two types of arguments: _natural arguments_ and _imaginary arguments_. The semantics adopts two relationships among arguments: _attack_ and _sub-argument_. Thus, given two argumetns $A$ and $B$, we can have that $A$ attacks $B$ (written as $A > B$), and we can have that argument $C$ is a sub-argument of $A$ ( $C\in Sub(A)$ ).

__Definition (Support)__
An set of argument $S$ _supports_ an argument $A$ if every proper subargument of $A$ is in $S$.

__Definition (Undercut)__
A set of arguments $S$ _undercuts_ an argument $B$ if $S$ supports an argument $A$ that attacks a proper natural subargument of $B$. 

__Definition (wp-Acceptable)__
An argument $A$ is _wp-acceptable_ by the sets of arguments $R$ and $S$ iff

1. $A$ is an imaginary argument and $\forall B\in Args$, $B>A$, $B$ is wp-rejected by $R$ and $S$; or
2.  $A$ is a natural argument, $S$ supports $A$, and $\forall C\in Args$, $C>A$, $S$ undercuts $C$. 


__Definition (wp-Rejected)__
An argument $A$ is \emph{wp-rejected} by the sets of arguments $R$ and $S$ iff

1. $A$ is an imaginary argument and $\exists B\in Args$, $B>A$, $B\in S$; or
2. $A$ is a natural argument and 
   1. $\exists B\in Sub(A)$, $B\neq A$, and $B\in R$; or
   2. $\exists B\in Args$, $B>A$, and $S$ supports $B$.

__Definition (wp-extension)__
The \emph{wp-extension} of a Deontic Argumentation Theory $T$ is the pair

$$(JArgs,RArgs)$$

such that 

$$
JArgs=\bigcup_{i=1}^{\infty}J^T_i \qquad\qquad
RArgs=\bigcup_{i=1}^{\infty}R^T_i
$$

- $J^T_0=\emptyset$; $R^T_0=\emptyset$;
- $J^T_{n+1}=\{ A\in Args: A \text{ is wp-acceptable by } R^T_n \text{ and } J^T_n\}$;
- $R^T_{n+1}= \{A\in Args: A \text{ is wp-rejected by } R^T_n \text{ and } J^T_n \}$.

  
