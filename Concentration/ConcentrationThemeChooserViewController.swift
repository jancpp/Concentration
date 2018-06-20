//
//  ConcentrationThemeControlerViewController.swift
//  Concentration
//
//  Created by Jan Polzer on 6/19/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let themes = [ // bad design, what if we add multiple languages?
        "Helloween":"👻🎃🍎🙀🧟‍♂️👿🦇🍭🧛🏼‍♂️🧛‍♀️👹",
        "Animals":"🐷🦊🐶🐼🙉🐥🐸🐞🐟🐯🐨",
        "Sports":"🏈🎾🏀🎱⚽️⚾️🏓🏒🏐🥊🥌⛳️",
    ]
    
//     MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }
}
