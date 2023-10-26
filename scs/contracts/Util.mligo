// Convert a boolean to an integer
let bool_to_int b = if b then 1 else 0

let test_bool_to_int_true =
  Test.assert (bool_to_int true = 1)

let test_bool_to_int_false =
  Test.assert (bool_to_int false = 0)

// Determines if `guess` is a "prefix match" of `sequence`
let is_prefix_match (guess: int list) (sequence: int list) : bool =
    let rec prefix_helper (g: int list) (s: int list): bool =
        match (g, s) with
        | ([], _) -> true
        | (_, []) -> false
        | (gh::gt, sh::st) -> if gh = sh then prefix_helper gt st else false
    in
    prefix_helper guess sequence

let test_prefix_match_exact_sequence =
    Test.assert(is_prefix_match [1; 2; 3; 4] [1; 2; 3; 4])

let test_prefix_match_partial_sequence () =
    Test.assert(is_prefix_match [1; 2] [1; 2; 3; 4])

let test_prefix_match_incorrect_sequence () =
    Test.assert(is_prefix_match [1; 3] [1; 2; 3; 4])

let test_prefix_match_empty_sequence () =
    Test.assert(is_prefix_match [] [1; 2; 3; 4])

let test_prefix_match_longer_sequence () =
    Test.assert(is_prefix_match [1; 2; 3; 4; 5] [1; 2; 3; 4])

type int_string_map = (int, string) map
let int_string_map: int_string_map = Map.literal[(0, "0"); (1, "1"); (2, "2"); (3, "3"); (4, "4"); (5, "5"); (6, "6"); (7, "7"); (8, "8"); (9, "9")]

let _digit_to_string (key: int): string =
  match Map.find_opt key int_string_map with
    Some str -> str
  | None -> (failwith "Not found": string)

let rec _int_to_str ((x, str): int * string) : string =
    if (x < 10) then
       _digit_to_string(x) ^ str
    else
        _int_to_str((
        x / 10,
        _digit_to_string(int(x mod 10)) ^ str))

// Yup: CameLIGO has no built-in int_to_str
let int_to_str (x: int) : string =
    _int_to_str(x, "")

// Use it like this:
// let _ = Test.println("Got level: " ^ (int_to_str game_state.level)) in
