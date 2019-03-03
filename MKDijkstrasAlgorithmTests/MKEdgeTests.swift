/*
    Created by Elijah Sawyers on 3/02/19.
    Copyright © 2019 Elijah Sawyers. All rights reserved.
     
    Abstract:
    This file contains MKEdge tests.
 */

import XCTest
import MKDijkstrasAlgorithm

class MKEdgeTests: XCTestCase {
    
    /// The edge to be tested.
    var edgeUnderTest: MKEdge!

    // Sets up the SUT (system under test)
    override func setUp() {
        let sourceNode = MKNode(name: "Source", x: 100.0, y: 100.0)
        let destinationNode = MKNode(name: "Destination", x: 200.0, y: 200.0)
        edgeUnderTest = MKEdge(source: sourceNode, destination: destinationNode)
    }
    
    // Tears down the SUT (system under test).
    override func tearDown() {
        edgeUnderTest = nil
    }
    
    /// Insures that an edge is properly initialized.
    func testEdgeInitialization() {
        XCTAssertTrue(edgeUnderTest.source.name == "Source", "Source node not properly initialized.")
        XCTAssertTrue(edgeUnderTest.destination.name == "Destination", "Destination node not properly initialized.")
        XCTAssertTrue(edgeUnderTest.weight >= 0, "Weight not properly initialized.")
    }

}
