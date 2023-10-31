(*
  This Tezos CameLIGO Smart Contract implements functionality that would allow a charity or
  non-profit foundation to raise / receive funds in the form of Tez.

  An organization sets up their receiving address by calling new_charity, which takes as parameters
  the name of the organization and a wallet address into which they can receive funds.

  Extension: A Charity may "Pause" their wallet_address, during which donations cannot be taken.

  IDEAS:
    * Implement `Pause` functionality
    * List charities functionality (as a View)
    * Sum donations across all charities ("total donations")
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
