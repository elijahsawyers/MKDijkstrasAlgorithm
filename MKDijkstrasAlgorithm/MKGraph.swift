//
//  MKGraph.swift
//  MKDijkstrasAlgorithm
//
//  Created by Elijah Sawyers on 3/2/19.
//  Copyright © 2019 Elijah Sawyers. All rights reserved.
//

import Foundation
import MapKit

/**
    This class is used as a node (a.k.a. vertex) in a MKWeightedDirectionalGraph.
 */
public class MKNode {
    /// The identifier for the node.
    private let _name: String
    
    /// Gets the node's identifier.
    public var name: String {
        get {
            return _name
        }
    }
    
    /// The Mercator coordinates of the node.
    public let _coordinates: MKMapPoint
    
    /// Gets the node's Mercator coordinates.
    public var coordinates: MKMapPoint {
        get {
            return _coordinates
        }
    }
    
    /// The edges, with weights, to all adjacent nodes.
    private var _edgesToAdjacentNodes: [MKEdge]
    
    /// Gets edges to all adjacent nodes.
    public var edgesToAdjacentNodes: [MKEdge] {
        get {
            return _edgesToAdjacentNodes
        }
    }
    
    /**
        Initializes an MKNode with the specified Mercator coordinate details.
     
        - parameter name: The identifier for the node.
        - parameter x: The x value of the Mercator coordinate.
        - parameter y: The y value of the Mercator coordinate.
     */
    public init(name: String, x: Double, y: Double) {
        self._name = name
        self._coordinates = MKMapPoint(x: x, y: y)
        self._edgesToAdjacentNodes = []
    }
    
    /**
        Adds an edge to another node.
        - note: If the edge's source isn't this node, it will not be added.
        - parameter edge: The MKEdge to add to the node.
     */
    public func add(edge: MKEdge) {
        if edge.source === self {
            _edgesToAdjacentNodes.append(edge)
        }
    }
    
    /**
        Removes an edge from this node.
        - parameter edge: The MKEdge to be deleted from the node.
     */
    public func remove(edge: MKEdge) {
        _edgesToAdjacentNodes = _edgesToAdjacentNodes.filter { !($0 === edge) }
    }
    
    /**
        Adds an edge to another node.
        - parameter destination: The destination node of the edge.
     */
    public func addEdgeTo(destination: MKNode) {
        _edgesToAdjacentNodes.append(MKEdge(source: self, destination: destination))
    }
    
    /**
        Removes an edge from this node.
        - parameter destination: The destination node of the edge to be deleted.
     */
    public func removeEdgeFrom(destination: MKNode) {
        _edgesToAdjacentNodes = _edgesToAdjacentNodes.filter { !($0.destination === destination) }
    }
    
    
    /**
        Gets an edge from this node to another, if available.
        - parameter destination: The destination node of the edge to be deleted.
        - returns: An optional MKEdge, depending on whether or not the edge exists.
     */
    public func edgeFor(destination: MKNode) -> MKEdge? {
        return _edgesToAdjacentNodes.filter { $0.destination === destination }.first
    }
    
    /**
     Gets an edge from this node to another, if available.
     - parameter destination: The destination node of the edge to be deleted.
     - returns: An optional MKEdge, depending on whether or not the edge exists.
     */
    public func edgeForDestination(name: String) -> MKEdge? {
        return _edgesToAdjacentNodes.filter { $0.destination.name == name }.first
    }
    
    /**
        Gets the number of edges from this node.
        - returns: The number of edges from this node.
     */
    public func edgeCount() -> Int {
        return _edgesToAdjacentNodes.count
    }
}

/**
    This class represents an edge (a.k.a. connection) in a MKWeightedDirectionalGraph.
 */
public class MKEdge {
    /// The source node.
    private let _source: MKNode
    
    /// Gets the source node.
    public var source: MKNode {
        get {
            return _source
        }
    }
    
    /// The destination node.
    private let _destination: MKNode
    
    /// Gets the destination node.
    public var destination: MKNode {
        get {
            return _destination
        }
    }
    
    /// The distance, measured in meters, between the two MKMapPoints (i.e. the weight of the edge).
    private let _weight: Double
    
    /// Gets the distance, measured in meters, between the two MKMapPoints (i.e. the weight of the edge).
    public var weight: Double {
        get {
            return _weight
        }
    }
    
    /**
        Initializes an MKEdge with the two supplied MKNodes.
        - parameter source: The source node of the edge.
        - parameter destination: The destination node of the edge.
     */
    public init(source: MKNode, destination: MKNode) {
        self._source = source
        self._destination = destination
        self._weight = source.coordinates.distance(to: destination.coordinates)
    }
}

/**
    This class implements a weighted, directional graph using MapKit. Nodes in
    the graph represent points on an MKMapView, and each edge's weight is the
    distance between the source and destination, measured in meters.
 */
public class MKWeightedDirectionalGraph {
    
    /// Default initializer.
    public init() {}
    
    /// All nodes currently in the graph.
    fileprivate var _nodes: [MKNode] = []
    
    public var nodes: [MKNode] {
        get {
            return _nodes
        }
    }
    
    /**
        Adds a node to the graph.
        - note: If the node with the same identifier is already in the graph, its information will be updated.
        - parameter node: The MKNode object to insert into the graph.
     */
    public func add(node: MKNode) {
        for i in 0..<_nodes.count {
            if _nodes[i].name == node.name {
                _nodes[i] = node
                return
            }
        }
        _nodes.append(node)
    }
    
    /**
        Removes a node from the graph.
        - parameter node: The MKNode object to remove from the graph.
     */
    public func remove(node: MKNode) {
        _nodes = _nodes.filter { !($0 === node) }
    }
    
    /**
        Removes a node from the graph, if it exists.
        - parameter node: The MKNode object to remove from the graph.
     */
    public func removeNodeWith(name: String) {
        _nodes = _nodes.filter { $0.name != name }
    }
    
    /**
        Returns a node from the graph.
        - parameter name: The identifier of the node to return.
        - returns: An optional MKNode, depending on whether or not a node with the identifier exists.
     */
    public func getNodeWith(name: String) -> MKNode? {
        return _nodes.filter { $0.name == name }.first
    }
    
    /**
        Adds an edge to an existing node in the graph.
        - note: The edge will be disgarded if the source node doesn't exist in the graph.
        - parameter edge: The MKEdge to add to the graph.
     */
    public func add(edge: MKEdge) {
        for node in _nodes {
            if node === edge.source {
                node.add(edge: edge)
            }
        }
    }
    
    /**
        Removes an edge from the graph, if it exists.
        - parameter edge: The MKEdge to add to the graph.
     */
    public func remove(edge: MKEdge) {
        for node in _nodes {
            node.remove(edge: edge)
        }
    }
    
    /**
        Gets the number of nodes in the graph.
        - returns: The number of nodes in the graph.
     */
    public func nodeCount() -> Int {
        return _nodes.count
    }
    
    /**
        Gets the number of nodes in the graph.
        - returns: The number of edges in the graph.
     */
    public func edgeCount() -> Int {
        var total = 0
        for node in _nodes {
            total += node.edgeCount()
        }
        return total
    }
}
