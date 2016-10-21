# Best-First Search

## Introduction

This Ruby gem implements the Best-First Search algorithm.

## Synopsis

    require 'bfsearch'

    distance = ->(a, b) { a.calculate_distance_to(b) }
    neighbors = ->(node) { node.all_neighbors }
    heuristic = ->(a, b) { a.calculate_optimistic_distance_to(b) }

    path = BFsearch.find_path(start, destination, distance, neighbors,
                              heuristic)

This gem implements the Greedy Best-First Search algorithm. Its main and only
interface is `BFsearch.find_path`. This method requires a number of arguments,
which are:

start:: The starting node
destination:: The destination node
distance:: A function that calculates the real distance between two nodes
neighbors:: A function that returns all immediate neighbors of a node
heuristic:: A function that calculates the *optimistic* distance between 
    two nodes

The three functions are assumed to be `Proc` objects, i.e., procs or lambdas
that answer to `#call`. Moreover, `distance` and `heuristic` are assumed to
return a `Float`.

Heuristic must return an optimistic distance between two nodes. "Optimistic"
means that the value must be lower than or equal to what the distance function
would return: `heuristic(a, b) <= distance(a, b)`. For example, the air-line
distance would be such an optimistic function (compared to, e.g., the
manhattan distance).

gBFS can be turned into standard BFS with `heuristic = ->(a, b) { 0.0 }`.

## License

This code is licensed under the GNU GPL v3. See the file `COPYING` for
details.
