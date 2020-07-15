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
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var spinButton: UIButton!
    
    
    let food = ["한식", "양식", "중식", "일식", "분식", "패스트푸드", "야식", "기타"]
    let angle = [45, 45, 45, 45, 45, 45, 45, 45]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonInit()

        customizeChart(dataPoints: food, values: angle.map { Double($0) })
        
    }
    
    func buttonInit() {
        spinButton.layer.borderWidth = 1
        spinButton.layer.borderColor = UIColor.white.cgColor
        spinButton.layer.cornerRadius = 10
    }

    func customizeChart(dataPoints: [String], values: [Double]) {
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
          dataEntries.append(dataEntry)
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        pieChartDataSet.drawValuesEnabled = false
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        
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
        print("random: \(random)")
        pieChartView.spin(duration: 1000, fromAngle: 0, toAngle: CGFloat(random), easingOption: ChartEasingOption.easeInOutQuad)
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
