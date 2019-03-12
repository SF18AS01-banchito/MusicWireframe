//
//  ViewController.swift
//  MusicWireframe
//
//  Created by Esteban Ordonez on 3/12/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import UIKit;
import AVFoundation;

class ViewController: UIViewController {
    

    @IBOutlet weak var forwardBackGround: UIView!
    @IBOutlet weak var playBackGround: UIView!
    @IBOutlet weak var reverseBackGround: UIView!
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var reverseButton: UIButton!
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    let  composers: [Composer] = [
        Composer(imageName: "Elvis_Presley.jpg", soundName: "elvis", soundExtension:"mp3"),
        Composer(imageName: "Johann_Sebastian_Bach.jpg", soundName: "musette", soundExtension:"mp3")
    ];
    
    var current: Int = 0 {
        didSet {
            isPlaying = true;
            let composer: Composer = composers[current];
            albumImageView.image = UIImage(named: composer.imageName);
            
            guard let url: URL = Bundle.main.url(forResource: composer.soundName, withExtension: "mp3") else {
                return;
            }
            print("url = \(url)");
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url);
            } catch {
                print("could not create AVAudioPlayer: \(error)");
                return;
            }
            isPlaying = true;
        }
    }
    
    var audioPlayer: AVAudioPlayer? = nil;

    var isPlaying: Bool = false {
        didSet{
            let filename: String = isPlaying ? "pause" : "play";
            
            playButton.setImage(UIImage(named: filename)!, for: .normal);
            
            if isPlaying{
                audioPlayer?.play();
            }else{
                audioPlayer?.pause();
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        reverseBackGround.layer.cornerRadius = 35.0;
        reverseBackGround.clipsToBounds = true;
        reverseBackGround.alpha = 0.0;
        
        playBackGround.layer.cornerRadius = 35.0;
        playBackGround.clipsToBounds = true;
        playBackGround.alpha = 0.0;
        
        forwardBackGround.layer.cornerRadius = 35.0;
        forwardBackGround.clipsToBounds = true;
        forwardBackGround.alpha = 0.0;
        
        [reverseBackGround, playBackGround, forwardBackGround].forEach {
            $0!.layer.cornerRadius = 35.0;
            $0!.clipsToBounds = true;
            $0!.alpha = 0.0;
            
        }
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        if isPlaying {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform =
                    CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = .identity;
            }
        }
        isPlaying = !isPlaying;
        print("Hello from play button tapped")
    }
    
    @IBAction func touchedUpInside(_ sender: UIButton) {
        var buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackGround
            if current == 0 {
                current = composers.count - 1;
            }else{
                current -= 1;
            }
        case playButton:
            buttonBackground = playBackGround
        case forwardButton:
            buttonBackground = forwardBackGround;
            if current == composers.count - 1 {
                current = 0;
            }else{
                current += 1;
            }
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackground.alpha = 0.0
            buttonBackground.transform = CGAffineTransform(scaleX:
            1.2, y: 1.2)
            sender.transform = CGAffineTransform.identity
        }) { _ in
            buttonBackground.transform = CGAffineTransform.identity
        }
        
        
    }
        
    
    
    @IBAction func touchedDown(_ sender: UIButton) {
        var buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackGround
        case playButton:
            buttonBackground = playBackGround
        case forwardButton:
            buttonBackground = forwardBackGround
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25){
            buttonBackground.alpha = 0.3
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
    }
    
    
}



