dev(bryan).
dev(brad).
dev(tim).
dev(angello).
dev(jimmy).
dev(evan).
dev(pawan).
dev(matt).
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
nondev(justin).

blocked(juan, dana).
blocked(juan, emily).
blocked(dana, emily).

blocked(joelle, josh).
blocked(joelle, nick).
blocked(joelle, diana).
blocked(josh, nick).
blocked(josh, diana).
blocked(nick, diana).

blocked(bryan, tim).
blocked(bryan, angello).
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
		\+(X=Z), \+(Y=Z), \+(X=W), \+(Y=W), \+(W=Z),
		\+(blocked(X, Y)), \+(blocked(X, Z)), \+(blocked(Y, Z)),
		\+(blocked(X, W)), \+(blocked(Y, W)), \+(blocked(Z, W)).
				
valid_teams([]).
valid_teams([Head|Tail]) :-
	valid_team_of_three(Head) ; valid_team_of_four(Head),
	valid_teams(Tail).

%valid_teams_from_list([], Players).
%valid_teams_from_list([Head|Tail]) :-
%	valid_team_of_three(Head) ; valid_team_of_four(Head),
%	valid_teams(Tail).

	
valid_teams_and_size(List) :-
%	flatten(X, List),
%	all_different(X), % player can't be on two teams'
%	findall(X, (dev(X) ; nondev(X)), People),
%	length(People, Length),
	length(List, 6),
%	length(List, div(18, 3)), % prefer teams of three over teams of four
	valid_teams(List).

%team_fits_player(Team, Player, NewTeam) :-
%	append(Team, Player, NewTeam)
%	valid_team_of_three(Team).

team_fits_player(_, _).
	
place_player([], _).
place_player([Head|Tail], Player) :-
	team_fits_player(Head, Player),
	place_player(Tail, Player).

place_players(_, []).
place_players(Teams, [Head|Tail]) :-
	place_player(Teams, Head),
	place_players(Teams, Tail).

form_teams(Teams) :-
	findall(X, (dev(X) ; nondev(X)), People),
	random_permutation(Players, People),
	place_players(Teams, Players).

rand_players(Players) :-
	findall(X, (dev(X) ; nondev(X)), People),
	random_permutation(Players, People).

doit(Teams) :-
	findall(X, (dev(X) ; nondev(X)), People),
	random_permutation(Players, People),
	valid_teams(Players).
	
	
	
%random_permutation(Rand, List).
