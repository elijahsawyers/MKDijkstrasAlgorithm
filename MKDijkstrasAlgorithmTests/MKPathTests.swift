/*
    Created by Elijah Sawyers on 3/02/19.
    Copyright © 2019 Elijah Sawyers. All rights reserved.
 
    Abstract:
    This file contains MKPath tests.
 */

import XCTest
import MapKit
import MKDijkstrasAlgorithm

class MKPathTests: XCTestCase {

    /// The path to be tested.
    var pathUnderTest: MKPath!
    
    // Tears down the SUT (system under test).
    override func tearDown() {
        pathUnderTest = nil
    }
    
    /// Insures proper initialization.
    func testPathInitializationWithoutEdgeAndPath() {
        // 1. Given.
        let testNode = MKNode(name: "Test Node", x: 100.0, y: 100.0)
        
        // 2. When.
        pathUnderTest = MKPath(edge: nil, previousPath: nil, node: testNode)
        
        //  3. Then.
        XCTAssertEqual(pathUnderTest.node.name, "Test Node", "Wrong node added at initialization.")
        XCTAssertTrue(pathUnderTest.previousPath == nil, "Wrong previous path added at initialization.")
        XCTAssertEqual(pathUnderTest.cumulativeWeight, 0.0, "Wrong cumulative weight added at initialization.")
    }
    
    /// Insures proper initialization.
    func testPathInitializationWithEdgeAndPreviousPath() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let firstPath = MKPath(edge: nil, previousPath: nil, node: node1)
        
        // 2. When.
        node1.addEdgeTo(destination: node2)
        pathUnderTest = MKPath(edge: node1.edgeFor(destination: node2)!, previousPath: firstPath, node: node2)
        
        //  3. Then.
        XCTAssertEqual(pathUnderTest.node.name, "Node 2", "Wrong node added at initialization.")
        XCTAssertTrue(pathUnderTest.previousPath === firstPath, "Wrong previous path added at initialization.")
        XCTAssertEqual(pathUnderTest.cumulativeWeight,  node1.edgeFor(destination: node2)!.weight, "Wrong cumulative weight added at initialization.")
    }
    
    /// Insures the draw function adds a MKPolyline to the mapView.
    func testDraw() {
        // 1. Given.
        let node1 = MKNode(name: "Node 1", x: 100.0, y: 100.0)
        let node2 = MKNode(name: "Node 2", x: 200.0, y: 200.0)
        let firstPath = MKPath(edge: nil, previousPath: nil, node: node1)
        let mapView = MKMapView()
        
        // 2. When.
        node1.addEdgeTo(destination: node2)
        pathUnderTest = MKPath(edge: node1.edgeFor(destination: node2)!, previousPath: firstPath, node: node2)
        pathUnderTest.draw(mapView: mapView)
        
        // 3. Then.
        XCTAssertTrue(mapView.overlays.first! is MKPolyline, "MKPolyLine not added.")
    }
}
