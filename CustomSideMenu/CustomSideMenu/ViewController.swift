//
//  ViewController.swift
//  CustomSideMenu
//
//  Created by Eslam Ali  on 15/10/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    var menuItems = ["Home", "Settings", "Profile", "Terms an c Conditions", "Privacy Policy" ]
    
    @IBOutlet var mainContainerView: UIView!
    @IBOutlet weak var homeContainerView: UIView!
    
    
    var isMenuOppend = false // false because first time will be closed
    let screen =  UIScreen.main.bounds // shortcut for screen bounds
    var home = CGAffineTransform()  // to go back to home easyer when side menu is shown
    
    var swipeGestureRecognizer : UISwipeGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the initial position for the screen to be home container view
        home = homeContainerView.transform
        configureNavBar()
        configureTableView()
        configureSwapGestureRecognizer()
        configureTapRecognizer()
        // Do any additional setup after loading the view.
    }
    
    private func configureTableView(){
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    private func configureNavBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
    private func configureSwapGestureRecognizer(){
         swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        homeContainerView.addGestureRecognizer(swipeGestureRecognizer)
        mainContainerView.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    
    private func configureTapRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHome))
        homeContainerView.addGestureRecognizer(tapRecognizer)
    }
    
    private func showMenu(){
        homeContainerView.layer.cornerRadius = 40
        let x = screen.width * 0.8
        let origialTransform = self.homeContainerView.transform
        let scaledTransform = origialTransform.scaledBy(x:  0.8, y: 0.8 )
        let scaledAndTraslatedTransform = scaledTransform.translatedBy (x: x, y: 0)
        
        UIView.animate(withDuration: 0.4) {
            self.homeContainerView.transform = scaledAndTraslatedTransform
        }
        isMenuOppend = true
    }
    
    private func hideMenu(){
    
        UIView.animate(withDuration: 0.4) {
            self.homeContainerView.transform = self.home
            self.homeContainerView.layer.cornerRadius = 0
        }
        isMenuOppend = false
    }
    
    
    @IBAction func didTapMenuButton(_ sender: Any) {
        print("menu button tapped")
        if isMenuOppend == false {
            showMenu()
        }else {
            hideMenu()
        }
    }
    @objc private func didSwipe (_ sender : UISwipeGestureRecognizer){

        if isMenuOppend == false, swipeGestureRecognizer.direction == .right {
            showMenu()
        }else if isMenuOppend == true{
            hideMenu()
        }
    }
    
    @objc private func didTapHome(_ sender :UITapGestureRecognizer){
        
        if isMenuOppend == true {
            hideMenu()
        }
    }
    
    


}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell else {
            print("cant find cell")
            return UITableViewCell()
        }
        cell.configureCell(itemName: menuItems[indexPath.row])
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.frame.width, bottom: 0, right: 0)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:  true)
    
        // TODO:- Navigation action
        print("tapped: \(menuItems[indexPath.row ])")
        // this for example
        if indexPath.row == 0 {
            hideMenu()
        }else if indexPath.row == 1 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}

