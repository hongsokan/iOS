//
//  DiagonalCustomImageView.swift
//  CodeConnectNib
//
//  Created by 안홍석 on 2020/07/24.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

@IBDesignable
class DiagonalCustomImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var innerHeight: CGFloat = 0
    
    
    // 대각선으로 잘린 사각형을 그린다.
    // bezierPath
    
    // path -> layer, layer화
    
    // layer -> mask, masking
    
    // 직접 좌표 찍으며 그림 그리기
    func makePath() -> UIBezierPath {

        let path = UIBezierPath()
        path.move(to: CGPoint.zero) // 시작점
        path.addLine(to: CGPoint.init(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint.init(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint.init(x: 0, y: self.bounds.height - innerHeight))
        path.close()
        
        return path
    }
    
    // path 를 layer 로
    func pathToLayer() -> CAShapeLayer{
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = makePath().cgPath // UIBezierPath를 CGPath로
        
        return shapeLayer
    }

    func makeMask() {
        self.layer.mask = pathToLayer()
    }
    
    override func layoutSubviews() {
        makeMask()
    }
    
    // custom code -> storyboard 편집 화면에서 바로 확인하려면
    // @IBDesignable 추가
    
}
