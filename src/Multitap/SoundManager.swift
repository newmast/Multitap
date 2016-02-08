//
//  SoundManager.swift
//  Multitap
//
//  Created by Nick on 2/7/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import Foundation
import AVFoundation

private let SoundManagerInstance = SoundManager()

class SoundManager: NSObject {
    var backgroundMusicManager: AVAudioPlayer?
    var soundEffectsManager: AVAudioPlayer?
    
    class func sharedInstance() -> SoundManager {
        return SoundManagerInstance
    }
    
    func playSoundEffect(sound: NSString, soundExtension: NSString) {
        let url = NSBundle.mainBundle().URLForResource(sound as String, withExtension: soundExtension as String)
        if (url == nil) {
            print("Sound: \(sound) is missing!")
            return
        }
        
        do {
            soundEffectsManager = try AVAudioPlayer(contentsOfURL: url!)
        } catch {
            print("Error creating sound effects player!")
            return
        }
        if let player = soundEffectsManager {
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.play()
        }
    }
    
    func playBackgroundMusic(sound: NSString, soundExtension: NSString) {
        let url = NSBundle.mainBundle().URLForResource(sound as String, withExtension: soundExtension as String)
        if (url == nil) {
            print("Sound: \(sound) is missing!")
            return
        }
        
        do {
            backgroundMusicManager = try AVAudioPlayer(contentsOfURL: url!)
        } catch {
            print("Error creating background music manager!")
            return
        }
        if let player = backgroundMusicManager {
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        }
    }
    
    func changeVolume(value: NSNumber) {
        if let player = backgroundMusicManager {
            player.volume = Float(value)
        }
    }
    
    func resumeBackgroundMusic() {
        if let player = backgroundMusicManager {
            if !player.playing {
                player.play()
            }
        }
    }
    
    func pauseBackgroundMusic() {
        if let player = backgroundMusicManager {
            if player.playing {
                player.pause()
            }
        }
    }
}