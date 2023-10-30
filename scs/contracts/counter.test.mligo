(*
  Test the pedagogical counter contract.
*)

#import "./counter.mligo" "C"

let test =
  let {addr;code=_;size=_} = Test.originate (contract_of C.Counter) 0 (0tez) in
  let _ = Test.transfer_exn addr (Increment 42) (0tez) in
  assert (42 = Test.get_storage(addr))
