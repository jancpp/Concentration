//
//  ConcentrationThemeControlerViewController.swift
//  Concentration
//
//  Created by Jan Polzer on 6/19/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit

// delegate for split view controller
class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    let themes = [ // bad design, what if we add multiple languages?
        "Helloween":"👻🎃🍎🙀🧟‍♂️👿🦇🍭🧛🏼‍♂️🧛‍♀️👹",
        "Animals":"🐷🦊🐶🐼🙉🐥🐸🐞🐟🐯🐨",
        "Sports":"🏈🎾🏀🎱⚽️⚾️🏓🏒🏐🥊🥌⛳️",
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    // colapses detail on top of master, on small screens, nil theme = don't colapse = true
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController, // detail
        onto primaryViewController: UIViewController  // master
        ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false // means: I didn't colapse it, you should do it
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        // split view for bigger screens
        if let cvc = splitViewDetailConcentratoinViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        }
        // this will hold view in heap, so we can change theme on small screens
        else if let cvc = lastSequedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            // seque from code
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentratoinViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // MARK: - Navigation
    
    private var lastSequedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSequedToConcentrationViewController = cvc
                }
            }
        }
    }
}
