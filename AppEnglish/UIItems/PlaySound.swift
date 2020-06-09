//
//  PlaySound.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/9/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String , type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
          print("Error : Sound !!!")
        }
    }
}

