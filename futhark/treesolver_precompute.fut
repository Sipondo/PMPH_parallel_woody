import "lib/github.com/diku-dk/sorts/radix_sort"

let TREE_ROOT_ID: i32 = 0
let TREE_CHILD_ID_NOT_SET: i32 = 0
let PREDICTION_TYPE_NORMAL: i32 = 0
let PREDICTION_TYPE_LEAVES_IDS: i32 = 1

let get_data_row_starts [Xlength] [indlength]
      (Xtest: [Xlength]f64)
      (indices: [indlength]i32)
      (dindices: i32)
      (dXtest: i32)
      (i: i32) : i32 =
  let idx = if dindices > 0 then indices[i] else i
  let row_start = idx * dXtest
  in row_start

let next_node
  (row: []f64)
  ((left, right, feature, thres) : (i32, i32, i32, f64)) : i32 =
  if row[feature] <= thres then left else right

let make_next_tree
   ((tree, row) : ([](i32, i32, i32, f64), []f64)) : []i32 =
   map (next_node row) tree

let traverse
   (next_nodes: []i32): i32 =
   let (last, current) = (0, next_nodes[0])
   let (result, _) = loop (last, current) while current != 0 do (current, next_nodes[current])
   in result

let main [treelength] [Xlength] [indlength]
      (treeLeftid : [treelength]i32)
      (treeRightid : [treelength]i32)
      (treeFeature : [treelength]i32)
      (treeThres_or_leaf : [treelength]f64)
      (Xtest : [Xlength]f64)
      (nXtest : i32)
      (dXtest : i32)
      (indices: [indlength]i32)
      (dindices : i32)
      (prediction_type : i32)
      (depth: i32) : []i32 =

  let n_preds = if dindices > 0 then dindices else nXtest
  let data_row_starts = (unsafe map (get_data_row_starts Xtest indices dindices dXtest) (iota n_preds))

  let nodes = zip4 treeLeftid treeRightid treeFeature treeThres_or_leaf
  let rows = unflatten nXtest dXtest Xtest --loop row for i in (steps 0 dXtest (nXtest - dXtest)) do
             --row ++ [take dXtest (drop i Xtest)]
  let trees = (replicate n_preds nodes)

  let next_nodes = map make_next_tree (zip trees rows)

  in map traverse next_nodes