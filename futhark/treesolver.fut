--Example code∷
--Apply operation k to ints x and y
--0: +
--1: -
--2: *
--3: /

-- let main (k : i32, x: i32, y: i32) : i32 =
--   if      k == 0 then x + y   -- add
--   else if k == 1 then x - y   -- substract
--   else if k == 2 then x * y   -- multiply
--   else x / y                  -- divide

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

  -- set number of predictions as size of test data or number of indices
  let n_preds = if dindices > 0 then dindices else nXtest
  --let indices' = if dindices > 0 then indices else (iota nXtest)
  let data_row_starts = (unsafe map (get_data_row_starts Xtest indices dindices dXtest) (iota n_preds))

  --
  let node_array = replicate n_preds 0
  let nodes = loop node_array for row in iota(depth) do
            unsafe map (\ (node_id, data_row_start) ->
                 if (treeLeftid[node_id] != 0) then (if Xtest[data_row_start + treeFeature[node_id]] <= treeThres_or_leaf[node_id] then treeLeftid[node_id] else treeRightid[node_id]) else node_id) (zip node_array data_row_starts)
  in nodes

--          unsafe map (\ i ->
--          let idx = if dindices > 0 then indices[i] else i
--          let row_start = idx * dXtest
--          in loop node_id = TREE_ROOT_ID = while treeLeftid[node_id] != TREE_CHILD_ID_NOT_SET do
--                      if Xtest[row_start + treeFeature[node_id]] <= treeThres_or_leaf[node_id] then treeLeftid[node_id] else treeRightid[node_id]
--                     ) (iota n_preds)
--  in predictions


--          let predictions[i] = if prediction_type == PREDICTION_TYPE_NORMAL
--            then treeThres_or_leaf[node_id] else
--              if prediction_type == PREDICTION_TYPE_LEAVES_IDS
--                then node_id else -1 -- exit failure






  --
  -- /* --------------------------------------------------------------------------------
  --  * Queries a single tree
  --  * --------------------------------------------------------------------------------
  --  */
  -- void cpu_query_tree(TREE tree, FLOAT_TYPE *Xtest, int nXtest, int dXtest,
  -- FLOAT_TYPE *predictions, int *indices, int dindices, int prediction_type) {
  --
  -- 	register TREE_NODE *node = tree.root;
  -- 	register FLOAT_TYPE *tpatt;
  --
  -- 	register unsigned int i, node_id, idx;
  --
  -- 	int n_preds = nXtest;
  -- 	if (dindices > 0) {
  -- 		n_preds = dindices;
  -- 	}
  -- 	for (i = 0; i < n_preds; i++) {
  --
  -- 		if (dindices > 0) {
  -- 			idx = indices[i];
  -- 		} else {
  -- 			idx = i;
  -- 		}
  --
  -- 		tpatt = Xtest + idx * dXtest;
  -- 		node_id = TREE_ROOT_ID;
  --
  -- 		while (node[node_id].left_id != TREE_CHILD_ID_NOT_SET) {
  -- 			if (tpatt[node[node_id].feature] <= node[node_id].thres_or_leaf) {
  -- 				node_id = node[node_id].left_id;
  -- 			} else {
  -- 				node_id = node[node_id].right_id;
  -- 			}
  -- 		}
  --
  -- 		if (prediction_type == PREDICTION_TYPE_NORMAL) {
  -- 			predictions[i] = node[node_id].thres_or_leaf;
  -- 		} else if (prediction_type == PREDICTION_TYPE_LEAVES_IDS) {
  -- 			predictions[i] = (FLOAT_TYPE) node_id;
  -- 		} else {
  -- 			printf("Error: Unknown prediction type: %i ", prediction_type);
  -- 			exit(EXIT_FAILURE);
  -- 		}
  --
  -- 	}
  --
  -- }
