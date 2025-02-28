// Created by konstantin on 04/12/2022.
// Copyright (c) 2022. All rights reserved.


import XCTest
@testable import TootSDK

final class PostTests: XCTestCase {
    func testScheduledPostValidatesScheduledAtRequired() throws {
        // arrange
        let params = ScheduledPostParams(mediaIds: [], visibility: .public)
        
        // act
        XCTAssertThrowsError(try ScheduledPostRequest(from: params)) {error in
            XCTAssertEqual(error as? TootSDKError, TootSDKError.missingParameter(parameterName: "scheduledAt"))
        }
    }
    
    func testScheduledPostValidatesScheduledAtTooSoon() throws {
        // arrange
        var params = ScheduledPostParams(mediaIds: [], visibility: .public)
        params.scheduledAt = Date().addingTimeInterval(TimeInterval(4.5 * 60.0)) // date is only 5 mins in the future
        
        // act
        XCTAssertThrowsError(try ScheduledPostRequest(from: params)) {error in
            XCTAssertEqual(error as? TootSDKError, TootSDKError.invalidParameter(parameterName: "scheduledAt"))
        }
    }
    
    func testScheduledPostValidatesScheduledAtInTheFuture() throws {
        // arrange
        var params = ScheduledPostParams(mediaIds: [], visibility: .public)
        params.scheduledAt = Date().addingTimeInterval(TimeInterval(6.0 * 60.0)) // date is only 5 mins in the future
        
        // act
        XCTAssertNoThrow(try ScheduledPostRequest(from: params))
    }
}
