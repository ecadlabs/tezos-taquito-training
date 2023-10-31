(*
  Test the pedagogical counter contract. See https://is.gd/GQ8PlJ.
*)

#import "./counter.mligo" "C"

let _print_header = Test.println("Testing counter.mligo Smart Contract....")

let test =
  let {addr;code=_;size=_} = Test.originate (contract_of C.Counter) 0 (0tez) in
  let _ = Test.transfer_exn addr (Increment 42) (0tez) in
  assert (42 = Test.get_storage(addr))
