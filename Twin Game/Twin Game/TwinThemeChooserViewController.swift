//
//  TwinThemeChooserViewController.swift
//  Twin Game
//
//  Created by Macbook on 02.01.2023.
//

import UIKit

class TwinThemeChooserViewController: UIViewController {

    let themes = [
        "Animals":"🐼🐷🙈🦆🐛🐞🪰🐼🐶🦐",
        "Travel":"🚘🚅✈️🛻🚁🛥️⛵️✈️🚡🛶🚜",
        "Foods":"🍉🍌🥝🥥🥦🍐🍓🥑🥓🥩"
    ]
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? TwinViewController {
                    cvc.theme = theme
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
}
