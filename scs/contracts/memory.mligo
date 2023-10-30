(*
  This Tezos CameLIGO Smart Contract implements a simple memory game.

  Glossary of Terms:

    Attempt: The list submitted when playing a turn (could be correct or incorrect)
    Sequence: The sequence to match, generated when a new game is initialized
    Level: Starts at 0 and incremented for each successively correct Attempt
    Status: Won, Lost or Playing

  TODO:
    * Prevent further play if Status is Lost or Won

  Copyright © 2023 ECAD Labs Inc. See the LICENSE file at top-level for details.
*)

#include "./util.mligo"

type action = NewGame of int list | PlayTurn of int list
type status = Playing | Won | Lost

let _status_to_string (s: status) : string =
    match s with
    | Playing -> "Playing"
    | Won -> "Won"
    | Lost -> "Lost"

type game_state = {
    // Equates to Score, as it's only incremented with a successful `play_turn`
    level : int;
    // The memory sequence to match
    sequence : int list;
    status: status;
}

type storage = (address, game_state) map

let init_new_game (s: storage) (caller: address) (seq: int list) : storage =
    let initial_game_state = { level = 0; sequence = seq; status = Playing } in
    Map.add caller initial_game_state s

// Given an attempt and sequence, evaluate its Status
let _calculate_status (attempt: int list) (sequence: int list) : status =
  let rec status_helper (att: int list) (seq: int list): status =
    match (att, seq) with
    | ([], []) -> Won  // attempt, sequence lists exhausted w/o mistakes: Win!
    | ([], _::_) -> Playing // done: this attempt completed without mistakes
    | (_, []) -> Playing // return! no mistakes made
    | (atth::attt, seqh::seqt) ->
        if atth <> seqh then Lost else status_helper attt seqt // heads are the same, recurse; otherwise, Lost
  in
  status_helper attempt sequence

let play_turn (s: storage) (caller: address) (attempt: int list) : storage =
    let game_state = Map.find caller s in
    let new_status = _calculate_status game_state.sequence attempt in
    let next_level = game_state.level + bool_to_int (new_status <> Lost) in
    let game_state = { game_state with level = next_level; status = new_status } in
    Map.add caller game_state s

let main (p : action) (s : storage) : operation list * storage =
    let caller = Tezos.get_sender() in
    match p with
        | NewGame initial_value ->
            let new_storage = init_new_game s caller initial_value in
            ([], new_storage)
        | PlayTurn attempt ->
            let new_storage = play_turn s caller attempt in
            ([], new_storage)
