class AJSRightAngleView: UIView {
    override func drawRect(rect: CGRect) {
        
        let insetRect = CGRectInset(rect, 5, 5)
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(CGRectGetMinX(insetRect) + 0.5, CGRectGetMaxY(insetRect) - 0.5))
        path.addLineToPoint(CGPointMake(CGRectGetMaxX(insetRect) - 0.5, CGRectGetMaxY(insetRect) - 0.5))
        path.addLineToPoint(CGPointMake(CGRectGetMaxX(insetRect) - 0.5, CGRectGetMinY(insetRect) + 0.5))
        
        UIColor.blueColor().setStroke()
        
        path.stroke()
    }
}

let rightAngleView = AJSRightAngleView(frame: frame)
rightAngleView.backgroundColor = UIColor.whiteColor()
