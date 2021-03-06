//
//  RouletteViewController.swift
//  WhatToEat
//
//  Created by 김기현 on 2020/07/15.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import Charts

class RouletteViewController: UIViewController {
    @IBOutlet weak private var pieChartView: PieChartView!
    @IBOutlet weak private var spinButton: UIButton!
    @IBOutlet weak private var spaceView: UIView!
    @IBOutlet weak private var retryButton: UIButton!
    @IBOutlet weak private var anotherButton: UIButton!
    
    
    
    let food = ["한식", "양식", "중식", "일식", "분식", "패스트푸드", "야식", "기타"]
    let angle = [2, 2, 2, 2, 2, 2, 2, 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonInit()
        
        customizeChart(dataPoints: food, values: angle.map { Double($0) })
        pieChartView.rotationEnabled = false
        
    }
    
    func buttonInit() {
        spinButton.layer.borderWidth = 1
        spinButton.layer.borderColor = UIColor.white.cgColor
        spinButton.layer.cornerRadius = 10
        
        retryButton.isHidden = true
        retryButton.layer.borderWidth = 1
        retryButton.layer.borderColor = UIColor.white.cgColor
        retryButton.layer.cornerRadius = 10
        
        anotherButton.isHidden = true
        anotherButton.layer.borderWidth = 1
        anotherButton.layer.borderColor = UIColor.white.cgColor
        anotherButton.layer.cornerRadius = 10
        
        spaceView.isHidden = true
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
//            let data = PieChartDataEntry(value: values[i], label: dataPoints[i])
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        pieChartDataSet.drawValuesEnabled = false
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        // 4. Assign it to the chart’s data
        pieChartView.data = pieChartData
        pieChartView.legend.enabled = false
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        return colors
    }
    
    @IBAction func spinButtonClick(_ sender: Any) {
        let random = Int.random(in: 0...359) + 1440
        let duration = 1
        var real = 0
        
        spaceView.isHidden = false
        retryButton.isHidden = false
        anotherButton.isHidden = false
        spinButton.isHidden = true
        
        print("random: \(random)")
        
        pieChartView.spin(duration: TimeInterval(duration*1000), fromAngle: CGFloat(0), toAngle: -CGFloat(random)) { (lhs, rhs) -> Double in
            if lhs < Double(duration) {
                return lhs
            } else {
                return rhs
            }
        }
        
        real = random - 1440
        print("real: \(real)")
        
        switch real {
        case 0...45:
            print("야식")
        case 46...90:
            print("기타")
        case 91...135:
            print("한식")
        case 136...180:
            print("양식")
        case 181...225:
            print("중식")
        case 226...270:
            print("일식")
        case 271...315:
            print("분식")
        case 316...360:
            print("패스트푸드")
        default:
            print("Error")
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
