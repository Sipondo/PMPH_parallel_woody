# self.wrapper.module.predict_extern(X, preds, indices, self.wrapper.params, self.wrapper.forest)
# preds_fut = treesolve(X, preds_fut, indices, self.wrapper.params, self.wrapper.forest, preds)
import numpy as np
from treesolver import treesolver

solver = treesolver()

def treesolve(X, preds_fut, indices, params, forest, preds):
    print(X)
    print(preds_fut)
    print(indices)
    print(params)
    print(forest)
    print(preds)
