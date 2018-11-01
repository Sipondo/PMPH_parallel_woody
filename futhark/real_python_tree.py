import numpy
import random
import sys
sys.path.append(".")
import os

query_file = "covtype-test-1.csv"
trainsize = "100_trainsize"
data_headers = [("features", int), ("leaf_criterion", int), ("left_ids", int), ("right_ids",int), ("thres_or_leaf",float)]
data_values = {}
query_values = []

amount_of_queries = 0
amount_of_features = 0

for header in data_headers:
    print header
    with open(os.path.join("futhark","trees", trainsize, header[0]+".txt")) as file:
        data_values[header[0]] = [header[1](i) if header[1](i)<10000000 else 0 for i in file.readline().replace("[","").replace(",","").replace("]","").split(" ")[1:-1]]

data_values["right_ids"]


with open(os.path.join("futhark","trees", query_file)) as file:
    for line in file.readlines()[:1000]:
        amount_of_queries += 1
        query_values.extend([int(i) for i in line.split(",")])
        amount_of_features = len(line)


#Crawl the tree

current_depth = 0
max_depth = 0
nodes = [(0,0)]

for node in nodes:
    if ((data_values["left_ids"][node[0]] != 0) and (data_values["right_ids"][node[0]] != 0)):
        nodes.append((data_values["left_ids"][node[0]],node[1]+1))
        nodes.append((data_values["right_ids"][node[0]],node[1]+1))

#Write the file
with open("real_tree",'w') as file:
    file.write('{} {} {} {} {} {} {} {} {} {} {}'.format(\
        str(data_values["left_ids"]),
        str(data_values["right_ids"]),
        str(data_values["features"]),
        str(data_values["thres_or_leaf"]),
        str(query_values),
        amount_of_queries,
        amount_of_features,
        "empty(i32)",
        0,
        0,
        nodes[len(nodes)-1][1]))

#
# '{} {} {} {} {} {}'.format(\
#     amount_of_queries,
#     amount_of_features,
#     "empty(i32)",
#     0,
#     0,
#     nodes[len(nodes)-1][1])
#
# class Node:
#     __init__(self, depth):
#         self.depth = depth
#         self.thresh = 0.0
#         generate_offspring()
#
#     generate_offspring(self):
#         if depth<max_depth:
#             if (random.rand(1.0) < grow_odds/depth):
#                 self.thresh = random.rand(1.0)
