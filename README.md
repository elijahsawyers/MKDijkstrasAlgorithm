# MKDijkstrasAlgorithm

Cocoa Touch Framework to perform Dijkstra's algorithm with MKMapPoints.

## What's Included

* **MKNode** - A node (a.k.a. vertex) to be used in the graph. Represents a MKMapPoint.
* **MKEdge** - An edge (a.k.a. connection) to be used in the graph. Edge weight is the distance, in meters, between the two MKNodes.
* **MKWeightedDirectionalGraph** - The "glue" for MKNodes and MKEdges. Includes basic graph operations.
* **MKPath** - Stores path information from one node to another.
* **MKDijkstrasAlgorithm** - Used to find the shortest path between nodes in an MKWeightedDirectionalGraph.

## Authors

* [Elijah Sawyers](https://github.com/elijahsawyers)
