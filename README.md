
# FitnessApp

A fitness app demoing a hue transition of an image with CoreImage APIs for rendering on GPU

<img width="100" src="https://github.com/gauravk92/FitnessApp/raw/master/Resources/Icon-512.png"/>

<img width="200" src="https://github.com/gauravk92/FitnessApp/raw/master/public/19626020135389.562e61ba160fd.PNG"/>

<img width="200" src="https://github.com/gauravk92/FitnessApp/raw/master/public/330d5420135389.562e61ba85215.PNG"/>

<img width="200" src="https://github.com/gauravk92/FitnessApp/raw/master/public/706ea320135389.562e61ba1a0e4.PNG"/>

<img width="200" src="https://github.com/gauravk92/FitnessApp/blob/master/public/b4624a20135389.562e61b9f2ae6.PNG"/>

<img width="200" src="https://github.com/gauravk92/FitnessApp/raw/master/public/fb494220135389.562e61ba95ef2.PNG"/>

### Setup Testflight

1. Create new build configuration in Xcode Projects Editor (Duplication from "Release" config)

2. Run gfitappTestFlight.sh

3. Set Xcode Target Info.plist to gfitapp/gfitappTestFlight-Info.plist for TestFlight config

4. Create new gfitappTestFlight scheme, in the pre-action, set

    cd "${PROJECT_DIR}";
    ./gfitappTestFlight.sh;

5. Set Archive build configuration to "TestFlight" for gfitappTestFlight scheme

6. Product > Archive


### Setup UIAutomation tests

1. Create symbolic link to the Pods directory in the root of the project, to integration/
(Instruments can't follow a relative path further back to the Pods/ for some reason)

3. Create a "yourtests.js" file importing "header.js" by relative file path
   "../header.js" if in integration/

4. Create another "yourtests_importer.js" file importing "yourtests.js" by relative file path
(Otherwise Instruments and Xcode will yell if you change files out from under them)

5. Product > Profile (UIAutomation)

6. Add "yourtests_importer.js" to instruments
