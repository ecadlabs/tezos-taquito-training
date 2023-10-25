#include "./Memory.mligo"

let _print_header = Test.println("Testing Memory.mligo contract....")

// A test player for our game. A player is an address, typically a wallet the dApp connects to.
let alice = Test.nth_bootstrap_account 1

let initial_storage = {
    // Level increments with each successive play
    level = 0;
    // The sequence the player must repeat, passed into the contract
    sequence = ([] : int list);
}

let test_new_game =
    let initial_sequence = [2;1;3] in
    // Initialize a new game with the initial_sequence to remember
    let initial_storage = init_new_game Map.empty alice initial_sequence in
    let actual_game_state = match Map.find_opt alice initial_storage with
        | Some game_state -> game_state
        | None -> failwith "Game state not found" in
    let expected_game_state = { level = 0; sequence = initial_sequence; status = Playing } in
    // The difference between Test.assert and assert is nominal
    Test.assert(actual_game_state = expected_game_state)
    // You can also use an explicit message if you prefer:
    // if (actual_game_state <> expected_game_state) then Test.failwith "Initialization failure"

let test_play_first_turn_success =
    let sequence = [2;3;2;1] in
    let game = init_new_game Map.empty alice sequence in
    // Alice correctly plays her first_turn
    let first_turn = [2] in
    let game = play_turn game alice first_turn in
    let actual_game_state = match Map.find_opt alice game with
        | Some game_state -> game_state
        | None -> failwith "Game state not found" in
    let _ = Test.assert(actual_game_state.level = 1) in
    let _ = Test.assert(actual_game_state.status = Playing) in
    Test.assert(actual_game_state.sequence = sequence)
