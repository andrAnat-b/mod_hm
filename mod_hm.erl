-module(mod_hm).

-export([last/1]).
-export([last_two/1]).
-export([k_element/2]).
-export([element_qty/1]).
-export([reverse/1]).
-export([palindrome/1]).
-export([flatten/1]).
-export([eliminate/1]).
-export([pack/1]).
-export([encode/1]).
-export([encode_mod/1]).
-export([decode/1]).
-export([encode_direct/1]).
-export([duplicate/1]).
-export([replicate/2]).

%1.
last([X]) -> 
    io:format("last_elem:~w ~n", [X]),
    X;
last([H | T]) -> 
    io:format("~w ~n", [H]),
    last(T).

%2
last_two([X, Y]) -> 
    X,
    Y,
    [X, Y];
last_two([_|T]) ->
    last_two(T).

%3
k_element([X | _], 1) ->
    X;
k_element([_ | T], K) when K > 1 ->
    k_element(T, K-1).

%4
element_qty(List) ->
    element_qty(List, 0).

element_qty([], Qty) ->
    Qty;
element_qty([_| T], Qty) ->
    element_qty (T, Qty + 1).

%5
reverse(List) ->
    reverse(List,[]).
reverse([], Acum) ->
    Acum;
reverse([H | T], Acum) ->
    reverse(T, [H | Acum]).

%6
palindrome(List)->
    List == reverse_p(List).
reverse_p(List) ->
    reverse_p(List,[]).
reverse_p([], Acum) ->
    Acum;
reverse_p([H | T], Acum) ->
    reverse_p(T, [H | Acum]).

%7
flatten([]) ->
    [];
flatten([H | T]) when is_list(H) ->
    flatten(H) ++ flatten(T);
flatten([H | T]) ->
    [H | flatten(T)].

%8
eliminate([]) ->
    [];
eliminate([X]) ->
    [X];
eliminate([X, X | T]) ->
    eliminate([X | T]);
eliminate([X, Y | T]) ->
    [X | eliminate([Y | T])].

%9
pack([]) ->
    [];
pack([X]) ->
    [[X]];
pack([X, X | T]) ->
    [[X | hd(pack([X | T]))] | tl(pack([X | T]))];
pack([X, Y | T]) ->
    [[X] | pack([Y | T])].


%10
encode(List) ->
    Packed = pack(List),
    encode_packed(Packed).
encode_packed([]) ->
    [];
encode_packed([[H | T] | Rest]) ->
    [[length([H | T]), H] | encode_packed(Rest)].

%11
encode_mod(List) ->
    Packed = pack(List),
    encode_packed_modified(Packed).

encode_packed_modified([]) ->
    [];
encode_packed_modified([[H | T] | Rest]) ->
    case element_qty([H | T]) of
        1 -> 
            [H | encode_packed_modified(Rest)];
        N -> 
            [[N, H] | encode_packed_modified(Rest)]
    end.

%12
decode([]) ->
    [];
decode([[N, E] | T]) ->
    lists:duplicate(N, E) ++ decode(T); 
decode([E | T]) ->
    [E | decode(T)]. 

%13
encode_direct([]) -> 
    []; 

encode_direct([X | Xs]) -> 
    encode_direct(Xs, X, 1). 


encode_direct([], Current, Count) ->
    finalize(Current, Count); 


encode_direct([Current | Rest], Current, Count) ->
    encode_direct(Rest, Current, Count + 1);

encode_direct([Next | Rest], Current, Count) ->
    finalize(Current, Count) ++ encode_direct(Rest, Next, 1).


finalize(Current, 1) -> 
    [Current]; 
finalize(Current, Count) -> 
    [[Count, Current]]. 

%14
duplicate([]) ->
    [];
duplicate([X | T]) ->
    [X, X | duplicate(T)].

%15
replicate([], _) ->
    [];
replicate([X | T], N) ->
    repl(X, N) ++ replicate(T, N).
repl(_, 0) ->
    [];
repl(X, N) ->
    [X | repl(X, N - 1)].

