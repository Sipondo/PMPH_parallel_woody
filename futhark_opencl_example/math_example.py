##################
######pyopencl Futhark example: Basic arithmetic
##################

import sys
sys.path.append("")
sys.path.append("futhark")

######

import numpy as np
from futmath import futmath #Import your library here

params_list = [[0, 1076, 2320],
               [1, 5034, 3042],
               [2, 65, 23],
               [3, 3453, 75]]

operation_dict = {0: "+",
                  1: "-",
                  2: "*",
                  3: "/"}

#Build the futhark object
calculator = futmath()

for params in params_list:
    print('{:d}{}{:d} = {:d}'.format(params[1],
                              operation_dict[params[0]],
                              params[2],
                              calculator.main(*params))) #Call your function with params
