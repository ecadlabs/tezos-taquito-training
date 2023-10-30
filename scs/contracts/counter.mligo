(*
  Pedagogical Counter contract from:
      https://ligolang.org/docs/advanced/first-contract?lang=cameligo#a-counter-contract

  Source `go.sh` to experiment with CLI facilities for this contract.
*)

type storage = int
type result = operation list * storage

[@entry]
let increment (n : int) (store : storage) : result =
    [], store + n

[@entry]
let decrement (n : int) (store : storage) : result =
    [], store - n

[@view]
let v1 (n : int) (store : storage) : int =
    store + n
