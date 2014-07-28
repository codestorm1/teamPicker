dev(joe).
dev(jim).
dev(ron).
dev(jim).
dev(harry).
dev(tom).
dev(nerd).
dev(vince).
nondev(jenny).
nondev(janie).
nondev(nancy).
nondev(kelly).
nondev(josh).
nondev(nick).
nondev(larry).
nondev(emily).
nondev(diana).
nondev(rick).

blocked(rick, diana).
blocked(rick, emily).

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
	(valid_team_of_three(Head) ; valid_team_of_four(Head)),
	valid_teams(Tail).
	
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

team_fits_player((X, Y, Z), _).
	
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
	
	
%random_permutation(Rand, List).
