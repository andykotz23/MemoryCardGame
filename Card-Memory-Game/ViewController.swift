//
//  ViewController.swift
//  Card-Memory-Game
//
//  Created by Andy Kotz on 12/16/20.
//
/*
each round assign each image a random image and pop it from the list - add it to new list that goes back into old list at the end of the game
when they click start change all things to black or invisible or something and when they click it it should flip or show and if its the first then assign to varibale if second assing to second varibale and compare
*/
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var image0: UIButton!
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    @IBOutlet weak var image4: UIButton!
    @IBOutlet weak var image5: UIButton!
    @IBOutlet weak var image6: UIButton!
    @IBOutlet weak var image7: UIButton!
    @IBOutlet weak var image8: UIButton!
    @IBOutlet weak var image9: UIButton!
    @IBOutlet weak var image10: UIButton!
    @IBOutlet weak var image11: UIButton!
    @IBOutlet weak var startButton: UIButton!
    var buttonList: [UIButton] = []
    var picList: [UIImage] = [#imageLiteral(resourceName: "PlanktonAppPic"),#imageLiteral(resourceName: "PatrickAppPic"),#imageLiteral(resourceName: "SquidwardAppPic"),#imageLiteral(resourceName: "MrKrabsAppPic"),#imageLiteral(resourceName: "SpongebobPicApp"),#imageLiteral(resourceName: "GaryAppPic"),#imageLiteral(resourceName: "PlanktonAppPic"),#imageLiteral(resourceName: "PatrickAppPic"),#imageLiteral(resourceName: "SquidwardAppPic"),#imageLiteral(resourceName: "MrKrabsAppPic"),#imageLiteral(resourceName: "SpongebobPicApp"),#imageLiteral(resourceName: "GaryAppPic")]
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    lazy var prevButtonImage: UIImage = #imageLiteral(resourceName: "playingCardAppPic")
    lazy var prevButtonName = startButton
    var score = 0
    var timer: Timer?
    var totalTime = 60
    var difficulty = "Hard"
    @IBOutlet weak var clicksLeftLabel: UILabel!
    var clicksLeft = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonList = [image0, image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, image11]
        prevButtonName = startButton

    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        score = 0
        scoreLabel.text = "Score: 0"
        randomPics()
        startOtpTimer()
        
        switch difficulty {
        case "Easy":
            clicksLeft = 40
        case "Medium":
            clicksLeft = 30
        case "Hard":
            clicksLeft = 20
        default:
            print("Difficulty Not Selected")
        }
        clicksLeftLabel.text = "Clicks Remaining: \(clicksLeft)"
    }
    
    func startOtpTimer() {
        self.totalTime = 60
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer),userInfo: nil,repeats: true)
    }
    
    @objc func updateTimer() {
        timerLabel.text = "Time Remaining: \(String(self.totalTime))"
        if totalTime != 0 {
            totalTime -= 1
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                endGame()
                scoreLabel.text = "Out of time! Your final score was \(score)"
            }
        }
    }

    @IBAction func imagePicTapped(_ sender: UIButton) {
        //show image
        sender.backgroundColor = .white
        sender.imageView?.alpha = 1.0
        
        //check equality of tapped image with previously tapped image
        if sender.image(for: .normal) == prevButtonImage{//} && sender.titleLabel?.text != prevButtonName?.titleLabel?.text{
            prevButtonName?.setImage(#imageLiteral(resourceName: "checkAppPic"), for: .normal)
//            prevButtonName?.backgroundColor = .black
//            prevButtonName?.imageView?.alpha = 0.0
            sender.setImage(#imageLiteral(resourceName: "checkAppPic"), for: .normal)
            //sender.backgroundColor = .black
            prevButtonName = startButton
            prevButtonImage = #imageLiteral(resourceName: "checkAppPic")
            
            score += 1
            scoreLabel.text = "Score: \(score)"
            if score == 6 {
                scoreLabel.text = "Congrats you win!"
                if let timer = self.timer {
                    timer.invalidate()
                    self.timer = nil
                    //timerLabel.text = "Time remaining: \(timerLabel.text!)"
                }
            }
        } else {
            prevButtonName?.imageView?.alpha = 0.0
            prevButtonName?.backgroundColor = .green
            prevButtonName = sender.self
            prevButtonImage = sender.imageView?.image ?? #imageLiteral(resourceName: "playingCardAppPic")
        }
        clicksLeft -= 1
        clicksLeftLabel.text = "Taps Remaining: \(clicksLeft)"
        if clicksLeft == 0 {
            endGame()
            timer?.invalidate()
            self.timer = nil
            scoreLabel.text = "Ran out of clicks, your score was \(score)"
        }
        //after checking, then set prev one
        
        //prevButtonName
        
    }
    
    func randomPics() {
        var tempPicList: [UIImage] = []
        for pic in picList{
            tempPicList.append(pic)
        }
        tempPicList.shuffle()
        for button in buttonList {
            button.setImage(tempPicList.popLast(), for: .normal)
            button.imageView?.alpha = 0.0
            button.backgroundColor = .green
            //button.setBackgroundImage(#imageLiteral(resourceName: "playingCardAppPic"), for: .normal)
            tempPicList.shuffle()
        }

    }
    
    func endGame() {
        for button in buttonList {
            button.setImage(#imageLiteral(resourceName: "playingCardAppPic"), for: .normal)
            //button.setBackgroundImage(#imageLiteral(resourceName: "playingCardAppPic"), for: .normal)
        }
    }
    
    @IBAction func difficultyChosen(_ sender: UIButton) {
        difficulty = sender.titleLabel?.text ?? "Easy"
    }
    
}

