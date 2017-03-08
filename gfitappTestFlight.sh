#!/bin/sh

#  gfitappTestFlight.sh
#  gfitapp
#
#  Created by Gaurav Khanna on 1/13/14.
#  Copyright (c) 2014 Gaurav Khanna. All rights reserved.

cd "${PROJECT_DIR}";

# Cleanup any previous temp data
defaults delete INFOPLIST;
defaults delete TFPLIST;

# Import GKBundleVersion from plist to write back to project_dir
defaults import TFPLIST ./gfitapp/gfitappTestFlight.plist;

# Import GKBundleVersion to write out to new gfitappTestFlight-Info.plist
defaults import INFOPLIST ./gfitapp/gfitappTestFlight.plist;
defaults import INFOPLIST ./gfitapp/gfitapp-Info.plist;

# Increment GKBundleVersion
VNUM=`defaults read INFOPLIST GKBundleVersion`;
VERSION=$(echo $VNUM);
NEWVERSION=$(($VERSION + 1));
VSTRING="1.0."${NEWVERSION};

echo $VNUM;
echo $VERSION;
echo $NEWVERSION;
echo $VSTRING;

defaults write TFPLIST GKBundleVersion $NEWVERSION;
defaults write INFOPLIST GKBundleVersion $NEWVERSION;
defaults write INFOPLIST CFBundleVersion $NEWVERSION;
defaults write INFOPLIST CFBundleShortVersionString $VSTRING;

defaults export TFPLIST ./gfitapp/gfitappTestFlight.plist;
defaults export INFOPLIST ./gfitapp/gfitappTestFlight-Info.plist;