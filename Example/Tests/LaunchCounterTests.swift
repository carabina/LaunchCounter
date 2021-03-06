import XCTest
import LaunchCounter

class LaunchCounterTests: XCTestCase {
    
    var userDefaults: UserDefaults!
    let userDefaultsSuiteName = "TestDefaults"
    var launchCounter: LaunchCounter!
    
    override func setUp() {
        super.setUp()
        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        userDefaults = UserDefaults(suiteName: userDefaultsSuiteName)!
        launchCounter = LaunchCounter(userDefaults: userDefaults)
    }
    
    override func tearDown() {
        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        super.tearDown()
    }
    
    func testLaunchCountIsOneOnFirstLaunch() {
        launchCounter.trackLaunch()
        XCTAssertEqual(launchCounter.launchCount, 1)
    }
    
    func testLaunchCountIsTwoOnSecondLaunch() {
        launchCounter.trackLaunch()
        launchCounter.trackLaunch()
        XCTAssertEqual(launchCounter.launchCount, 2)
    }

    func testIsFirstLaucnhIsTrueOnFirstLaunch() {
        launchCounter.trackLaunch()
        XCTAssertTrue(launchCounter.isFirstLaunch)
    }
    
    func testIsFirstLaucnhIsFalseOnSecondLaunch() {
        launchCounter.trackLaunch()
        launchCounter.trackLaunch()
        XCTAssertFalse(launchCounter.isFirstLaunch)
    }
    
    func testResetResetsBackToZero() {
        launchCounter.trackLaunch()
        launchCounter.trackLaunch()
        launchCounter.reset()
        launchCounter.trackLaunch()
        XCTAssertTrue(launchCounter.isFirstLaunch)
    }
        
}

