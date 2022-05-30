//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Jorge Benavides
//

import XCTest

class PokedexUITests: XCTestCase {

    var app: XCUIApplication!

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        // In UI tests it’s important to set the initial state -
        // such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launchArguments.append("UITestingDarkModeEnabled")
        app.launchArguments.append("-AppleInterfaceStyle Dark")

        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
    }

    func testDefaultNavigationStyle() throws {
        // Given

        // When
        app.launch()
        // Then
        XCTAssertEqual(app.navigationBars.accessibilityNavigationStyle, UIAccessibilityNavigationStyle.automatic, "incorrect navigation style")
    }

    func testSearchBar() throws {
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app
        app.navigationBars["Pokédex"].searchFields["Search a pokemon"].tap()

        if app.navigationBars["Pokédex"].searchFields["Search a pokemon"].buttons["Clear text"].exists {
            app.navigationBars["Pokédex"].searchFields["Search a pokemon"].buttons["Clear text"].tap()
        }

        app.keys["P"].tap()
        app.keys["i"].tap()
        app.keys["k"].tap()
        app.keys["a"].tap()

        app.collectionViews.cells.otherElements.containing(.staticText, identifier: " Electric ").element.tap()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
        app.terminate()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            let options = XCTMeasureOptions()
            options.iterationCount = 3
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()], options: options) {
                XCUIApplication().launch()
            }
        }
    }
}
