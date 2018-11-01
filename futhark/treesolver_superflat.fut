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

  --let data_by_criterium = map (\ (node, query) -> Xtest[query + treeFeature[node]]) (zip (iota treelength) (flatten (replicate nXtest data_row_starts)))
  let rows = unflatten nXtest dXtest Xtest
--  let data_by_criterium = map (\ node ->
--                               let criterium_row = replicate dXtest 0
  --                               scatter criterium_row row treeFeature) node
  let repeated_criteria = flatten (replicate nXtest treeFeature)
  let repeated_offsets = flatten (map (\ i -> replicate treelength i) (steps 0 nXtest dXtest))
  let flcr = map2 (+) repeated_offsets repeated_criteria
--                                        let criterium_empty = replicate treelength (0:f64)
--                                        in scatter criterium_empty treeFeature row) rows)
  --let unflat_dbc = scatter
  let scattered_features = unsafe map (\ i -> Xtest[i]) flcr
  let threshold_result = map2 (<=) scattered_features (flatten (replicate nXtest treeThres_or_leaf))
  let left_or_right = (\ b l r -> if b then l else r)
  let repeatedLeft = flatten (replicate nXtest treeLeftid)
  let repeatedRight = flatten (replicate nXtest treeRightid)
  let directions = map3 left_or_right threshold_result repeatedLeft repeatedRight

  in map traverse (unflatten nXtest treelength directions)