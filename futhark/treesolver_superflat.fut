import "lib/github.com/diku-dk/sorts/radix_sort"

let TREE_ROOT_ID: i32 = 0
let TREE_CHILD_ID_NOT_SET: i32 = 0
let PREDICTION_TYPE_NORMAL: i32 = 0
let PREDICTION_TYPE_LEAVES_IDS: i32 = 1

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

  let repeated_criteria = flatten (replicate nXtest treeFeature)
  let repeated_offsets = flatten (map (\ i -> replicate treelength i) (steps 0 nXtest dXtest))
  let flcr = map2 (+) repeated_offsets repeated_criteria
  let scattered_features = unsafe map (\ i -> Xtest[i]) flcr
  let threshold_result = map2 (<=) scattered_features (flatten (replicate nXtest treeThres_or_leaf))
  let left_or_right = (\ b l r -> if b then l else r)
  let repeatedLeft = flatten (replicate nXtest treeLeftid)
  let repeatedRight = flatten (replicate nXtest treeRightid)
  let directions = map3 left_or_right threshold_result repeatedLeft repeatedRight

  in unsafe map traverse (unflatten nXtest treelength directions)