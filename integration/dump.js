/*
 *  Dump application element tree
 */
UIATarget.localTarget().logElementTree();

/*
 *  Test constants
 */
var target = UIATarget.localTarget();
var app = UIATarget.localTarget().frontMostApp();
var mainWindow = UIATarget.localTarget().frontMostApp().mainWindow();


//var n, arg, name;
//UIALogger.logDebug("typeof this = " + typeof this);
//function aTestFunct() {
//alert("typeof this = " + typeof this);
//for (name in this) {
//    UIALogger.logDebug("this[" + name + "]=" + this[name]);
    //alert("this[" + name + "]=" + this[name]);
    //}