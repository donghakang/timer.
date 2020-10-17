//
//  ViewController.swift
//  timer.
//
//  Created by Dongha Kang on 2020/10/17.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Variables
    
    // User Interaction
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
        
    // visualization
    var drawImage = UIImage()
    var drawView = UIImageView()
    
    var drawImage2 = UIImage()
    var drawView2 = UIImageView()
    
    var drawImage3 = UIImage()
    var drawView3 = UIImageView()
    
    var drawImage4 = UIImage()
    var drawView4 = UIImageView()
    
    // timer
    var timer = Timer();
    
    var isPlaying = false;
    var time = 0.0
    
    // label
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.boldSystemFont(ofSize: 60)
        timeLabel.textColor = .lightGray
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.alpha = 0.0
        return timeLabel
    }()
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // button
        setButton()
        
        // visual
        drawImage = drawLine()
        drawView = UIImageView(image: drawImage)
        drawView.alpha = 0.0
        
        drawImage2 = drawLine()
        drawView2 = UIImageView(image: drawImage2)
        drawView2.alpha = 0.0
        
        drawImage3 = drawLine()
        drawView3 = UIImageView(image: drawImage3)
        drawView3.alpha = 0.0
        
        drawImage4 = drawLine()
        drawView4 = UIImageView(image: drawImage4)
        drawView4.alpha = 0.0
        
        self.view.addSubview(drawView)              // 1초 마다
        self.view.addSubview(drawView2)             // 2초 마다
        self.view.addSubview(drawView3)             // 5초 마다
        self.view.addSubview(drawView4)             // 10초 마다
        // 0.01초에 한번씩
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
        
        // time Label
        drawTime()
    }
    
    // MARK: - Time Label∂
    func drawTime() {
        timeLabel.text = customTime.toTime(t: Int(time))
        self.view.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 28),
            timeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 28),
            timeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    // MARK: - Button interaction
    func setButton() {
        self.view.addSubview(startPauseButton)
        self.view.addSubview(stopButton)
        
        // constraints
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        startPauseButton.translatesAutoresizingMaskIntoConstraints = false
        startPauseButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100).isActive = true
        startPauseButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150).isActive = true
        startPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        startPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stopButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100).isActive = true
        stopButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150).isActive = true
        stopButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        stopButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // visual
        
        startPauseButton.setTitle("", for: .normal)
        stopButton.setTitle("", for: .normal)
        
        stopButton.tintColor = .systemRed
        startPauseButton.tintColor = .systemRed
            
        startPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        stopButton.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
        
        startPauseButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func actionPress(_ sender: Any) {
        if isPlaying {
            // it stops
            startPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
        } else {
            startPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.timeLabel.alpha = 1.0
                self.drawView.alpha = 1.0
                self.drawView2.alpha = 1.0
                self.drawView3.alpha = 1.0
                self.drawView4.alpha = 1.0
            }, completion: nil)

        }
        isPlaying = !isPlaying
        
    }
    
    @IBAction func stopPress(_ sender: Any) {
        isPlaying = false
        startPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        time = 0.0
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.timeLabel.alpha = 0.0
            self.drawView.alpha = 0.0
            self.drawView2.alpha = 0.0
            self.drawView3.alpha = 0.0
            self.drawView4.alpha = 0.0
        }, completion: nil)
    }
    
    
    // MARK: - Timer function
    @objc func runTimer() {
        if (isPlaying) {
            time += 1.0
            time = time.truncatingRemainder(dividingBy: 100000) == 0 ? 0 : time
            let newTime = easeInOutQuart(progress: time.truncatingRemainder(dividingBy: 100), max: 100)
            drawImage = drawLine(color: UIColor(red: 8/255, green: 95/255, blue: 99/255, alpha: 1),
                                 radius:170,
                                 lineWidth: 10,
                                 progress: newTime)
            drawView.image = drawImage
            
            let newTime2 = easeInOutQuart(progress: time.truncatingRemainder(dividingBy: 200), max: 200)
            drawImage2 = drawLine(color: UIColor(red: 79/255, green: 190/255, blue: 183/255, alpha: 1),
                                  radius: 155,
                                  lineWidth: 20,
                                  progress: newTime2)
            drawView2.image = drawImage2
            
            let newTime3 = easeInOutQuart(progress: time.truncatingRemainder(dividingBy: 500), max: 500)
            drawImage3 = drawLine(color: UIColor(red: 250/255, green: 207/255, blue: 90/255, alpha: 1),
                                  radius: 125,
                                  lineWidth: 40,
                                  progress: newTime3)
            drawView3.image = drawImage3
            
            let newTime4 = easeInOutQuart(progress: time.truncatingRemainder(dividingBy: 1000), max: 1000)
            drawImage4 = drawLine(color: UIColor(red: 1, green: 89/255, blue: 89/255, alpha: 1),
                                  radius: 80,
                                  lineWidth: 50,
                                  progress: newTime4)
            drawView4.image = drawImage4
            
            // Label
            drawTime()
        }
    }
    
    func easeInOutQuart(progress: Double, max: Double) -> Double {
        /*
         - curve ease in out function, but more extreme.
         
         @param {Double} progress : current location of the progress
         @param {Double} max : maximum rotation
         
         @return {Double} : 0 - 1 with curveEaseInOut.
         */
        let x = progress / max
        return x < 0.5 ? 4 * x * x * x : 1 - pow(-2 * x + 2, 3) / 2
    }
}


extension ViewController {
    func arcPercent(radius: CGFloat, progress: Double) -> UIBezierPath {
        let endAngle = (2 * .pi) * progress - (Double.pi / 2)
        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0),
                                radius: radius,
                                startAngle: CGFloat(-Double.pi / 2.0),
                                endAngle: CGFloat(endAngle),
                                clockwise: true)
        
        return path
    }

    func drawLine() -> UIImage {
        let size = view.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        UIColor.red.setStroke()
        
        let arcPath = arcPercent(radius: 100, progress: 0)
        arcPath.lineWidth = 60
        arcPath.lineCapStyle = .round
        
        let tf = CGAffineTransform(translationX: view.center.x, y: view.center.y)
        arcPath.apply(tf)
        
        arcPath.stroke()
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    func drawLine(color: UIColor, radius: CGFloat, lineWidth: CGFloat, progress: Double) -> UIImage {
        let size = view.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        color.setStroke()
        
        let arcPath = arcPercent(radius: radius, progress: progress)
        arcPath.lineWidth = lineWidth
        arcPath.lineCapStyle = .round
        
        let tf = CGAffineTransform(translationX: view.center.x, y: view.center.y)
        arcPath.apply(tf)
        
        arcPath.stroke()
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}


