//
//  TwinThemeChooserViewController.swift
//  Twin Game
//
//  Created by Macbook on 02.01.2023.
//

import UIKit

class TwinThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    let themes = [
        "Animals":"🐼🐷🙈🦆🐛🐞🪰🐼🐶🦐",
        "Travel":"🚘🚅✈️🛻🚁🛥️⛵️✈️🚡🛶🚜",
        "Foods":"🍉🍌🥝🥥🥦🍐🍓🥑🥓🥩"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? TwinViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
        
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailTwinViewCController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedTwinViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailTwinViewCController: TwinViewController? {
        return splitViewController?.viewControllers.last as? TwinViewController
    }
    
    // MARK: - Navigation
    
    private var lastSeguedTwinViewController: TwinViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? TwinViewController {
                    cvc.theme = theme
                    lastSeguedTwinViewController = cvc
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
}
