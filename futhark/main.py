import numpy as np
import _treesolver
from futhark_ffi import Futhark

test = Futhark(_treesolver)
res = test.pred1(0,1)
print(test.from_futhark(res))
print("And the result itself:")
print(res)
