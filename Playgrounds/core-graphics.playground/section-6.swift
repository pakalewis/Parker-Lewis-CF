class AJSBoxView: UIView {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 25.0)
        path.lineWidth = 10.0
        
        UIColor.blueColor().setStroke()
        UIColor.yellowColor().setFill()
        
        path.fill()
        path.stroke()
    }
}

let boxView = AJSBoxView(frame: frame)
boxView.backgroundColor = UIColor.whiteColor()
