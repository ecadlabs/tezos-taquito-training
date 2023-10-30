(*
  Pedagogical Counter contract from ligolang.org (https://is.gd/NhbyWV).

  Source `go.sh` to experiment with CLI facilities for this contract.
*)

module Counter = struct
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
end
