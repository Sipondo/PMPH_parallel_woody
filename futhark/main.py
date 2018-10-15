import numpy as np
import sys
sys.path.append("")
sys.path.append("futhark")
from treesolver import treesolver

params_list = [[0, 10, 20],
               [1, 50, 30],
               [2, 65, 23],
               [3, 99, 75]]

operation_dict = {0: "+",
                  1: "-",
                  2: "*",
                  3: "/"}

tree = treesolver()

for params in params_list:
    print('{:d}{}{:d} = {}'.format(params[1],
                              operation_dict[params[0]],
                              params[2]),
                              tree.main(*params))
