(*
  Test file for the `charity.mligo` Tezos CameLIGO smart contract; see that file for more info.

  Copyright © 2023 ECAD Labs Inc. See the LICENSE file at top-level for details.
*)
#import "./charity.mligo" "C"

let _print_header = Test.println("Testing charity.mligo Smart Contract....")

// Common/global test decls
let wonderful_org = "TheWonderfulCharity.org"
let wonderful_wallet = Test.nth_bootstrap_account 1
let environment_org = "BlueEnvironment.org"
let environment_wallet = ("tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb": address)

let test_originate =
    let {addr;code=_;size=_} = Test.originate (contract_of C.Charity) Map.empty (0tez) in
    let expected_storage: C.Charity.storage = Map.empty in
    assert (expected_storage = Test.get_storage addr)

let test_new_charity =
    let {addr;code=_;size=_} = Test.originate (contract_of C.Charity) Map.empty (0tez) in
    let _ = Test.transfer_exn addr (New_charity (wonderful_org, wonderful_wallet)) (0tez) in
    let expected_storage = Map.add wonderful_org wonderful_wallet Map.empty in
    assert (expected_storage = Test.get_storage(addr))

let test_two_charities =
    let {addr;code=_;size=_} = Test.originate (contract_of C.Charity) Map.empty (0tez) in
    let _ = Test.transfer_exn addr (New_charity (wonderful_org, wonderful_wallet)) (0tez) in
    let _ = Test.transfer_exn addr (New_charity (environment_org, environment_wallet)) (0tez) in
    let actual_storage = Test.get_storage addr in
    let found_wonderful = Map.find_opt wonderful_org actual_storage in
    let expected_address = Some (wonderful_wallet) in
    let _ = Test.assert (found_wonderful = expected_address) in
    let found_environment = Map.find_opt environment_org actual_storage in
    let expected_address = Some (environment_wallet) in
    Test.assert(found_environment = expected_address)
