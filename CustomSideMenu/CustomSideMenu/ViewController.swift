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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    private func configureTableView(){
        menuTableView.delegate = self
        menuTableView.dataSource = self
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
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:  true)
    
        // TODO:- Navigation action
        print("tapped: \(menuItems[indexPath.row ])")
        // this for example
        if indexPath.row == 0 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}

