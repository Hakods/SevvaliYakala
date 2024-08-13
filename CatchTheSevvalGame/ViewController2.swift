//
//  ViewController2.swift
//  CatchTheSevvalGame
//
//  Created by Ahmet Hakan Altıparmak on 12.08.2024.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var skorLabel: UILabel!
    @IBOutlet weak var sevval1: UIImageView!
    @IBOutlet weak var sevval2: UIImageView!
    @IBOutlet weak var sevval3: UIImageView!
    @IBOutlet weak var sevval4: UIImageView!
    @IBOutlet weak var sevval5: UIImageView!
    @IBOutlet weak var sevval6: UIImageView!
    @IBOutlet weak var sevval7: UIImageView!
    @IBOutlet weak var sevval8: UIImageView!
    @IBOutlet weak var sevval9: UIImageView!
    @IBOutlet weak var enYuksekLabel: UILabel!
    
    var score = 0
    var highScore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var sevvalArray = [UIImageView]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Oyun sırasında geri butonunu gizle
        self.navigationItem.hidesBackButton = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Ekrandan ayrılırken geri butonunu göster
        self.navigationItem.hidesBackButton = false
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     

        
        
               skorLabel.text = "Score: \(score)"
               
               let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
               
               if storedHighScore == nil {
                   highScore = 0
                   enYuksekLabel.text = "En yüksek skor : \(highScore)"
               }
               
               if let newScore = storedHighScore as? Int {
                   highScore = newScore
                   enYuksekLabel.text = "En yüksek skor : \(highScore)"
               }
        
        
        sevval1.isUserInteractionEnabled = true
        sevval2.isUserInteractionEnabled = true
        sevval3.isUserInteractionEnabled = true
        sevval4.isUserInteractionEnabled = true
        sevval5.isUserInteractionEnabled = true
        sevval6.isUserInteractionEnabled = true
        sevval7.isUserInteractionEnabled = true
        sevval8.isUserInteractionEnabled = true
        sevval9.isUserInteractionEnabled = true

        
        let recognizer1 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        
        
        
        sevval1.addGestureRecognizer(recognizer1)
        sevval2.addGestureRecognizer(recognizer2)
        sevval3.addGestureRecognizer(recognizer3)
        sevval4.addGestureRecognizer(recognizer4)
        sevval5.addGestureRecognizer(recognizer5)
        sevval6.addGestureRecognizer(recognizer6)
        sevval7.addGestureRecognizer(recognizer7)
        sevval8.addGestureRecognizer(recognizer8)
        sevval9.addGestureRecognizer(recognizer9)
        
        sevvalArray = [sevval1,sevval2,sevval3,sevval4,sevval5,sevval6,sevval7,sevval8,sevval9]
        
        
        // Timer
                counter = 30
                timeLabel.text = String(counter)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
                hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideSevval), userInfo: nil, repeats: true)
                
                hideSevval()
    }
    
    
    @objc func hideSevval() {
            for sevval in sevvalArray {
                sevval.isHidden = true
            }
            
            let random = Int(arc4random_uniform(UInt32(sevvalArray.count-1)))
            sevvalArray[random].isHidden = false
        }
    
    
    
    @objc func increaseScore(){
        score += 1
        skorLabel.text = "Skor: \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        for sevval in sevvalArray {
            sevval.isHidden = true
        }
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            self.navigationItem.hidesBackButton = false

            
            // Eğer yeni en yüksek skor yapılmışsa tebrik mesajını göster
            if self.score > self.highScore {
                self.highScore = self.score
                enYuksekLabel.text = "En yüksek skor : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
                
                let congratsAlert = UIAlertController(title: "Tebrikler", message: "Tebrikler, en yüksek skoru yaptınız!", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Çıkış", style: UIAlertAction.Style.cancel) { UIAlertAction in
                    exit(0)
                }
                let replayButton = UIAlertAction(title: "Tekrar Oyna", style: UIAlertAction.Style.default) { UIAlertAction in
                    self.restartGame()
                }
                congratsAlert.addAction(okButton)
                congratsAlert.addAction(replayButton)
                self.present(congratsAlert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Süre doldu!", message: "Tekrar oynamak ister misiniz?", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Çıkış", style: UIAlertAction.Style.cancel) { UIAlertAction in
                    exit(0)
                }
                
                let replayButton = UIAlertAction(title: "Tekrar Oyna", style: UIAlertAction.Style.default) { UIAlertAction in
                    self.restartGame()
                }
                
                alert.addAction(okButton)
                alert.addAction(replayButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func restartGame() {
        self.score = 0
        self.skorLabel.text = "Score: \(self.score)"
        self.counter = 30
        self.timeLabel.text = "Time: \(self.counter)"
        
        // Geri butonunu tekrar gizle
            self.navigationItem.hidesBackButton = true
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideSevval), userInfo: nil, repeats: true)
    }
}
