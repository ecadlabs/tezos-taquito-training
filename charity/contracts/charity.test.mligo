(*
  Test file for the `charity.mligo` Tezos CameLIGO smart contract; see that file for more info.

  Copyright © 2023 ECAD Labs Inc. See the LICENSE file at top-level for details.
*)
#include "./charity.mligo"

let _print_header = Test.println("Testing charity.mligo Smart Contract....")

// Common test decls gasp
let wonderful_org = "TheWonderfulCharity.org"
let wonderful_wallet = Test.nth_bootstrap_account 1

let test_new_charity =
    let initial_storage: storage = Map.empty in
    let _,new_storage = main (NewCharity (wonderful_org, wonderful_wallet)) initial_storage in
    // TODO Preferably get storage from contract (n.b. contingent on Test.originate)
    let expected_storage = Map.add wonderful_org wonderful_wallet initial_storage in
    assert (new_storage = expected_storage)
