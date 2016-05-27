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
	let duration :NSTimeInterval = 0.5
	
	init(isPushing: Bool) {
		self.isPushing = isPushing
		super.init()
	}

	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return duration
	}
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		guard
			let vc1 = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
			let vc2 = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
			let con = transitionContext.containerView()
			else {
				return
		}
		
		let r1start = transitionContext.initialFrameForViewController(vc1)
		let r2end = transitionContext.finalFrameForViewController(vc2)
		
		guard
			let v1 = transitionContext.viewForKey(UITransitionContextFromViewKey),
			let v2 = transitionContext.viewForKey(UITransitionContextToViewKey)
			else {
				return
		}
		
		let vUP		: CGFloat = -1
		let vDOWN	: CGFloat = 1
		
		var dir : CGFloat = isPushing ? vUP : vDOWN
		
		guard
			let parentNavVC = vc1.parentViewController as? UINavigationController
			else {
				return
		}
		
		let pVCs = parentNavVC.viewControllers
		
		if let ix1 = pVCs.indexOf(vc1) {
			if let ix2 = pVCs.indexOf(vc1) {
				dir = ix1 < ix2 ? vUP : vDOWN
			}
		}
		
		var r1end = r1start
		r1end.origin.y -= r1end.size.height * dir
		var r2start = r2end
		r2start.origin.y += r2start.size.height * dir
		v2.frame = r2start
		con.addSubview(v2)
		
		UIApplication.sharedApplication().beginIgnoringInteractionEvents()
		UIView.animateWithDuration(0.4, animations: {
			v1.frame = r1end
			v2.frame = r2end
			}, completion: {
				_ in
				transitionContext.completeTransition(true)
				UIApplication.sharedApplication().endIgnoringInteractionEvents()
		})
	}
		
}
