//
//  Player.swift
//  Gungunaoo
//
//  Created by Keyur Panchal on 09/08/22.
//

import AVFoundation

final class Player {
    
    static var share = Player()
    private var player = AVPlayer()
    private var _isPlaying = false
    
    private init() {}
    
    func play(url: URL) {
        player = AVPlayer(url: url)
        player.allowsExternalPlayback = true
        player.appliesMediaSelectionCriteriaAutomatically = true
        player.automaticallyWaitsToMinimizeStalling = true
        player.volume = 1
        player.play()
        _isPlaying = true
    }
    
    func pause() {
        player.pause()
        _isPlaying = false
    }
    
    func play() {
        player.play()
        _isPlaying = true
    }
    
    var isPlaying: Bool {
        _isPlaying
    }
    
    func seekForward() {
        guard let currentItem = player.currentItem else { return }
        let playerCurrentTime = CMTimeGetSeconds(currentItem.currentTime())
        let newTime = playerCurrentTime + 10
        if newTime < CMTimeGetSeconds(currentItem.duration) {
            player.pause()
            self.seek(duration: newTime)
        }
//        player.seek(to: min(player.currentTime() + CMTime(seconds: 10.0, preferredTimescale: .zero), CMTime(seconds: CMTimeGetSeconds(player.currentItem?.duration), preferredTimescale: .zero)))
    }
    
    private func seek(duration:Double) {
        if duration.isNaN {
            return
        }
        player.seek(to: CMTime(value: Int64(duration * 1000 as Float64), timescale: 1000)) { (result) in
            self.player.play()
        }
    }
    
    func seekBackward() {
        guard let currentItem = player.currentItem else { return }
        let playerCurrentTime = CMTimeGetSeconds(currentItem.currentTime())
        let newTime = playerCurrentTime - 10
        if newTime >= 0 {
            player.pause()
            self.seek(duration: newTime)
        }
//        player.seek(to: max(player.currentTime() - CMTime(seconds: 10.0, preferredTimescale: .zero), CMTime(seconds: 0.0, preferredTimescale: .zero)))
    }
}
