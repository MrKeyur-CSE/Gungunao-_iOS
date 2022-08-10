//
//  PlayerViewController.swift
//  Gungunaoo
//
//  Created by Keyur Panchal on 10/08/22.
//

import UIKit

final class PlayerViewController: UIViewController {
    
    var url = ""

    @IBOutlet weak var playPauseBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient()
        Player.share.play(url: URL(string: url)!)
        playPauseBtn.setImage(UIImage(named: "LogoPause"), for: .normal)
    }

    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func onClickPlayPauseBtn(_ sender: Any) {
        if Player.share.isPlaying {
            Player.share.pause()
            playPauseBtn.setImage(UIImage(named: "LogoPlay"), for: .normal)
        } else {
            Player.share.play()
            playPauseBtn.setImage(UIImage(named: "LogoPause"), for: .normal)
        }
    }

    @IBAction private func onClickForwardBtn(_ sender: Any) {
        Player.share.seekForward()
    }

    @IBAction private func onClickBackwardBtn(_ sender: Any) {
        Player.share.seekBackward()
    }
}
