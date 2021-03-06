//
//  DriverStep6VC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 11/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep6VC: UIViewController ,WWCalendarTimeSelectorProtocol {
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    @IBOutlet weak var dateLabel: UILabel!
    var ride:Ride!
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true  //Archit
    }
    override func viewDidAppear(_ animated: Bool) {
      
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateViewController(withIdentifier: "WWCalendarTimeSelector") as! WWCalendarTimeSelector

        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)

        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        self.present(selector, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
      
    }
    @IBAction func actionTest(sender: UIButton)
    {
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateViewController(withIdentifier: "WWCalendarTimeSelector") as! WWCalendarTimeSelector
        
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        self.present(selector, animated: true, completion: nil)
        
    }
    func WWCalendarTimeSelectorCancel(_ selector: WWCalendarTimeSelector, date: Date) {
        self.navigationController?.popViewController(animated: true)
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        ride.departure_time = dateFormatter.string(from: date)
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep7VC = storyboard.instantiateViewController(withIdentifier: "DriverStep7VC") as! DriverStep7VC
        // self.present(vc, animated: true, completion: nil)
        vc.ride = self.ride
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
