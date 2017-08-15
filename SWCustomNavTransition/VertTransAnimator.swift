//
//  VertTransAnimator.swift
//  SWCustomNavTransition
//
//  Created by DonMag on 5/27/16.
//  Copyright © 2016 DonMag. All rights reserved.
//

import UIKit

class VertTransAnimator: NSObject, UIViewControllerAnimatedTransitioning {

	let isPushing : Bool
	let duration : TimeInterval = 0.5
	
	init(isPushing: Bool) {
		self.isPushing = isPushing
		super.init()
	}

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return duration
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard
			let vc1 = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
			let vc2 = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
			else {
				return
		}
		
		let con = transitionContext.containerView
		
		let r1start = transitionContext.initialFrame(for: vc1)
		let r2end = transitionContext.finalFrame(for: vc2)
		
		guard
			let v1 = transitionContext.view(forKey: UITransitionContextViewKey.from),
			let v2 = transitionContext.view(forKey: UITransitionContextViewKey.to)
			else {
				return
		}
		
		let vUP		: CGFloat = 1
		let vDOWN	: CGFloat = -1
		
		let dir : CGFloat = isPushing ? vUP : vDOWN
		
		var r1end = r1start
		r1end.origin.y -= r1end.size.height * dir
		var r2start = r2end
		r2start.origin.y += r2start.size.height * dir
		v2.frame = r2start
		con.addSubview(v2)
		
		UIApplication.shared.beginIgnoringInteractionEvents()
		UIView.animate(withDuration: 0.4, animations: {
			v1.frame = r1end
			v2.frame = r2end
			}, completion: {
				_ in
				transitionContext.completeTransition(true)
				UIApplication.shared.endIgnoringInteractionEvents()
		})
	}
		
}
