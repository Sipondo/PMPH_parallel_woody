--solve a tree

let main (k : i32, x: i32) : bool =
  if      k == 1 then x == 0 -- zeros
  else if k == 2 then true   -- sorted
  else if k == 3 then true   -- same
  else true                  -- default
