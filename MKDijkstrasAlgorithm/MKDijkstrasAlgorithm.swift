/*
    Created by Elijah Sawyers on 2/27/19.
    Copyright © 2019 Elijah Sawyers. All rights reserved.

    Abstract:
    This file contains the necessary classes to use Dijkstras algorithm with MapKit.
 */

import Foundation
import MapKit

/**
    Stores graph traversal information.
    - note: To traverse the whole path, loop over the previous paths.
 */
public class MKPath {
    /// The total weight of the paths to get to this node.
    private let _cumulativeWeight: Double
    
    /// Gets the total weight of the paths to get to this node.
    public var cumulativeWeight: Double {
        get {
            return _cumulativeWeight
        }
    }
    
    /// The node that the path led to.
    private let _node: MKNode
    
    /// Gets the node that the path led to.
    public var node: MKNode {
        get {
            return _node
        }
    }
    
    /// The path taken before this one (used for traversal).
    private let _previousPath: MKPath?
    
    /// Gets path taken before this one (used for traversal).
    public var previousPath: MKPath? {
        get {
            return _previousPath
        }
    }
    
    /**
     Initializes the path.
     
     - parameter edge: The edge taken to get to this node.
     - parameter previousPath: The path taken before this one.
     - parameter node: The node that this path led to.
     */
    public init(edge: MKEdge?, previousPath: MKPath?, node: MKNode) {
        if let edgeWeight = edge?.weight, let previousPathCumulativeWeight = previousPath?.cumulativeWeight {
            self._cumulativeWeight = edgeWeight + previousPathCumulativeWeight
        } else {
            self._cumulativeWeight = 0
        }
        self._previousPath = previousPath
        self._node = node
    }
}

/**
    This class is used to find the shortest path between two nodes in a weighted, directional graph.
 
    Dijkstra's algorithm finds the shortest path by:
    1. Finding the cheapest unvisited node.
    2. Marking the node as visited and keep track of which unvisited nodes can be reached.
    3. Repeating steps 1 and 2 until you find the destination node.
 */
public class MKDijkstrasAlgorithm {
    /// The weighted, directional graph used to perform Dijkstra's algorithm.
    private let graph: MKWeightedDirectionalGraph
    
    /**
     Queue of all paths to visited nodes in the graph.
     - note: Is initially empty, and it will be empty after performing Dijkstra's algorithm on the graph.
     - note: This is kept in sorted order from least to greatest distance from the source.
     */
    private var paths: [MKPath] {
        didSet {
            paths = paths.sorted { $0.cumulativeWeight < $1.cumulativeWeight }
        }
    }
    
    /**
     Set of all visited nodes.
     - note: Will initially be empty.
     */
    private var visitedNodes: [MKNode]
    
    /**
     Sets the graph to be used by Dijkstra's algorithm.
     - parameter graph: The graph to be used by Dijkstra's algorithm.
     */
    public init(graph: MKWeightedDirectionalGraph) {
        self.graph = graph
        self.paths = []
        self.visitedNodes = []
    }
    
    
    /**
        This method executes Dijkstra's algorithm on the graph set at initialization.
     
        - parameter start: The identifier of the starting node.
        - parameter end: The identifier of the node to find the shortest path to.
        - returns: An MKPath object that contains the shortest path to the end node.
     */
    public func shortestPath(start: String, end: String) -> MKPath? {
        // Empty the visited nodes and paths taken.
        visitedNodes = []
        paths = []
        
        // The starting node.
        let startNode = graph.nodes.filter { $0.name == start }.first
        if startNode == nil {
            return nil
        }
        
        // The node to find the shortest path to.
        let endNode = graph.nodes.filter { $0.name == end }.first
        if endNode == nil {
            return nil
        }
        
        // Create the first path to the start node.
        paths.append(MKPath(edge: nil, previousPath: nil, node: startNode!))
        
        while !paths.isEmpty {
            // 1. Grab the the shortest path.
            let shortestPath = paths.removeFirst()
            
            // 2. Ensure that you haven't visited the node.
            let visited = visitedNodes.contains { $0 === shortestPath.node }
            if visited {
                continue
            }
            
            // 3. Check if the path's node is the end node; if so, return it.
            if shortestPath.node === endNode {
                return shortestPath
            }
            
            // 4. Otherwise, add the node to the visited set, and append unvisited adjacent nodes into the queue of paths.
            for edge in shortestPath.node.edgesToAdjacentNodes {
                let visitedAdjacentNode = visitedNodes.contains { $0 === shortestPath.node }
                if !visitedAdjacentNode {
                    paths.append(MKPath(edge: edge, previousPath: shortestPath, node: edge.destination))
                }
            }
        }
        
        // Returns nil if there is no shortest path from start to end.
        return nil
    }
}
