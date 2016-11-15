//
//  GTProgressBar.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 19/09/2016.

import UIKit

@IBDesignable
public class GTProgressBar: UIView {
    private let backgroundView = UIView()
    private let fillView = UIView()
    private let progressLabel = UILabel()
    private var _progress: CGFloat = 1
    
    public var font: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    public var progressLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    public var barMaxHeight: CGFloat? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barBorderColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barBackgroundColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barFillColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barBorderWidth: CGFloat = 2 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barFillInset: CGFloat = 2 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var progress: CGFloat {
        get {
            return self._progress
        }
        
        set {
            self._progress = min(max(newValue,0), 1)
            
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var labelTextColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var displayLabel: Bool = true {
        didSet {
            self.progressLabel.isHidden = !self.displayLabel
            self.setNeedsLayout()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareSubviews()
    }
    
    private func prepareSubviews() {
        addSubview(progressLabel)
        addSubview(backgroundView)
        addSubview(fillView)
    }
    
    public override func layoutSubviews() {
        setupProgressLabel()
        setupBackgroundView()
        setupFillView()
    }
    
    private func setupProgressLabel() {
        progressLabel.text = "\(Int(_progress * 100))%"
        let origin = CGPoint(x: progressLabelInsets.left, y: 0)
        progressLabel.frame = CGRect(origin: origin, size: sizeForLabel())
        progressLabel.font = font
        progressLabel.textAlignment = NSTextAlignment.center
        progressLabel.textColor = labelTextColor
        
        centerVerticallyInView(view: progressLabel)
    }
    
    //顶在左侧的假区域.为了奇怪的需求
    var leftCommpontView = UIView()
    
    private func setupBackgroundView() {
        
        let xOffset = backgroundViewXOffset()
        let height = min(barMaxHeight ?? frame.size.height, frame.size.height)
        let size = CGSize(width: frame.size.width - xOffset, height: height)
//        let origin = CGPoint(x: xOffset, y: 0)
        let origin = CGPoint(x: size.width * 0.05, y: 0)
        
        backgroundView.frame = CGRect(origin: origin, size: size)
        backgroundView.backgroundColor = barBackgroundColor
        backgroundView.layer.borderColor = barBorderColor.cgColor
        backgroundView.layer.borderWidth = barBorderWidth
        backgroundView.layer.cornerRadius =  cornerRadiusFor(view: backgroundView)
        
        
        if let _ = barMaxHeight {
            centerVerticallyInView(view: backgroundView)
        }
        
        var progressViewframe = backgroundView.frame
        progressViewframe.origin.x = 0
        
        
        if _progress == 0.0 {
            leftCommpontView.backgroundColor = barBackgroundColor
            leftCommpontView.makeRound(corners: [.topLeft, .bottomLeft], radius: cornerRadiusFor(view: leftCommpontView), borderColor: barBorderColor, borderWidth: barBorderWidth)
            
            progressViewframe.size.width = progressViewframe.size.width * (0.1)
        }
        else {
            leftCommpontView.backgroundColor = UIColor.init(hexString: "1BD691")
            leftCommpontView.layer.borderColor = barBorderColor.cgColor
            leftCommpontView.layer.borderWidth = barBorderWidth
            leftCommpontView.layer.cornerRadius =  cornerRadiusFor(view: leftCommpontView)
            
            progressViewframe.size.width = progressViewframe.size.width * (0.05 + _progress)
        }
        
        leftCommpontView.frame = progressViewframe
        addSubview(leftCommpontView)
    }
    
    //暂时不要这个view.alpha设置为0
    private func setupFillView() {
        let offset = barBorderWidth + barFillInset
        let fillFrame = backgroundView.frame.insetBy(dx: offset, dy: offset)
        let fillFrameAdjustedSize = CGSize(width: fillFrame.width * _progress, height: fillFrame.height)
        
        fillView.frame = CGRect(origin: fillFrame.origin, size: fillFrameAdjustedSize)
        fillView.alpha = 0.0
        fillView.backgroundColor = barFillColor
        fillView.makeRound(corners: [.topRight, .bottomRight], radius:cornerRadiusFor(view: fillView), borderColor: UIColor.clear, borderWidth: 0.0)
    }
    
    private func backgroundViewXOffset() -> CGFloat {
        return displayLabel ? progressLabel.frame.width + progressLabelInsets.left + progressLabelInsets.right : 0.0
    }
    
    private func cornerRadiusFor(view: UIView) -> CGFloat {
        return (view.frame.height / 2)
        
    }
    
    private func sizeForLabel() -> CGSize {
        let text: NSString = "100%"
        let textSize = text.size(attributes: [NSFontAttributeName : font])
        
        return CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
    }
    
    private func centerVerticallyInView(view: UIView) {
        let center = self.convert(self.center, from: self.superview)
        view.center = CGPoint(x: view.center.x, y: center.y)
    }
}