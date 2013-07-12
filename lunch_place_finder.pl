
:- consult(preferences).
:- consult(lunch_places).


have_lunch_at(People, Places, LongLunchOk) :-
  findall(X, place(X, People, LongLunchOk), Places).

place(Place, People, LongLunchOk) :-
    all_would_eat_at(People, Place),
    ok_location(Place, LongLunchOk).

ok_location(Place, LongLunchOk) :-
    not(LongLunchOk),
    not(far_away(Place)).
ok_location(_Place, LongLunchOk) :-
    LongLunchOk.

all_would_eat_at([], _).
all_would_eat_at([Person|Rest], Place) :-
  would_eat_at(Person, Place),
  all_would_eat_at(Rest, Place).


would_eat_at(Person, Place) :-
  restaurant(Place),
  fits_vegetarian_preferences(Person, Place),
  fits_general_preferences(Person, Place).

fits_vegetarian_preferences(Person, Place) :-
  vegetarian(Person),
  not(bad_for_vegetarians(Place)).

fits_vegetarian_preferences(Person, _) :-
  not(vegetarian(Person)).

fits_general_preferences(Person, Place) :-
  not(dislikes(Person, Place)).
