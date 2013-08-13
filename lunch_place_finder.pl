
:- consult(preferences).
:- consult(lunch_places).


have_lunch_at(People, Places) :-
  nonvar(People),
  setof(Y, foreach(member(X, People), (would_eat_at(X, Y), not(time_consuming(Y)))), Places),
  !.
have_lunch_at(People, Places) :-
  nonvar(Places),
  setof(X, foreach(member(Y, Places), (person(X), would_eat_at(X, Y))), People),
  !.

have_lunch_at(People, Places, LongLunchOk) :-
  nonvar(People),
  setof(Y, foreach(member(X, People), (would_eat_at(X, Y), location_ok(Y, LongLunchOk))), Places),
  !.

location_ok(Place, LongLunchOk) :-
    not(LongLunchOk),
    not(time_consuming(Place)).
location_ok(_Place, LongLunchOk) :-
    LongLunchOk.

would_eat_at(Person, Place) :-
  restaurant(Place),
  fits_vegetarian_preferences(Person, Place),
  fits_general_preferences(Person, Place).

fits_vegetarian_preferences(Person, _) :-
  not(vegetarian(Person)).
fits_vegetarian_preferences(Person, Place) :-
  vegetarian(Person),
  not(bad_for_vegetarians(Place)).

fits_general_preferences(Person, Place) :-
  not(dislikes(Person, Place)).
