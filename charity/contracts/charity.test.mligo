(*
  Test file for the `charity.mligo` Tezos CameLIGO smart contract; see that file for more info.

  Copyright © 2023 ECAD Labs Inc. See the LICENSE file at top-level for details.
*)
#import "./charity.mligo" "C"

let _print_header = Test.println("Testing charity.mligo Smart Contract....")

let test_originate =
    let {addr;code=_;size=_} = Test.originate (contract_of C.Charity) Map.empty (0tez) in
    let expected_storage: C.Charity.storage = Map.empty in
    assert (expected_storage = Test.get_storage addr)
