//
//  UIScrollViewDelegateScrollAndDragPrinting.swift
//  OOUIKit
//
//  Created by Karsten Litsche on 03.11.17.
//

import UIKit

public final class UIScrollViewDelegateScrollAndDragPrinting: NSObject, UIScrollViewDelegate {
    
    // MARK: - init
    
    convenience override init() {
        fatalError("Not supported!")
    }
    
    public init(_ decorated: UIScrollViewDelegate, filterKey: String = "") {
        self.decorated = decorated
        // add space if exist to separate following log
        self.filterKey = filterKey.count == 0 ? "" : "\(filterKey) "
    }
    
    // MARK: - protocol: UIScrollViewDelegate
    
    public final func scrollViewDidScroll(_ scrollView: UIScrollView) {
        printUI("\(filterKey)scrollview didScroll called")
        decorated.scrollViewDidScroll?(scrollView)
    }
    
    public final func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        printUI("\(filterKey)scrollview willBeginDragging called")
        decorated.scrollViewWillBeginDragging?(scrollView)
    }
    
    public final func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        printUI("\(filterKey)scrollview willEndDragging called (\n  velocity=\(velocity)\n  targetContentOffset=\(targetContentOffset)\n)")
        decorated.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    public final func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        printUI("\(filterKey)scrollview didEndDragging called (\n  decelerate=\(decelerate)\n)")
        decorated.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    public final func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        printUI("\(filterKey)scrollview shouldScrollToTop called")
        return decorated.scrollViewShouldScrollToTop?(scrollView) ?? true
    }
    
    public final func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        printUI("\(filterKey)scrollview didScrollToTop called")
        decorated.scrollViewDidScrollToTop?(scrollView)
    }
    
    public final func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        printUI("\(filterKey)scrollview willBeginDecelerating called")
        decorated.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    public final func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        printUI("\(filterKey)scrollview didEndDecelerating called")
        decorated.scrollViewDidEndDecelerating?(scrollView)
    }

    // MARK: - private
    
    private let decorated: UIScrollViewDelegate
    private let filterKey: String
    
}

