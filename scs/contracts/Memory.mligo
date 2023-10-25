#include "./Util.mligo"

type action = NewGame of int list | PlayTurn of int list
type status = Playing | Won | Lost

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

let play_turn (s:storage) (caller: address) (guess: int list) : storage =
    let game_state = Map.find caller s in
    let new_status = match is_prefix_match guess game_state.sequence with
        | true -> Playing
        | false -> Lost
    in
    // Only increment level if still Playing (so: their score)
    let next_level = game_state.level + bool_to_int (new_status = Playing) in
    let game_state = { game_state with level = next_level; status = new_status } in
    Map.add caller game_state s

let main (p : action) (s : storage) : operation list * storage =
    let caller = Tezos.get_sender() in
    match p with
        | NewGame initial_value ->
            let new_storage = init_new_game s caller initial_value in
            ([], new_storage)
        | PlayTurn guess ->
            let new_storage = play_turn s caller guess in
            ([], new_storage)
