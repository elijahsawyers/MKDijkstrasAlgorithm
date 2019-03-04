/*
    Created by Elijah Sawyers on 3/02/19.
    Copyright © 2019 Elijah Sawyers. All rights reserved.
 
    Abstract:
    This file contains MKNode tests.
 */

import XCTest
import MKDijkstrasAlgorithm

class MKNodeTests: XCTestCase {
    
    /// The node to be tested.
    var nodeUnderTest: MKNode!
    
    // Sets up the SUT (system under test).
    override func setUp() {
        nodeUnderTest = MKNode(name: "Main Test Node", x: 100.0, y: 100.0)
    }
    
    // Tears down the SUT (system under test).
    override func tearDown() {
        nodeUnderTest = nil
    }
    
    /// Insures that a node is properly initialized.
    func testNodeInitialization() {
        XCTAssertEqual(nodeUnderTest.name, "Main Test Node", "Name not set properly")
        XCTAssertEqual(nodeUnderTest.coordinates.x, 100.0, "X-value not set properly")
        XCTAssertEqual(nodeUnderTest.coordinates.y, 100.0, "Y-value not set properly")
    }
    
    /// Insures that an MKEdge object is properly added to the test node.
    func testAddingEdgeWithPredefinedMKEdge() {
        // 1. Given.
        let destinationNode = MKNode(name: "Test Node 2", x: 200.0, y: 200.0)
        let edge = MKEdge(source: nodeUnderTest, destination: destinationNode)
        
        // 2. When.
        nodeUnderTest.add(edge: edge)
        nodeUnderTest.add(edge: edge)
        
        // 3. Then.
        XCTAssertEqual(nodeUnderTest.edgeCount(), 1, "Incorrect number of edges.")
    }
    
    /// Insures that an MKEdge object is properly removed from the test node.
    func testRemovingEdgeWithPredefinedMKEdge() {
        // 1. Given.
        let destinationNode = MKNode(name: "Test Node 2", x: 200.0, y: 200.0)
        let edge = MKEdge(source: nodeUnderTest, destination: destinationNode)
        
        // 2. When.
        nodeUnderTest.add(edge: edge)
        nodeUnderTest.remove(edge: edge)
        
        // 3. Then.
        XCTAssertEqual(nodeUnderTest.edgeCount(), 0, "Edge wasn't removed.")
    }
    
    /// Insures that an MKEdge object is properly added from the test node to the destination node.
    func testAddingEdgeToDestinationNode() {
        // 1. Given.
        let destinationNode = MKNode(name: "Test Node 2", x: 200.0, y: 200.0)
        
        // 2. When.
        nodeUnderTest.addEdgeTo(destination: destinationNode)
        nodeUnderTest.addEdgeTo(destination: destinationNode)
        
        // 3. Then.
        XCTAssertEqual(nodeUnderTest.edgeCount(), 1, "Incorrect number of edges.")
    }
    
    /// Insures that an MKEdge object to the destination node is properly removed from the test node.
    func testRemovingEdgeFromDestinationNode() {
        // 1. Given.
        let destinationNode = MKNode(name: "Test Node 2", x: 200.0, y: 200.0)
        
        // 2. When.
        nodeUnderTest.removeEdgeFrom(destination: destinationNode)
        
        // 3. Then.
        XCTAssertEqual(nodeUnderTest.edgeCount(), 0, "Edge wasn't removed.")
    }
    
    /// Insures that the proper MKEdge object is returned when given a destination MKNode.
    func testRetrievingMKEdgeObjectsWithDestinationMKNode() {
        // 1. Given.
        let destinationNode = MKNode(name: "Test Node 2", x: 200.0, y: 200.0)
        
        // 2. When.
        nodeUnderTest.addEdgeTo(destination: destinationNode)
        
        // 3. Then.
        XCTAssertTrue(nodeUnderTest.edgeFor(destination: destinationNode)!.destination === destinationNode, "Edge wasn't found.")
    }
    
    /// Insures that the proper MKEdge object is returned when given a destination node's name.
    func testRetrievingMKEdgeObjectsWithDestinationName() {
        // 1. Given.
        let destinationNode = MKNode(name: "Test Node 2", x: 200.0, y: 200.0)
        
        // 2. When.
        nodeUnderTest.addEdgeTo(destination: destinationNode)
        
        // 3. Then.
        XCTAssertTrue(nodeUnderTest.edgeForDestination(name: "Test Node 2")!.destination === destinationNode, "Edge wasn't found.")
    }

    /// Insures that the proper number of edges is returned.
    func testEdgeCount() {
        // 1. Given.
        let node2 = MKNode(name: "Test Node 2", x: 200.0, y: 200.0)
        let node3 = MKNode(name: "Test Node 3", x: 300.0, y: 300.0)
        let node4 = MKNode(name: "Test Node 4", x: 400.0, y: 400.0)
        let node5 = MKNode(name: "Test Node 5", x: 500.0, y: 500.0)
        
        // 2. When.
        nodeUnderTest.addEdgeTo(destination: node2)
        nodeUnderTest.addEdgeTo(destination: node3)
        nodeUnderTest.addEdgeTo(destination: node4)
        nodeUnderTest.addEdgeTo(destination: node5)
        
        nodeUnderTest.removeEdgeFrom(destination: node4)
        nodeUnderTest.removeEdgeFrom(destination: node5)
        
        // 3. Then
        XCTAssertEqual(nodeUnderTest.edgeCount(), 2, "Incorrect number of edges.")
    }
}
