import numpy as np
import sys
sys.path.append("")
sys.path.append("futhark")
from treesolver import treesolver

tree = treesolver()
res = tree.main(0,1).get()
print("And the result itself:")
print(res)
