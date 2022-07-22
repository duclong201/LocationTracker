//
//  LocationTrackerTests.swift
//  LocationTrackerTests
//
//  Created by Long Nguyen on 22/7/2022.
//

import XCTest
@testable import LocationTracker
import CoreLocation

class LocationTrackerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCalculatingAverageSpeedWhenNoDistanceAndTimeAreRecorded() {
        let testDistanceAndTime = [DistanceAndTime]()
        
        let averageSpeed = DistanceAndTime.calculateAverageSpeed(distanceAndTime: testDistanceAndTime)
        
        XCTAssertEqual(averageSpeed, 0.0, "Average speed calculated is wrong")
    }
    
    func testCalculatingAverageSpeedWhenThereIsOnlyOneElementInDistanceAndTimeArray() {
        let testDistanceAndTime = DistanceAndTime(distance: 10, time: 2)
        
        let averageSpeed = DistanceAndTime.calculateAverageSpeed(distanceAndTime: [testDistanceAndTime])
        
        XCTAssertEqual(averageSpeed, 0.0, "Average speed calculated is wrong")
    }
    
    func testCalculatingAverageSpeedWhenStartAndEndTimeAreEqual() {
        let now = Date().timeIntervalSince1970
        let testDistanceAndTime1 = DistanceAndTime(distance: 10, time: now)
        let testDistanceAndTime2 = DistanceAndTime(distance: 30, time: now)
        
        let averageSpeed = DistanceAndTime.calculateAverageSpeed(distanceAndTime: [testDistanceAndTime1, testDistanceAndTime2])
        
        XCTAssertEqual(averageSpeed, 0.0, "Average speed calculated is wrong")
    }
    
    func testCalculatingAverageSpeedWhenThereAreTwoOrMoreElementsInDistanceAndTimeArray() {
        let now = Date().timeIntervalSince1970
        let testDistanceAndTime1 = DistanceAndTime(distance: 10, time: now)
        let testDistanceAndTime2 = DistanceAndTime(distance: 30, time: now + 2)
        
        let averageSpeed = DistanceAndTime.calculateAverageSpeed(distanceAndTime: [testDistanceAndTime1, testDistanceAndTime2])
        
        XCTAssertEqual(averageSpeed, 20, "Average speed calculated is wrong")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
