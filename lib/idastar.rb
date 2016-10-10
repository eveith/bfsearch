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


class IDAstar

  ##
  # The default bound factor
  # See IDAstar#bound_factor for more details
  DEFAULT_BOUND_FACTOR = 0xf

  ##
  # This factor is applied to the optimistic distance of the current node to
  # the final node in order to limit the breadth of the search.
  #
  # This is a hard boundary and exists to prevent the algorithm from getting
  # stuck in an infinite loop. The default value
  # (IDAstar::DEFAULT_BOUND_FACTOR) is usually sensible and does not need 
  # to be changed.
  attr_accessor :bound_factor


  def initialize(bound_factor: MAX_BOUND_FACTOR)
    @bound_factor = bound_factor
  end


  ##
  # Finds a way from +root_node+ to +destination_node+ and returns the path
  # node by node.
  #
  # This method implements the IDA* search algorithm. It starts at
  # +root_node+, trying to find a way to the +destination+.
  #
  # IDA* is an informed search algorithm, i.e., it uses an heuristic to select
  # the probably best next node at any given state. This heuristic is
  # implemented using a Lambda and the third parameter,
  # +distance_function(node)+. The distance function must return an 
  # optimistic guess of the distance from the given node to the destination
  # node. 'Optimistic' means that the value returned (a float) must be equal
  # to or lower than the actual distance, but never greater. The air-line
  # distance is a valid implementation of the distance function, since it will
  # always return a value equal to or lower than the actual distance due to
  # the triangle inequality.
  #
  # Of course, the object given to +distance_function+ does not need to be a
  # lambda: Any object that responds to #call with a single parameter
  # suffices.
  #
  # Whenever the algorithm advances from the current node, it needs to know of
  # the node's neighbors. For this, the foruth parameter,
  # +neighbors_function+, is required. As with the distance function, it is
  # assumed to be a lambda object or any object that responds to
  # +neighbors_function#call(current_node)+ and returns a list (or an
  # Enumerator) of the neighbors of the node.
  def path(root_node, destination, distance_function, neighbors_function)
    bound = distance_funciton.call root_node
    max_bound = bound * @bound_factor


  end


  def search(current_node, target_node, distance_function, neighbors_function)

  end
end
