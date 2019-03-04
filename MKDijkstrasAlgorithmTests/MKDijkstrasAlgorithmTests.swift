/*
    Created by Elijah Sawyers on 3/02/19.
    Copyright © 2019 Elijah Sawyers. All rights reserved.
 
    Abstract:
    This file contains MKDijkstrasAlgorithm tests.
 */

import XCTest
import MKDijkstrasAlgorithm

class MKDijkstrasAlgorithmTests: XCTestCase {
    
    /// The graph to be tested.
    var graphUnderTest: MKWeightedDirectionalGraph!
    
    /// The dijkstra's algorithm class to be tested.
    var dijkstrasUnderTest: MKDijkstrasAlgorithm!

    // Sets up the SUT (system under test).
    override func setUp() {
        super.setUp()
        graphUnderTest = MKWeightedDirectionalGraph()
        graphUnderTest.add(node: MKNode(name: "Node 1", x: 100.0, y: 100.0))
        graphUnderTest.add(node: MKNode(name: "Node 2", x: 200.0, y: 200.0))
        graphUnderTest.add(node: MKNode(name: "Node 3", x: 300.0, y: 300.0))
        graphUnderTest.addEdge(from: "Node 1", to: "Node 2")
        graphUnderTest.addEdge(from: "Node 2", to: "Node 3")
        dijkstrasUnderTest = MKDijkstrasAlgorithm(graph: graphUnderTest)
    }

    // Tears down the SUT (system under test).
    override func tearDown() {
        graphUnderTest = nil
        dijkstrasUnderTest = nil
    }
    
    /// Insures shortest path returns a path, if it exists; otherwise, returns nil.
    func testShortestPath() {
        // 1. Given.
        let node1Name = "Node 1"
        let node2Name = "Node 2"
        let nonexistantNode = "Random Node Name"
        
        // 2. When.
        let realPath = dijkstrasUnderTest.shortestPath(start: node1Name, end: node2Name)
        let noPath1 = dijkstrasUnderTest.shortestPath(start: node2Name, end: node1Name)
        let noPath2 = dijkstrasUnderTest.shortestPath(start: node2Name, end: nonexistantNode)
        
        // 3. Then.
        XCTAssertTrue(realPath != nil, "Path not found.")
        XCTAssertTrue(noPath1 == nil, "Path should not have been found.")
        XCTAssertTrue(noPath2 == nil, "Path should not have been found.")
    }
}
