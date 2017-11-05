//
//  NewsTests.m
//  NewsTests
//
//  Created by liulishuo on 2017/11/3.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSURL+LLSUtil.h"
#import "LLStweetListItemModel.h"

@interface NewsTests : XCTestCase

@end

@implementation NewsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testURL {
    NSURL *url = [NSURL URLWithString:@"https://client.example.com/cb?code=SplxlOBeZQQYbYS6WxSbIA&state=xyz"];
    NSString *value = [url lls_valueForKey:@"code"];
    XCTAssert([value isEqualToString:@"SplxlOBeZQQYbYS6WxSbIA"]);
    
    url = [NSURL URLWithString:@""];
    value = [url lls_valueForKey:@"code"];
    XCTAssert(value == nil);
    
    url = nil;
    value = [url lls_valueForKey:@"code"];
    XCTAssert(value == nil);
    
    url = [NSURL URLWithString:@"https://client.example.com/cb?state=xyz"];
    value = [url lls_valueForKey:@"code"];
    XCTAssert(value == nil);
    
    url = [NSURL URLWithString:@"https://client.example.com/cb?code&state=xyz"];
    value = [url lls_valueForKey:@"code"];
    XCTAssert(value == nil);
}

- (void)testModel {
    LLStweetListItemModel *model = [[LLStweetListItemModel alloc] init];
    model.imgBig = @"https://static.oschina.net/uploads/space/2017/1103/124756_N0j3_1456141.png,2017/1103/124757_YWt8_1456141.png,2017/1103/124758_aOoK_1456141.png,2017/1103/124759_nTrP_1456141.png";
    XCTAssert(model.originalPicUrls.count == 4);
    XCTAssert([model.originalPicUrls.firstObject.absoluteString isEqualToString:@"https://static.oschina.net/uploads/space/2017/1103/124756_N0j3_1456141.png"]);
    XCTAssert([model.originalPicUrls.lastObject.absoluteString isEqualToString:@"https://static.oschina.net/uploads/space/2017/1103/124759_nTrP_1456141.png"]);
    
    model.imgBig = @"https://static.oschina.net/uploads/space/";
    XCTAssert(model.originalPicUrls.count == 0);
}

- (void)DISABLE_testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
       
    }];
}

@end
