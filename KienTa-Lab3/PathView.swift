//
//  PathView.swift
//  KienTa-Lab3
//
//  Created by Kien Ta on 10/23/20.
//  Copyright © 2020 Kien Ta. All rights reserved.
//

import UIKit

class PathView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var thePath:Path? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var paths: [Path] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
     // implement this function here
        return CGPoint(x: (first.x + second.x) / 2, y: (first.y + second.y) / 2)
    }
    private func createQuadPath(points: [CGPoint]) -> UIBezierPath {
         let path = UIBezierPath() //Create the path object
         if(points.count < 2){ //There are no points to add to this path
            return path
         }
         path.move(to: points[0]) //Start the path on the first point
         for i in 1..<points.count - 1{
             let firstMidpoint = midpoint(first: path.currentPoint, second: points[i]) //Get midpoint between the path's last point and the next one in the array
             let secondMidpoint = midpoint(first: points[i], second:points[i+1]) //Get midpoint between the next point in the array and the one after it
             path.addCurve(to: secondMidpoint, controlPoint1: firstMidpoint, controlPoint2: points[i]) //This creates a cubic Bezier curve using math!
         }
         return path
    }
    
    
    func drawPath(_ pathInfor: Path){
        pathInfor.color.setStroke()
        let points = pathInfor.points
        
        if(points.count == 1 || points.count == 2){
            pathInfor.color.setFill()
            let circleCenter:CGPoint = points[0]
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: circleCenter.x, y: circleCenter.y), radius: pathInfor.thickNess / 2, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            
            circlePath.fill(with: CGBlendMode.normal, alpha: pathInfor.opacity)
        }
        else{
            let path = createQuadPath(points: points)
            path.lineWidth = pathInfor.thickNess
            path.stroke(with: CGBlendMode.normal, alpha: pathInfor.opacity)
        }
    }
    
    override func draw(_ rect: CGRect) {
        for path in paths {
            drawPath(path)
        }
        if(thePath != nil){
            drawPath(thePath!)
        }
    }

}
