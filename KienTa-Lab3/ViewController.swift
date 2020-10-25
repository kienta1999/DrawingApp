//
//  ViewController.swift
//  KienTa-Lab3
//
//  Created by Kien Ta on 10/23/20.
//  Copyright © 2020 Kien Ta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pathCanvas: PathView!
    var thickNess:CGFloat = 15
    var opacity:CGFloat = 1
    var allColor: [UIColor] = [.green, .systemIndigo, .orange, .red, .systemTeal, .yellow, .black]
    var color:UIColor = .green
    var removedPaths:[Path] = []

    @IBOutlet weak var DrawCanvasView: UIView!
    
    @IBOutlet weak var thicknessSlider: UISlider!
    
    @IBAction func clearScreen(_ sender: UIButton) {
        pathCanvas.paths.removeAll()
        pathCanvas.thePath = nil
    }
    
    @IBAction func undoDraw(_ sender: UIButton) {
        if pathCanvas.paths.count > 0{
            let removedPath = pathCanvas.paths.remove(at: pathCanvas.paths.count - 1)
            removedPaths.append(removedPath)
            //print(removedPaths.count)
        }
        pathCanvas.thePath = nil
    }
    
    
    @IBAction func redoDraw(_ sender: UIButton) {
        if removedPaths.count > 0{
            pathCanvas.paths.append(removedPaths.remove(at: removedPaths.count - 1))
        }
        
    }
    
    
    @IBAction func opacityChange(_ sender: UISlider) {
        opacity = CGFloat(sender.value)
    }
    
    @IBAction func thicknessChange(_ sender: UISlider) {
        thickNess = CGFloat(sender.value * 30)
    }
    
    
    @IBAction func saveImage(_ sender: UIButton) {
        UIGraphicsBeginImageContext(pathCanvas.bounds.size)
        pathCanvas.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    @IBAction func colorChange(_ sender: UIButton) {
        color = allColor[sender.tag]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pathCanvas = PathView(frame: CGRect(x: 0, y: 0, width: DrawCanvasView.frame.width, height: DrawCanvasView.frame.height))
        //view.subviews[3].addSubview(pathCanvas)
        DrawCanvasView.addSubview(pathCanvas)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: DrawCanvasView) else { return }
        //print("start at \(touchPoint)")
        pathCanvas.thePath = Path(points: [], color: color, thickNess: thickNess, opacity: opacity)
        pathCanvas.thePath!.points.append(touchPoint)
        removedPaths = []
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: DrawCanvasView) else { return }
        //print("move to \(String(describing: touchPoint))");
        pathCanvas.thePath!.points.append(touchPoint)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: DrawCanvasView) else { return }
        //print("end at \(String(describing: touchPoint))");
        pathCanvas.thePath!.points.append(touchPoint)
        pathCanvas.paths.append(pathCanvas.thePath!)
        
    }


}

