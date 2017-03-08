//#import "../../header.js"

#import "Pods/tuneup_js/tuneup.js"
#import "Pods/mechanic_js/mechanic.js"


test("Search Field Text", function(target, app) {

  var target = UIATarget.localTarget();
  var app = target.frontMostApp();
  var window = app.mainWindow();

  // tap the left button in the navigation bar
  //window.navigationBars()[0].leftButton().tap();

  $('window').logTree();
  assertEquals("Search", window.textFields()[0].value());
  //$('[name=HEALTH] text').tap();
  //window.elementJSONDump();
  // now assert that the app has navigated into a sub-view controller
  //assertEquals("Settings", window.navigationBars()[0].value());
});


test("Scan Code Button Text", function(target, app) {

  var target = UIATarget.localTarget();
  var app = target.frontMostApp();
  var window = app.mainWindow();

  // tap the left button in the navigation bar
  //window.navigationBars()[0].leftButton().tap();

  //UIALogger.logMessage( "Tap the search button" );
  assertEquals("Scan Code", window.buttons()[0].name());
  //$('[name=HEALTH] text').tap();
  //window.elementJSONDump();
  // now assert that the app has navigated into a sub-view controller
  //assertEquals("Settings", window.navigationBars()[0].value());
});

test("Collection View Text", function(target, app) {

  var target = UIATarget.localTarget();
  var app = target.frontMostApp();
  var window = app.mainWindow();

  // tap the left button in the navigation bar
  //window.navigationBars()[0].leftButton().tap();

  //UIALogger.logMessage( "Tap the search button" );
  assertEquals("HEALTH", window.collectionViews()[0].cells()[0].name());
  //$('[name=HEALTH] text').tap();
  //window.elementJSONDump();
  // now assert that the app has navigated into a sub-view controller
  //assertEquals("Settings", window.navigationBars()[0].value());
});

// test("Navigation Event", function(target, app) {

//   var target = UIATarget.localTarget();
//   var app = target.frontMostApp();
//   var window = app.mainWindow();

//   // tap the left button in the navigation bar
//   //window.navigationBars()[0].leftButton().tap();

//   //UIALogger.logMessage( "Tap the search button" );
//   window.collectionViews()[0].cells()["HEALTH"].tap();

//   target.pushTimeout(1);
//   assertEquals("Health", window.navigationBar().name());
//   target.popTimeout();
//   //$('[name=HEALTH] text').tap();
//   //window.elementJSONDump();
//   // now assert that the app has navigated into a sub-view controller
//   //assertEquals("Settings", window.navigationBars()[0].value());
// });

// test("Main Menu View", function(target, app) {
//   assertWindow({
//     navigationBar: {
//       leftButton: { name: "Back" },
//       rightButton: { name: "Done" }
//     },
//     tableViews: [
//       {
//         groups: [
//           { name: "First Name" },
//           { name: "Last Name" }
//         ],
//         cells: [
//           { name: "Fred" },
//           { name: "Flintstone" }
//         ]
//       }
//     ]
//   });
// });