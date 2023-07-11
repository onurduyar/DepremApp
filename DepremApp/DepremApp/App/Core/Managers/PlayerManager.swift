//
//  PlayerManager.swift
//  DepremApp
//
//  Created by Onur Duyar on 11.07.2023.
//

import Foundation
import AVFoundation

final class PlayerManager {
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    init(player: AVPlayer? = nil, url: URL? = nil) {
        guard let url else {return}
        playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
    }
    func play(){
        player?.play()
        
    }
    func stop(){
        player?.pause()
    }
}
