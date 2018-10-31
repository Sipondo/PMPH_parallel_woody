import numpy
import random

amount_of_features = 50
amount_of_queries = 100
max_depth = 100
grow_odds = 30.0

features = [i for i in range(amount_of_features)]
queries = []

nodes = [(0,0)]
leftid = []
rightid = []
threshold_or_leaf = []
feature_of_node = []

#Generate queries
for i in range(amount_of_queries):
    for feature in features:
        queries.append(random.random())

#Generate tree

for node in nodes:
    if (random.random()<(grow_odds/(node[1]+grow_odds))) and (node[1]<max_depth):

        #Spawn left node
        leftid.append(len(nodes))
        nodes.append((len(nodes),node[1]+1))

        #Spawn right node
        rightid.append(len(nodes))
        nodes.append((len(nodes),node[1]+1))

        #Add a random threshold
        threshold_or_leaf.append(random.random())

        feature_of_node.append(random.choice(features))

    else:
        #If no nodes are spawned, we still need to append 0 to our children arrays
        leftid.append(0)
        rightid.append(0)
        threshold_or_leaf.append(0.0)
        feature_of_node.append(0)

#Write the file
with open("artificial_tree",'w') as file:
    file.write('{} {} {} {} {} {} {} {} {} {} {}'.format(\
        str(leftid),
        str(rightid),
        str(feature_of_node),
        str(threshold_or_leaf),
        str(queries),
        amount_of_queries,
        amount_of_features,
        "empty(i32)",
        0,
        0,
        nodes[len(nodes)-1][1]))


'{} {} {} {} {} {}'.format(\
    amount_of_queries,
    amount_of_features,
    "empty(i32)",
    0,
    0,
    nodes[len(nodes)-1][1])
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
