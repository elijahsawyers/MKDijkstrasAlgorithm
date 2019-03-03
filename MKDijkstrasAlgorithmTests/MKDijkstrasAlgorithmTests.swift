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
        dijkstrasUnderTest = MKDijkstrasAlgorithm(graph: graphUnderTest)
    }

    // Tears down the SUT (system under test).
    override func tearDown() {
        graphUnderTest = nil
        dijkstrasUnderTest = nil
    }

}
