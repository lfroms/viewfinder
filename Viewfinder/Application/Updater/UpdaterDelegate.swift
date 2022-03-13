//
//  UpdaterDelegate.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-08.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import Sparkle

class UpdaterDelegate: NSObject, SPUUpdaterDelegate {
    func updaterShouldPromptForPermissionToCheck(forUpdates updater: SPUUpdater) -> Bool {
        // Since this is a menu bar app that is launched and stays running, ask for update permission
        // on the first launch so that the user gets updates sooner.

        // Sparkle ignores this setting once the user has responded to the prompt.
        true
    }
}
