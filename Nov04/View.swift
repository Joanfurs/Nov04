
import UIKit
import GLKit

class View: UIView {

		var h: CGFloat = 0;
	
		required init(coder aDecoder: NSCoder) {

		super.init(coder: aDecoder)

		println("init frame = \(frame)");
		println("init bounds = \(bounds)");
	
		backgroundColor = UIColor.blueColor();
	}


	override func drawRect(rect: CGRect) {
	
		
		if h < bounds.size.height {
			++h;
			let s: String = NSLocalizedString("BYE", comment: "displayed when app is launched");

			let font: UIFont = UIFont.systemFontOfSize(32);
			let foregroundColor: UIColor = UIColor.whiteColor();

			let attributes: [NSObject: AnyObject] = [
			NSFontAttributeName: font,
			NSForegroundColorAttributeName: foregroundColor
			];

			let size: CGSize = s.sizeWithAttributes(attributes);
			let x: CGFloat = bounds.origin.x  + (bounds.size.width - size.width) / 2;
			let y: CGFloat = bounds.origin.y + (bounds.size.height - size.height);
			let point: CGPoint = CGPointMake(x, y);
			s.drawAtPoint(point, withAttributes: attributes);
			
		} else {
		
			let w: CGFloat = bounds.size.width;
			let h: CGFloat = bounds.size.height;
			
			let image: UIImage? = UIImage(named: "rocket.png");
			if image == nil {
			println("could not find rocket.png");
			return;
			}

			let point: CGPoint = CGPointMake(
			(w - image!.size.width) / 2, (h - image!.size.height)/2);

			image!.drawAtPoint(point);
	
		}
		
		let minimum: CGFloat = min(bounds.size.width, bounds.size.height);
		let longSide: CGFloat = minimum * 1 / 3;
		let shortSide: CGFloat = longSide / 3;

		let c: CGContextRef = UIGraphicsGetCurrentContext();
		CGContextTranslateCTM(c, bounds.size.width / 2, bounds.size.height);
		CGContextScaleCTM(c, 1, -1);
		
	
		let r: CGRect = CGRectMake(-shortSide/2, (0 + h), shortSide, longSide);
		CGContextAddRect(c, r);
		CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
		CGContextFillPath(c);
		
		CGContextBeginPath(c);
		CGContextMoveToPoint(c, -shortSide/2, (longSide + h));
		CGContextAddLineToPoint(c, 0,(longSide + 35 + h));
		CGContextAddLineToPoint(c, shortSide/2, (longSide + h));
		CGContextClosePath(c);
		CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
		CGContextFillPath(c);
		
		CGContextBeginPath(c);
		CGContextMoveToPoint(c, -shortSide/1.5, (0 + h));
		CGContextAddLineToPoint(c, 0, (80 + h));
		CGContextAddLineToPoint(c, shortSide/1.5, (0 + h));
		CGContextClosePath(c);
		CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
		CGContextFillPath(c);
		
		let t: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)/300);
		dispatch_after(t, dispatch_get_main_queue(), {self.setNeedsDisplay();});
	}
}
