class AJSCircleView: UIView {
    
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layer = self.layer as CAShapeLayer
        layer.lineWidth = 2.0
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = UIColor.blueColor().CGColor
        layer.contentsScale = UIScreen.mainScreen().scale;
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.mainScreen().scale * 2.0
        
        let path = UIBezierPath(ovalInRect: CGRectInset(self.bounds, 4.0, 4.0)).CGPath
        layer.path = path
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

let circleView = AJSCircleView(frame: frame)
