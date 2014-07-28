%:- use_module(library(clpfd)).

dev(bryan).
dev(bill).
dev(brad).
dev(tim).
dev(angello).
dev(jimmy).
dev(evan).
dev(pawan).
nondev(joelle).
nondev(bobby).
nondev(juan).
nondev(dana).
nondev(josh).
nondev(nick).
nondev(krishna).
nondev(emily).
nondev(diana).
nondev(rick).
 
blocked(juan, dana).
blocked(juan, emily).
blocked(dana, emily).
 
blocked(joelle, josh).
blocked(joelle, nick).
blocked(joelle, diana).
blocked(josh, nick).
blocked(josh, diana).
blocked(nick, diana).
 
blocked(bryan, bill).
blocked(bryan, tim).
 
blocked(angello, brad).
 
blocked(bobby, nick).
blocked(bobby, jimmy).
 
people(People) :- findall(X, (dev(X) ; nondev(X)), People).
alldevs(Devs) :-  findall(X, dev(X), Devs).
allnondevs(Nondevs) :-  findall(X, nondev(X), Nondevs).
 
valid_team_of_three((X, Y, Z)) :-
        dev(X), nondev(Y), (dev(Z) ; nondev(Z)),
        \+(X=Z), \+(Y=Z),
        \+(blocked(X, Y)), \+(blocked(X, Z)), \+(blocked(Y, Z)).
 
valid_team_of_four((W, X, Y, Z)) :-
                dev(X), nondev(Y), (dev(Z) ; nondev(Z)), (dev(W) ; nondev(W)),
                X \=Z, Y \=Z, X \=W, Y \=W, W \=Z,
                \+(blocked(X, Y)), \+(blocked(X, Z)), \+(blocked(Y, Z)),
                \+(blocked(X, W)), \+(blocked(Y, W)), \+(blocked(Z, W)).
                               
valid_teams([]).
valid_teams([Head|Tail]) :-
        valid_team_of_three(Head),
 		% valid_team_of_four(Head)),
        valid_teams(Tail).
       
on_team(Player, (X, Y, Z)) :-
write(X),
write(Y),write(Z),
        (Player = X; Player = Y; Player = Z).
 
%on_team(Player, (W, X, Y, Z)) :-
%        Player = W; Player = X; Player = Y; Player = Z.

on_a_team(_, []).       
on_a_team(Player, [Head|Tail]) :-
%	write(Player),
    on_team(Player, Head),
    on_a_team(Player, Tail).
       
players_on_teams([], _).
players_on_teams([Head|Tail], Teams) :-
    on_a_team(Head, Teams),
    players_on_teams(Tail, Teams).
       
everyone_plays(Teams) :-
        findall(X, (dev(X) ; nondev(X)), Players),
        players_on_teams(Players, Teams).
 
valid_teams_and_size(List) :-
%       findall(X, (dev(X) ; nondev(X)), People),
%       length(People, Length),
        length(List, 6),
%       length(List, div(18, 3)), % prefer teams of three over teams of four
        valid_teams(List),
%       flatten(Diff, List),
%       all_different(Diff). % player can't be on two teams'
		everyone_plays(List).
		