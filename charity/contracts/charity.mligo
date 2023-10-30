(*
  This Tezos CameLIGO Smart Contract implements functionality that would allow a charity or
  non-profit foundation to raise / receive funds in the form of Tez.

  An organization sets up their receiving address by creating a new instance of the Charity
  contract, which takes as parameters the name of the organization and their wallet address and
  returns the address of the newly-created contract.

  The Factory that creates the Charity contract keeps a mapping between the organization and the
  Charity contracts they create. This is so that it is possible to write a single over-arching UI
  that would afford users to select the charity of their choice: everybody wins.

  Glossary of Terms:

    Charity: The organization that wishes to receive funds
    CharityContract: The contract that receives the funds on behalf of the Charity
    Factory: The over-arching creator of all Charity contracts, and tracks all instances
    Paused: Whether or not the contract is currently active (true or false)

  TODO:
    * Almost all of it. Ha!

  Copyright © 2023 ECAD Labs Inc. See the LICENSE file at top-level for details.
*)

type organization = string
type wallet_address = address

type action = NewCharity of organization * wallet_address

// Map of organizations to their receiving wallet addresses
type storage = (organization, wallet_address) map

type retval = operation list * storage

let new_charity (data : organization * wallet_address) (store : storage) : retval =
    let (org, receiver) = data in
    [], Map.add org receiver store

let main (p : action) (store : storage) : retval =
    match p with
    | NewCharity data -> new_charity data store
