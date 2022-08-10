//
//  HomeViewController.swift
//  Gungunaoo
//
//  Created by Keyur Panchal on 09/08/22.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    var audios = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient()
        listTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        FirebaseManager.fetchMusicUrls { audios in
            self.audios = audios
            self.listTableView.reloadData()
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        audios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(withIdentifier: PlayerViewController.self)
        playerVC.url = audios[indexPath.row]
        self.pushVC(playerVC)
    }
}
