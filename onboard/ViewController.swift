//
//  ViewController.swift
//  onboard
//
//  Created by Ada 2018 on 25/06/18.
//  Copyright © 2018 Academy 2018. All rights reserved.
//

import UIKit
import SwiftyGif

class ViewController: UIViewController, UIScrollViewDelegate {
    var slides: [Slide] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollVIew(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        
        view.bringSubview(toFront: pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSlides() -> [Slide]{
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        
        let image1 = UIImage(gifName: "animat-rocket-color")
        let image2 = UIImage(gifName: "animat-search-color")
        let image3 = UIImage(gifName: "animat-pencil-color")
        
        slide1.imageView.setGifImage(image1)
        slide1.lblTitle.text = "Welcome to Spoud!"
        slide1.lblText.text = "Find other college students and ask questions, make new friends or make new contacts!"
        slide1.btnNext.setTitle("Next", for: .normal)
        slide1.btnNext.addTarget(self, action: #selector(self.nextSlide(sender:)), for: .touchUpInside)

        slide2.imageView.setGifImage(image2)
        slide2.lblTitle.text = "Filters"
        slide2.lblText.text = "You can filter the students by the university, fields of study, name or major. This makes it easier to talk to the right person."
        slide2.btnNext.setTitle("Next", for: .normal)
        slide2.btnNext.addTarget(self, action: #selector(self.nextSlide(sender:)), for: .touchUpInside)

        
        slide3.imageView.setGifImage(image3)
        slide3.lblTitle.text = "Direct message"
        slide3.lblText.text = "Chat with your new friend for free through iMessage with your iPhone! "
        slide3.btnNext.setTitle("Let's start!", for: .normal)
        slide1.btnNext.addTarget(self, action: #selector(self.finishOnboarding(sender:)), for: .touchUpInside)

        
        return [slide1, slide2, slide3]
    }
    @objc func nextSlide(sender: UIButton) {
        if sender.currentTitle == "Next" {
            var frame = self.scrollView.frame
            frame.origin.x = frame.size.width * CGFloat(pageControl.currentPage+1)
            frame.origin.y = 0
            scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    @objc func finishOnboarding(sender: UIButton) {
        if sender.currentTitle == "Let's start!" {
            self.dismiss(animated: true, completion: nil)
        }
    }
    func setupSlideScrollVIew(slides: [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 1.0)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.5) {
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.5, y: (0.50-percentOffset.x)/0.5)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.5 && percentOffset.x <= 1) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.5, y: (1-percentOffset.x)/0.5)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
            
        } //else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            //slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            //slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
        
    }
}

