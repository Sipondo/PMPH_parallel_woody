import "lib/github.com/diku-dk/sorts/insertion_sort"

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

  --
  let node_array = replicate n_preds 0
  let is_not_leaf = (\ (node_id, _) -> treeLeftid[node_id] != 0)
  let is_leaf = (\ (node_id, _) -> treeLeftid[node_id] == 0)
  let next_node = (\ (node_id, data_row_start) ->
                   ((if (is_not_leaf (node_id, data_row_start)) then (if Xtest[data_row_start + treeFeature[node_id]] <= treeThres_or_leaf[node_id] then treeLeftid[node_id] else treeRightid[node_id]) else node_id), data_row_start))
  let nodes = zip node_array data_row_starts
  let leaves = []
  let (_, leaves) = loop (nodes, leaves) for row in iota(depth) do
                    let new_nodes = (unsafe map next_node nodes)
                    in (unsafe filter is_not_leaf new_nodes,
                        leaves ++ (unsafe filter is_leaf new_nodes))
  -- Won't work with indices!
  let result = map (\ (a, _) -> a) (insertion_sort (\ (_, a) (_, b) -> a <= b) leaves)
  in result