//
//  HomeViewController.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Variables
    var siteData = [SiteInfo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Outlet Action
    @IBAction func searchButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func syncButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func addSiteButtonTapped(_ sender: UIButton) {
        let addSiteVc = AddSiteViewController.instance
        self.navigationController?.pushViewController(addSiteVc, animated: true)
    }
    
    class var instance : HomeViewController {
        return Storyboard.main.instantiateVC(HomeViewController.self)
    }
    
    //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "\(SiteTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(SiteTableViewCell.self)")
        loadSiteData()
    }
    
    func loadSiteData() {
        let ud = UserDefaults.standard
        guard let randomFilenames = ud.value(forKey: "paths") as? [String] else {
            return
        }
        siteData.removeAll()
        for path in randomFilenames {
            let fullPath = getDocumentsDirectory().appendingPathComponent(path)
            guard let codedData = try? Data(contentsOf: fullPath) else { return  }
            
            do {
                if let sitedata = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData) as? SiteInfo {
                    siteData.append(sitedata)
                }
            } catch {
                print("Couldn't read file.")
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//extension HomeViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return siteData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//    
//    
//}

extension HomeViewController: UITableViewDelegate {
    
}
