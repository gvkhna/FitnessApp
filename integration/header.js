#import "Pods/tuneup_js/tuneup.js"
#import "Pods/mechanic_js/src/mechanic-core.js"
#import "Pods/mechanic_js/src/events.js"
#import "Pods/mechanic_js/src/data.js"
#import "Pods/mechanic_js/src/logging.js"
#import "dump.js"
#import "run.js"

UIATarget.onAlert = function onAlert(alert) {
    var title = alert.name();
    UIALogger.logWarning("Alert with title '" + title + "' encountered.");
    // return false to use the default handler
    return false;
}
