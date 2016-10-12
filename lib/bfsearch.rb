#   IDAstar --- A pure Ruby implementation of the IDA* search algorithm
#   Copyright (C) 2016  Eric MSP Veith <eveith+idastar-ruby@veith-m.de>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

##
# This class implements the Best-First Search algorithm.
#
# The Best-First Search algorithm (BFS) tries to find a valid path from a
# starting node to a destination node. It will always find a path if one
# exists.
#
# The typical usage is to call BFsearch.find_path.
module BFsearch

  ##
  # Finds a way from +root_node+ to +destination_node+ and returns the path
  # node by node.
  #
  # This method implements the Best-First Search algorithm. It starts at
  # +root_node+, trying to find a way to the +destination+.
  #
  # The distance between two nodes is measured using a function object passed
  # as the +distance_function+ parameter. It is called as:
  #
  #   distance_function.call(node_1, node_2)  # => Float
  #
  # Whenever the algorithm advances from the current node, it needs to know of
  # the node's neighbors. For this, the foruth parameter,
  # +neighbors_function+, is required. It is also assumed to be a lambda
  # object or any object that responds to
  # +neighbors_function#call(current_node)+ and returns a list of adjacent
  # nodes.
  #
  #   neighbors_function(node)  # => Array
  #
  # BFS is an informed search algorithm, i.e., it uses an heuristic to select
  # the probably best next node at any given state. This heuristic is
  # implemented using a Lambda and the third parameter,
  # +heuristic_function(node)+. The distance function must return an
  # optimistic guess of the distance from the given node to the destination
  # node. 'Optimistic' means that the value returned (a float) must be equal
  # to or lower than the actual distance, but never greater. The air-line
  # distance is a valid implementation of the distance function, since it will
  # always return a value equal to or lower than the actual distance due to
  # the triangle inequality.
  #
  #   heuristic_function(node)  # => Float
  def self.find_path(root_node, destination, distance_function, neighbors_function,
        heuristic_function)
    root_entry = {
      node: root_node,
      parent: nil,
      distance: 0.0
    }
    open = [root_entry]
    closed = []

    until open.empty?
      catch :restart do
        current = open.shift
        if current[:node] == destination
          return construct_path(root_node, current) 
        end
        closed.push current

        neighbors_function.call(current[:node]).each do |node|
          open_entry = open.find {|i| i[:node] == node }
          closed_entry = closed.find {|i| i[:node] == node }
          entry = open_entry || closed_entry || {
            node: node,
            parent: current
          }

          goal_distance = heuristic_function.call node
          start_distance = distance entry, root_entry, distance_function
          entry[:distance] ||= start_distance

          unless open_entry || closed_entry
            open.push entry
          else
            if start_distance < entry[:distance]
              entry[:parent] = current
              entry[:distance] = start_distance
              open.push entry unless open_entry
            end
          end
        end

        open.sort {|a, b| a[:distance] <=> b[:distance] }
      end
    end
  end

  ##
  # Constructs and returns an array that contains the best path from the
  # root_node to the destination object.
  def self.construct_path(root_node, destination)
    nodes = [destination[:node]]

    while destination[:node] != root_node do
      destination = destination[:parent]
      nodes.unshift destination[:node]
    end

    nodes
  end

  ##
  # Retruns the accumulated distance between two nodes along the currently
  # recorded path
  def self.distance(start, destination, distance_function)
    current = start
    distance = 0.0

    while current != destination
      distance += distance_function.call current[:node], current[:parent][:node]
      current = current[:parent]
    end

    distance
  end

  private_class_method :distance, :construct_path
end
