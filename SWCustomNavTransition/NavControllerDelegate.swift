//
//  NavControllerDelegate.swift
//  SWCustomNavTransition
//
//  Created by DonMag on 5/27/16.
//  Copyright © 2016 DonMag. All rights reserved.
//

import UIKit

class NavControllerDelegate: NSObject, UINavigationControllerDelegate {

	func navigationController(_ navigationController: UINavigationController,
		animationControllerFor operation: UINavigationControllerOperation,
		from fromVC: UIViewController,
		to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

			// if you only want custom transition on Pop, uncomment these next 3 lines
//			if operation != .Pop {
//				return nil
//			}

			var bPushing : Bool = true
			
			if operation == .pop {
				bPushing = false
			}
			
			return VertTransAnimator(isPushing: bPushing)

	}
	
}
