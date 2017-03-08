run("'Scan Code' Button and Gestures", function(target, app) {


//    var searchField = $("textfield[name=Search]");
//    var cancelButton = $("button[name=CANCEL]");
//
//    searchField.logTree();
//    cancelButton.logTree();
//
//    assertTrue(searchField.isValid(true), "Search Field should be valid");
//    assertTrue(cancelButton.isValid(true), "'CANCEL' Button should be valid");
//    assertEquals("Search", searchField.name(), "Search Field should have a name");
//    assertEquals("CANCEL", cancelButton.name(), "'CANCEL' Button should have a name");
//    assertEquals("Search", searchField.value(), "Search Field value should be the placeholder");
//    assertFalse(cancelButton.isVisible(), "'CANCEL' Button shouldn't be visible");
//
//
//    target.pushTimeout(1);
//    searchField.tap();
//    target.popTimeout();

    $(app.mainWindow()).dragInside({startOffset:{x:0.5, y:0.7}, endOffset:{x:0.5, y:0.2}, duration:0.2});
    //$(app.mainWindow()).flick({startOffset:{x:0.5, y:0.3}, endOffset:{x:0.5, y:0.6}, duration:0.5});

    target.pushTimeout(0.19);
    $(app.mainWindow()).dragInside({startOffset:{x:0.5, y:0.3}, endOffset:{x:0.5, y:0.6}, duration:0.2});
    target.popTimeout();
//    assertTrue(searchField.isValid(true), "Search Field should be valid");
//    assertTrue(cancelButton.isValid(true), "'CANCEL' Button should be valid");
//    assertTrue(searchField.isFocused(), "Search Field should have keyboard focus");
//    assertTrue(cancelButton.isVisible(), "'CANCEL' Button should be visible");
//
//    var text = 'A Test String';
//    searchField.input(text);
//
//    assertTrue(searchField.isValid(true), "Search Field should be valid");
//    assertTrue(cancelButton.isValid(true), "'CANCEL' Button should be valid");
//    assertEquals(text, searchField.value(), "Search Field value should be 'A Test String'");
//
//
//    target.pushTimeout(1);
//    cancelButton.tap();
//    target.popTimeout();
//
//    assertTrue(searchField.isValid(true), "Search Field should be valid");
//    assertTrue(cancelButton.isValid(true), "'CANCEL' Button should be valid");
//    assertEquals("Search", searchField.value(), "Search Field value should be placeholder");
//    assertFalse(searchField.isFocused(), "Search Field should not have keyboard focus");
//    assertFalse(cancelButton.isVisible(), "Cancel button should not be visible");

    });