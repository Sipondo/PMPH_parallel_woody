--Example code∷
--Apply operation k to ints x and y
--0: +
--1: -
--2: *
--3: /

let main (k : i32, x: i32, y: i32) : i32 =
  if      k == 0 then x + y -- zeros
  else if k == 1 then x - y   -- sorted
  else if k == 2 then x * y   -- same
  else x / y                  -- default
