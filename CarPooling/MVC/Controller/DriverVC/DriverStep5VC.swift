//
//  DriverStep5VC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 11/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep5VC: UIViewController, WWCalendarTimeSelectorProtocol {
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
      @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    var ride:Ride!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateViewController(withIdentifier: "WWCalendarTimeSelector") as! WWCalendarTimeSelector
        // let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        // Do any additional setup after loading the view.
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        
        self.present(selector, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    @IBAction func actionBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionTest(sender: UIButton)
    {
        print(singleDate)
//        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateViewController(withIdentifier: "WWCalendarTimeSelector") as! WWCalendarTimeSelector
//        // let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
//        selector.delegate = self
//        selector.optionCurrentDate = singleDate
//        selector.optionCurrentDates = Set(multipleDates)
//        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
//        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
//        // Do any additional setup after loading the view.
//        selector.optionStyles.showDateMonth(true)
//        selector.optionStyles.showMonth(false)
//        selector.optionStyles.showYear(true)
//        selector.optionStyles.showTime(false)
//        self.present(selector, animated: true, completion: nil)
//        self.present(selector, animated: true, completion: nil)
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        ride.departure_date = dateFormatter.string(from: date)
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep6VC = storyboard.instantiateViewController(withIdentifier: "DriverStep6VC") as! DriverStep6VC
        vc.ride = self.ride
        
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        //dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        if let date = dates.first {
            singleDate = date
         //   dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
        }
        else {
           // dateLabel.text = "No Date Selected"
        }
        multipleDates = dates
    }

}
