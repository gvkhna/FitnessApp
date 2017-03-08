/*
 *  Main Menu view element tests
 */

run("'Search' Field", function(target, app) {


    var searchField = $("textfield[name=Search]");
    var cancelButton = $("button[name=CANCEL]");

    searchField.logTree();
    cancelButton.logTree();

    assertTrue(searchField.isValid(true), "Search Field should be valid");
    assertTrue(cancelButton.isValid(true), "'CANCEL' Button should be valid");
    assertEquals("Search", searchField.name(), "Search Field should have a name");
    assertEquals("CANCEL", cancelButton.name(), "'CANCEL' Button should have a name");
    assertEquals("Search", searchField.value(), "Search Field value should be the placeholder");
    assertFalse(cancelButton.isVisible(), "'CANCEL' Button shouldn't be visible");


    target.pushTimeout(1);
    searchField.tap();
    target.popTimeout();

    //$(app.mainWindow()).dragInside({startOffset:{x:0.5, y:0.3}, endOffset:{x:0.5, y:0.6}, duration:0.5});
    //$(app.mainWindow()).flick({startOffset:{x:0.5, y:0.3}, endOffset:{x:0.5, y:0.6}, duration:0.5});

    assertTrue(searchField.isValid(true), "Search Field should be valid");
    assertTrue(cancelButton.isValid(true), "'CANCEL' Button should be valid");
    assertTrue(searchField.isFocused(), "Search Field should have keyboard focus");
    assertTrue(cancelButton.isVisible(), "'CANCEL' Button should be visible");

    var text = 'A Test String';
    searchField.input(text);

    assertTrue(searchField.isValid(true), "Search Field should be valid");
    assertTrue(cancelButton.isValid(true), "'CANCEL' Button should be valid");
    assertEquals(text, searchField.value(), "Search Field value should be 'A Test String'");


    target.pushTimeout(1);
    cancelButton.tap();
    target.popTimeout();

    assertTrue(searchField.isValid(true), "Search Field should be valid");
    assertTrue(cancelButton.isValid(true), "'CANCEL' Button should be valid");
    assertEquals("Search", searchField.value(), "Search Field value should be placeholder");
    assertFalse(searchField.isFocused(), "Search Field should not have keyboard focus");
    assertFalse(cancelButton.isVisible(), "Cancel button should not be visible");

    });

//test("'Scan Code' Button", function(target, app) {
//
//     assertEquals("Scan Code", $("#Scan Code").name());
//
//     });
//
//test("'HEALTH' Button", function(target, app) {
//
//     assertEquals("HEALTH", $("#HEALTH").name());
//
//     });
//
//test("'HISTORY' Button", function(target, app) {
//
//     assertEquals("HISTORY", $("#HISTORY").name());
//
//     });
//
//test("'ACTIVITY' Button", function(target, app) {
//
//     assertEquals("HISTORY", $("#HISTORY").name());
//
//     });
//
//test("'SETTINGS' Button", function(target, app) {
//
//     assertEquals("HISTORY", $("#HISTORY").name());
//
//     });


/*
 *  Main Menu interactivity tests
 */
