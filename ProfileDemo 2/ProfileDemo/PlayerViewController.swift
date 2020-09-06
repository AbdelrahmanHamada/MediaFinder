//
//  PlayerViewController.swift
//  MyMusic
//
//  Created by Afraz Siddiqui on 4/3/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    var movieDetails :Media?
    var arrOfMedia: [Media] = []
    public var position: Int = 0
    var flag = false

    @IBOutlet var holder: UIView!

    var player: AVQueuePlayer?

    // User Interface elements

    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()

    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()

    let playPauseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor

        guard let movie = movieDetails else {return}
        albumImageView.sd_setImage(with: URL(string: movie.artworkUrl100!))
        artistNameLabel.text = movie.artistName
        albumNameLabel.text = "\(movie.trackName ?? "")"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
        }
    }

    func configure() {
        // set up player
       // let song = songs[position]

        let urlString = movieDetails?.previewUrl

        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let urlString = urlString else {
                print("urlstring is nil")
                return
            }

            player = AVQueuePlayer(url: URL(string: urlString)!)

            guard let player = player else {
                print("player is nil")
                return
            }
            player.volume = 0.5

            player.play()
        }
        catch {
            print("error occurred")
        }

        // set up user interface elements

        // album cover
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
     //   albumImageView.image
        holder.addSubview(albumImageView)

        // Labels: Song name, album, artist
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 10,
                                     width: holder.frame.size.width-20,
                                     height: 70)
        albumNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 10 + 70,
                                     width: holder.frame.size.width-20,
                                     height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height + 10 + 140,
                                       width: holder.frame.size.width-20,
                                       height: 70)

//        songNameLabel.text = song.name
//        albumNameLabel.text = song.albumName
//        artistNameLabel.text = song.artistName

        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)

        // Player controls
        let nextButton = UIButton()
        let backButton = UIButton()

        // Frame
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 30

        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)

        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)

        backButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)

        // Add actions
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        // Styling

        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)

        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black

        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)

        // slider
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.size.height-60,
                                            width: holder.frame.size.width-40,
                                            height: 1))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
    }

    @objc func didTapBackButton() {
        if position > 0 {
            position = position - 1
            player?.pause()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
//print(player?.isMuted)
    }

    @objc func didTapNextButton() {
        if position < (arrOfMedia.count - 1) {
            position = position + 1
            player?.pause()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapPlayPauseButton() {
        if flag == false {
            // pause
            player?.pause()
            // show play button
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)

            // shrink image
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder.frame.size.width-60,
                                                   height: self.holder.frame.size.width-60)
            })
            flag = true
        }
            
        else {
             if flag == true {
            // play
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)

            // increase image size
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                              y: 10,
                                              width: self.holder.frame.size.width-20,
                                              height: self.holder.frame.size.width-20)
            })
              flag = false
            }
            
        }
    }
    

    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.pause()
        }
    }

}
//extension PlayerViewController: UIViewController {
//func initPlayer()  {
//    if let play = player {
//        print("playing")
//        play.play()
//    } else {
//        print("player allocated")
//        player = AVPlayer(URL: NSURL(string: "http://streaming.radio.rtl.fr/rtl-1-48-192")!)
//        print("playing")
//        player!.play()
//    }
//}
//
//func stopPlayer() {
//    if let play = player {
//        print("stopped")
//        play.pause()
//        player = nil
//        print("player deallocated")
//    } else {
//        print("player was already deallocated")
//    }
//}
//}
