//
//  ViewController.swift
//  MusicPlayer
//
//  Created by 안홍석 on 2020/01/21.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable
class ViewController: UIViewController {
    
    // MARK: Property
    var player: AVAudioPlayer!
    var timer: Timer!
    
    var playerView = UIView()
    var playPauseButton = UIButton()
    var timeLabel = UILabel()
    var progressSlider = UISlider()
    
    /*
    // MARK: IBOutlet
    @IBOutlet var playerView: UIView!
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.addViews()
        self.initializePlayer()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
}



// MARK: - Method
extension ViewController {
    
    // 뮤직플레이어를 초기화하는 메서드
    func initializePlayer() {
        
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else {
            print("음원 파일 에셋을 가져올 수 없습니다")
            
            let message: String
            message = "음원 파일 에셋을 가져올 수 없습니다"
            
            let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
            
            let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in
                
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            // 이 뷰컨트롤러의 인스턴스가 player(AVAudioPlayer클래스타입)의 delegate로 역할을 수행하겠다고 할당한 것
            // 뷰컨트롤러가 player의 delegate역할을 수행하겠다.
            self.player.delegate = self
        } catch let error as NSError {
            // print("플레이어 초기화 실패")
            // print("코드 : \(error.code), 메세지 : \(error.localizedDescription)")
            
            let message: String
            message = "플레이어 초기화 실패. \(error.localizedDescription)"
            
            let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
            
            let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in
                
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        self.progressSlider.maximumValue = Float(self.player.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player.currentTime)
    }
    
    // 레이블을 매초마다 업데이트 해주는 메서드
    func updateTimeLabelText(time: TimeInterval) {
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeText: String = String(format: "%02ld:%02ld:%02ld", minute, second, milisecond)
        
        self.timeLabel.text = timeText
    }
    
    // 타이머 만들고 수행
    func makeAndFireTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer: Timer) in
            
            if self.progressSlider.isTracking { return }
            
            self.updateTimeLabelText(time: self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
        })
        self.timer.fire()
    }
    
    // 타이머 해제
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
    
    // AudioPlayer의 플레이가 끝났을 때 호출할 메서드
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseButton.isSelected = false
        self.progressSlider.value = 0
        self.updateTimeLabelText(time: 0)
        self.invalidateTimer()
    }
    
    
    
    // MARK: IBAction
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.player?.play()
        } else {
            self.player?.pause()
        }
        
        if sender.isSelected {
            self.makeAndFireTimer()
        } else {
            self.invalidateTimer()
            
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking { return }
        self.player.currentTime = TimeInterval(sender.value)
    }
}



// MARK: Views
extension ViewController {
    
    func addViews() {
        self.addUIView()
        self.addPlayPauseButton()
        self.addTimeLabel()
        self.addProgressSlider()
    }
    
    func addUIView() {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        
        view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
//        view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
//        view.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 1).isActive = true
        
        self.playerView = view
    }
    
    func addPlayPauseButton() {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.playerView.addSubview(button)
        
        button.setImage(UIImage(named: "button_play"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "button_pause"), for: UIControl.State.selected)
        
        button.addTarget(self, action: #selector(self.touchUpPlayPauseButton(_:)), for: UIControl.Event.touchUpInside)
        
        button.centerXAnchor.constraint(equalTo: self.playerView.centerXAnchor).isActive = true
        NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.playerView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.7, constant: 0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
//        button.widthAnchor.constraint(equalTo: self.playerView.widthAnchor, multiplier: 0.5).isActive = true
//        button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1).isActive = true
        
        self.playPauseButton = button
    }
    
    func addTimeLabel() {
        let timeLabel: UILabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.playerView.addSubview(timeLabel)
        
        timeLabel.textColor = UIColor.black
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        timeLabel.centerXAnchor.constraint(equalTo: self.playPauseButton.centerXAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.playPauseButton.bottomAnchor, constant: 8).isActive = true
        
        self.timeLabel = timeLabel
        self.updateTimeLabelText(time: 0)
    }
    
    func addProgressSlider() {
        let slider: UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        self.playerView.addSubview(slider)
        
        slider.minimumTrackTintColor = UIColor.red
        
        slider.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        slider.centerXAnchor.constraint(equalTo: self.timeLabel.centerXAnchor).isActive = true
        slider.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 8).isActive = true
        slider.leadingAnchor.constraint(equalTo: self.playerView.leadingAnchor, constant: 16).isActive = true
        slider.trailingAnchor.constraint(equalTo: self.playerView.trailingAnchor, constant: -16).isActive = true
        
        self.progressSlider = slider
    }
}


// MARK: AVAudioPlayerDelegate
// 어떤 상황이 발생할 때마다 미리 약속해두었던 메서드들을 수행
extension ViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        
        guard let error: Error = error else {
            print("오디오 플레이어 디코드 오류발생")
            return
        }
        
        let message: String
        message = "오디오 플레이어 오류 발생 \(error.localizedDescription)"
        
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in
            
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
