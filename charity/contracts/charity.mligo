(*
  This Tezos CameLIGO Smart Contract implements functionality that would allow a charity or
  non-profit foundation to raise / receive funds in the form of Tez.

  An organization sets up their receiving address by creating a new instance of the Charity
  contract, which takes as parameters the name of the organization and their wallet address and
  returns the address of the newly-created contract.

  Glossary of Terms:

    Charity: The organization that wishes to receive funds
    Paused: Whether or not the contract is currently active (true or false)

  TODO:
    * Paused functionality
    * List charities functionality

  IDEAS:
    * Refactor new_charity to take Option(address) and use Sender if None

  Copyright © 2023 ECAD Labs Inc. See the LICENSE file at top-level for details.
*)

module Charity = struct
    // Note: ligo wants declarations before their usage
    type organization = string
    type wallet_address = address

    // Map organizations to their (receiving) wallet addresses
    type storage = (organization, wallet_address) map

    type result = operation list * storage

    [@entry]
    let new_charity (data : string * address) (store : storage) : result =
        let (org, addr) = data in
        [], Map.add org addr store
end
