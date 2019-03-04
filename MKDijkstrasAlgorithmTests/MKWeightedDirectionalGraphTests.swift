/*
    Created by Elijah Sawyers on 3/02/19.
    Copyright © 2019 Elijah Sawyers. All rights reserved.
 
    Abstract:
    This file contains MKWeightedDirectionalGraph tests.
 */

import XCTest
import MKDijkstrasAlgorithm

class MKWeightedDirectionalGraphTests: XCTestCase {
    
    /// The graph to be tested.
    var graphUnderTest: MKWeightedDirectionalGraph!

    // Sets up the SUT (system under test)
    override func setUp() {
        graphUnderTest = MKWeightedDirectionalGraph()
    }
    
    // Tears down the SUT (system under test).
    override func tearDown() {
        graphUnderTest = nil
    }
    
    /// Insures that nodes are properly added (and updated).
    func testAddingNodes() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let node3 = MKNode(name: "Node 3", x: 300.0, y: 300.0)
        
        let node2Update = MKNode(name: "Node 2", x: 500.0, y: 500.0)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(node: node3)
        graphUnderTest.add(node: node2Update)
        
        // 3. Then.
        XCTAssertEqual(graphUnderTest.nodeCount(), 3, "Node not properly added.")
        XCTAssertTrue(graphUnderTest.getNodeWith(name: "Node 2")?.coordinates.x == 500.0, "Node not properly updated")
    }
    
    /// Insures that nodes are properly removed from the graph when passed MKNode object.
    func testRemovingNodesPassingMKNode() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let node3 = MKNode(name: "Node 3", x: 300.0, y: 300.0)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(node: node3)
        graphUnderTest.remove(node: node2)
        
        // 3. Then.
        XCTAssertEqual(graphUnderTest.nodeCount(), 2, "Node not properly removed.")
        XCTAssertTrue(graphUnderTest.nodes.first! === node1, "Removed the wrong node.")
        XCTAssertTrue(graphUnderTest.nodes.last! === node3, "Removed the wrong node.")
    }
    
    /// Insures that nodes are properly removed from the graph when passed a name.
    func testRemovingNodesPassingName() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let node3 = MKNode(name: "Node 3", x: 300.0, y: 300.0)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(node: node3)
        graphUnderTest.removeNodeWith(name: node2.name)
        
        // 3. Then.
        XCTAssertEqual(graphUnderTest.nodeCount(), 2, "Node not properly removed.")
        XCTAssertTrue(graphUnderTest.nodes.first! === node1, "Removed the wrong node.")
        XCTAssertTrue(graphUnderTest.nodes.last! === node3, "Removed the wrong node.")
    }
    
    /// Insures that nodes are properly returned when passed a name.
    func testGettingNodes() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let node3 = MKNode(name: "Node 3", x: 300.0, y: 300.0)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(node: node3)
        graphUnderTest.removeNodeWith(name: node2.name)
        
        // 3. Then.
        XCTAssertTrue(graphUnderTest.getNodeWith(name: "Node 1") === node1, "Returned the wrong node.")
        XCTAssertTrue(graphUnderTest.getNodeWith(name: "Node 2") === nil, "Returned the wrong node.")
        XCTAssertTrue(graphUnderTest.getNodeWith(name: "Node 3") === node3, "Returned the wrong node.")
    }
    
    /// Insures that edges are properly added when passed MKEdge.
    func testAddingEdgePassingMKEdge() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let node3 = MKNode(name: "Node 3", x: 300.0, y: 300.0)
        let edge1 = MKEdge(source: node1, destination: node2)
        let edge2 = MKEdge(source: node2, destination: node3)
        let edge3 = MKEdge(source: node3, destination: node1)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(node: node3)
        graphUnderTest.add(edge: edge1)
        graphUnderTest.add(edge: edge2)
        graphUnderTest.add(edge: edge3)
        
        // 3. Then.
        XCTAssertEqual(graphUnderTest.edgeCount(), 3, "Edges not properly added.")
    }
    
    /// Insures that edges are properly added when passed MKNodes names.
    func testAddingEdgePassingMKNodes() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let node3 = MKNode(name: "Node 3", x: 300.0, y: 300.0)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(node: node3)
        graphUnderTest.addEdge(from: "Node 1", to: "Node 2")
        graphUnderTest.addEdge(from: "Node 2", to: "Node 3")
        graphUnderTest.addEdge(from: "Node 3", to: "Node 1")
        
        // 3. Then.
        XCTAssertEqual(graphUnderTest.edgeCount(), 3, "Edges not properly added.")
    }
    
    /// Insures that edges are properly removed when passed an MKEdge.
    func testRemovingEdgePassingMKEdge() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let edge = MKEdge(source: node1, destination: node2)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(edge: edge)
        graphUnderTest.remove(edge: edge)
        
        // 3. Then.
        XCTAssertEqual(graphUnderTest.edgeCount(), 0, "Edges not properly removed.")
    }
    
    /// Insures that edges are properly removed when passed MKNodes names.
    func testRemovingEdgePassingMKNodes() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let edge = MKEdge(source: node1, destination: node2)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(edge: edge)
        graphUnderTest.removeEdge(from: "Node 1", to: "Node 2")
        graphUnderTest.removeEdge(from: "Node 2", to: "Node 1")
        
        // 3. Then.
        XCTAssertEqual(graphUnderTest.edgeCount(), 0, "Edges not properly removed.")
    }
    
    /// Insures that the correct number of nodes is returned.
    func testNodeCount() {
        //  1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let node3 = MKNode(name: "Node 3", x: 300.0, y: 300.0)
        let node4 = MKNode(name: "Node 4", x: 400.0, y: 400.0)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(node: node3)
        graphUnderTest.add(node: node4)
        graphUnderTest.remove(node: node3)
        
        // 3. Then.
        XCTAssertEqual(graphUnderTest.nodeCount(), 3, "Wrong number of nodes.")
    }
    
    /// Insures that the correct number of edges is returned.
    func testEdgeCount() {
        //  1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let node3 = MKNode(name: "Node 3", x: 300.0, y: 300.0)
        let node4 = MKNode(name: "Node 4", x: 400.0, y: 400.0)
        
        // 2. When.
        graphUnderTest.add(node: node1)
        graphUnderTest.add(node: node2)
        graphUnderTest.add(node: node3)
        graphUnderTest.add(node: node4)
        graphUnderTest.addEdge(from: "Node 1", to: "Node 1")
        graphUnderTest.addEdge(from: "Node 2", to: "Node 3")
        graphUnderTest.addEdge(from: "Node 3", to: "Node 4")
        graphUnderTest.addEdge(from: "Node 4", to: "Node 1")
        
        // 3. Then.
        XCTAssertEqual(graphUnderTest.edgeCount(), 4, "Wrong number of nodes.")
    }
}
