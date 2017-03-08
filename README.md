# Setup Testflight

1. Create new build configuration in Xcode Projects Editor (Duplication from "Release" config)

2. Run gfitappTestFlight.sh

3. Set Xcode Target Info.plist to gfitapp/gfitappTestFlight-Info.plist for TestFlight config

4. Create new gfitappTestFlight scheme, in the pre-action, set

    cd "${PROJECT_DIR}";
    ./gfitappTestFlight.sh;

5. Set Archive build configuration to "TestFlight" for gfitappTestFlight scheme

6. Product > Archive


# Setup UIAutomation tests

1. Create symbolic link to the Pods directory in the root of the project, to integration/
(Instruments can't follow a relative path further back to the Pods/ for some reason)

3. Create a "yourtests.js" file importing "header.js" by relative file path
   "../header.js" if in integration/

4. Create another "yourtests_importer.js" file importing "yourtests.js" by relative file path
(Otherwise Instruments and Xcode will yell if you change files out from under them)

5. Product > Profile (UIAutomation)

6. Add "yourtests_importer.js" to instruments
