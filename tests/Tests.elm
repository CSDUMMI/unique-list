module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple3)
import List.Unique exposing (..)


all : Test
all =
    describe "List.Unique"
        [ describe "toList, fromList"
            [ test "list is the same after toList and fromList" <|
                \() ->
                    Expect.true 
                        "(List.Unique.toList <| List.Unique.fromList [ 1, 2, 3 ]) == [ 1, 2, 3 ]"
                        ((toList <| fromList [ 1, 2, 3 ]) == [ 1, 2, 3 ])
            , test "toList removed duplicates" <|
                \() ->
                    Expect.true
                        "(toList <| fromList [ 1, 1, 2, 3 ]) == [ 1, 2, 3 ]"
                        ((toList <| fromList [ 1, 1, 2, 3 ]) == [ 1, 2, 3 ])
            , test "empty toList is an empty list" <|
                \() ->
                    Expect.equal (toList empty) []
            , test "remove 'a' from alphabet" <|
                \() ->
                    Expect.equal
                        ((toList << remove 'a') (fromList ['a', 'b', 'c']))
                         ['b', 'c']
            , test "remove 'b' from alphabet" <|
                \() ->
                    Expect.equal
                        ((toList << remove 'b') (fromList ['a', 'b', 'c']))
                         ['a', 'c']
            , test "'a' is added to beginning" <|
                \() ->
                    Expect.equal
                        ((toList << (addFirst 'a')) (fromList [ 'b', 'c']))
                        [ 'a', 'b', 'c' ]
            , test "addBefore, 'a' is added to before 'b'" <|
                \() ->
                    Expect.equal
                        ((toList << addBefore 'b' 'a') (fromList [ 'b', 'c']))
                        [ 'a', 'b', 'c' ]
            , test "'b' is added after 'a'" <|
                \() ->
                    Expect.equal
                        ((toList << ('b' |> addAfter 'a')) (fromList [ 'a', 'c' ]))
                        [ 'a', 'b', 'c' ]
            , test "'a' is before 'b'" <|
                \() ->
                    Expect.equal (isBefore 'b' 'a' (fromList [ 'a', 'b', 'c' ]))
                    (Just True)
            , test "'z' is before 'b' in abc (should be Nothing)" <|
                \() ->
                    Expect.equal (isBefore 'b' 'z' (fromList ['a', 'b', 'c'])) 
                    Nothing
            ]
        ]

