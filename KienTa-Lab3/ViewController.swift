//
//  ViewController.swift
//  KienTa-Lab3
//
//  Created by Kien Ta on 10/23/20.
//  Copyright © 2020 Kien Ta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentPath: Path?
    var pathCanvas: PathView!
    var points: [CGPoint] = []

    @IBOutlet weak var DrawCanvasView: UIView!
    
    @IBOutlet weak var thicknessSlider: UISlider!
    
    @IBAction func clearScreen(_ sender: UIButton) {
        pathCanvas.paths.removeAll()
    }
    
    @IBAction func undoDraw(_ sender: UIButton) {
        if pathCanvas.paths.count > 0{
            pathCanvas.paths.remove(at: pathCanvas.paths.count - 1)
        }
    }
    
    
    @IBAction func thicknessChange(_ sender: UISlider) {
        print(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pathCanvas = PathView(frame: view.frame)
        //view.subviews[3].addSubview(pathCanvas)
        DrawCanvasView.addSubview(pathCanvas)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        points.removeAll()
        guard let touchPoint = touches.first?.location(in: view) else { return }
        //print("start at \(touchPoint)")
        points.append(touchPoint)
        currentPath = nil
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else { return }
        //print("move to \(String(describing: touchPoint))");
        points.append(touchPoint)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else { return } 
        //print("end at \(String(describing: touchPoint))");
        points.append(touchPoint)
        currentPath = Path(points: points, color: UIColor.green, thickNess: 1)
        pathCanvas.paths.append(currentPath!)
        
    }


}

