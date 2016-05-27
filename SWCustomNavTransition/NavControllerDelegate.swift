//
//  NavControllerDelegate.swift
//  SWCustomNavTransition
//
//  Created by DonMag on 5/27/16.
//  Copyright © 2016 DonMag. All rights reserved.
//

import UIKit

class NavControllerDelegate: NSObject, UINavigationControllerDelegate {

	func navigationController(navigationController: UINavigationController,
		animationControllerForOperation operation: UINavigationControllerOperation,
		fromViewController fromVC: UIViewController,
		toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

			var bPushing : Bool = true
			
			if operation == .Pop {
				bPushing = false
			}
			
			return VertTransAnimator(isPushing: bPushing)

	}
	
}
