
:- consult(preferences).
:- consult(lunch_places).


have_lunch_at(People, Places) :-
  findall(X, all_would_eat_at(People, X), Places).


all_would_eat_at([], _).
all_would_eat_at([Person|Rest], Place) :-
  would_eat_at(Person, Place),
  all_would_eat_at(Rest, Place).


would_eat_at(Person, Place) :-
  lunch_place(Place),
  fits_vegetarian_preferences(Person, Place),
  fits_general_preferences(Person, Place).

fits_vegetarian_preferences(Person, Place) :-
  vegetarian(Person),
  not(bad_for_vegetarians(Place)).

fits_vegetarian_preferences(Person, _) :-
  not(vegetarian(Person)).

fits_general_preferences(Person, Place) :-
  not(dislikes(Person, Place)).
