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

let main [treelength] [Xlength] [predlength] [indlength]
      (tree : [treelength]i32)
      (Xtest : [Xlength]f32)
      (nXtest : i32)
      (dXtest : i32)
      (predictions : [predlength]f32)
      (indices: [indlength]i32)
      (dindices : i32)
      (prediction_type : i32) : [predlength]f32 =




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
