class AJSOffsetView: UIView {
    internal var title: String {
        didSet {
            self.textLabel.text = title
            self.setNeedsDisplay()
        }
    }
    private var textLabel: UILabel!
    
    override init(frame: CGRect) {
        self.textLabel = UILabel(frame: frame)
        self.textLabel.font = UIFont.systemFontOfSize(52.0)
        self.textLabel.textColor = UIColor.whiteColor()
        self.textLabel.textAlignment = NSTextAlignment.Center
        
        self.title = ""
        
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addSubview(self.textLabel)
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: CGRectInset(rect, 1.0, 1.0))
        
        UIColor.darkGrayColor().colorWithAlphaComponent(0.8).setStroke()
        UIColor.lightGrayColor().setFill()
        
        path.fill()
        
        path.lineWidth = 1.0
        path.stroke()
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSaveGState(context)
        
        path.addClip()
        CGContextTranslateCTM(context, 0.0, 1.5)
        UIColor.whiteColor().colorWithAlphaComponent(1.0).setStroke()
        
        path.lineWidth = 1.0
        path.stroke()
        
        CGContextRestoreGState(context)
    }
}

let offetView = AJSOffsetView(frame: frame)

offetView.backgroundColor = UIColor.whiteColor()
offetView.title = "Label"
