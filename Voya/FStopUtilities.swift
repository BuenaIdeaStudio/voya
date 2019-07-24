//
//  FStopUtilities.swift
//  Voya
//
//  Created by yaakov on 4/5/19.
//  Copyright © 2019 yaakov. All rights reserved.
//

import Foundation

struct FStops {
    let high: [Double]
    let low: [Double]
}

struct FStop {
    let value: Double
    let type: FStopType
    let adjusment: Double
}

enum FStopType: String {
    case tree_fourths = "3/4"
    case one_fourth = "1/4"
    case half = "1/2"
}

class FStopCalculator {
    // Variables declared here
    func functionCalculate(baseTime: Double) -> FStops {
        // Option Value
        var intBase: Double = 0
        var intNegative75: Double = 0
        var intNegative50: Double = 0
        var intNegative25: Double = 0
        var intPositive25: Double = 0
        var intPositive50: Double = 0
        var intPositive75: Double = 0
        var intNegative75inc: Double = 0
        var intNegative50inc : Double = 0
        var intNegative25inc: Double = 0
        var intPositive25inc: Double = 0
        var intPositive50inc: Double = 0
        var intPositive75inc: Double = 0

        intBase = baseTime

        if (intBase > 0) {
            let numberOfPlaces = 2.0
            let multiplier = pow(10.0, numberOfPlaces)

            intNegative75 = (intBase * 0.59);
            intNegative75 = round(intNegative75 * multiplier ) / multiplier

            intNegative75inc = (intBase * 0.59) - intBase
            intNegative75inc = round(intNegative75inc * multiplier ) / multiplier

            intNegative50 = (intBase * 0.71)
            intNegative50 = round(intNegative50 * multiplier ) / multiplier

            intNegative50inc = (intBase * 0.71) - intBase
            intNegative50inc = round(intNegative50inc * multiplier ) / multiplier

            intNegative25 = (intBase * 0.84)
            intNegative25 = round(intNegative25 * multiplier ) / multiplier

            intNegative25inc = (intBase * 0.84) - intBase
            intNegative25inc = round(intNegative25inc * multiplier ) / multiplier

            intPositive25 = (intBase * 1.19)
            intPositive25 = round(intPositive25 * multiplier ) / multiplier

            intPositive25inc = (intBase * 1.19) - intBase
            intPositive25inc = round(intPositive25inc * multiplier ) / multiplier

            intPositive50 = (intBase * 1.41)
            intPositive50 = round(intPositive50 * multiplier ) / multiplier

            intPositive50inc = (intBase * 1.41) - intBase
            intPositive50inc = round(intPositive50inc * multiplier ) / multiplier

            intPositive75 = (intBase * 1.68)
            intPositive75 = round(intPositive75 * multiplier ) / multiplier

            intPositive75inc = (intBase * 1.68) - intBase
            intPositive75inc = round(intPositive75inc * multiplier ) / multiplier

            let higher_ev_time = [
                intPositive25,
                intPositive50,
                intPositive75
            ]

            let lower_ev_time = [
                intNegative25,
                intNegative50,
                intNegative75
            ]

            print("============")

            _ = higher_ev_time.map {print("\($0)")}

            print("============")

            _ = lower_ev_time.map {print("\($0)")}

            let stops = FStops.init(high: higher_ev_time, low: lower_ev_time)

            return stops
        } else {
            return FStops.init(high: [], low: [])
        }
    }

    // Variables declared here
    func calculateFStops(baseTime: Double) -> [FStop] {
        // Option Value
        var intBase: Double = 0
        var intNegative75: Double = 0
        var intNegative50: Double = 0
        var intNegative25: Double = 0
        var intPositive25: Double = 0
        var intPositive50: Double = 0
        var intPositive75: Double = 0
        var intNegative75inc: Double = 0
        var intNegative50inc : Double = 0
        var intNegative25inc: Double = 0
        var intPositive25inc: Double = 0
        var intPositive50inc: Double = 0
        var intPositive75inc: Double = 0

        intBase = baseTime

        if (intBase > 0) {
            let numberOfPlaces = 2.0
            let multiplier = pow(10.0, numberOfPlaces)

            intNegative75 = (intBase * 0.59);
            intNegative75 = round(intNegative75 * multiplier ) / multiplier

            intNegative75inc = (intBase * 0.59) - intBase
            intNegative75inc = round(intNegative75inc * multiplier ) / multiplier

            let ng75 = FStop.init(
                value:intNegative75,
                type: .tree_fourths,
                adjusment: intNegative75inc
            )

            intNegative50 = (intBase * 0.71)
            intNegative50 = round(intNegative50 * multiplier ) / multiplier

            intNegative50inc = (intBase * 0.71) - intBase
            intNegative50inc = round(intNegative50inc * multiplier ) / multiplier

            let ng50 = FStop.init(
                value:intNegative50,
                type: .one_fourth,
                adjusment: intNegative50inc
            )

            intNegative25 = (intBase * 0.84)
            intNegative25 = round(intNegative25 * multiplier ) / multiplier

            intNegative25inc = (intBase * 0.84) - intBase
            intNegative25inc = round(intNegative25inc * multiplier ) / multiplier

            let ng25 = FStop.init(
                value:intNegative25,
                type: .half,
                adjusment: intNegative25inc
            )

            intPositive25 = (intBase * 1.19)
            intPositive25 = round(intPositive25 * multiplier ) / multiplier

            intPositive25inc = (intBase * 1.19) - intBase
            intPositive25inc = round(intPositive25inc * multiplier ) / multiplier

            let ps25 = FStop.init(
                value: intPositive25,
                type: .one_fourth,
                adjusment: intPositive25inc
            )

            intPositive50 = (intBase * 1.41)
            intPositive50 = round(intPositive50 * multiplier ) / multiplier

            intPositive50inc = (intBase * 1.41) - intBase
            intPositive50inc = round(intPositive50inc * multiplier ) / multiplier

            let ps50 = FStop.init(
                value: intPositive50,
                type: .half,
                adjusment: intPositive50inc
            )

            intPositive75 = (intBase * 1.68)
            intPositive75 = round(intPositive75 * multiplier ) / multiplier

            intPositive75inc = (intBase * 1.68) - intBase
            intPositive75inc = round(intPositive75inc * multiplier ) / multiplier

            let ps75 = FStop.init(
                value: intPositive75,
                type: .tree_fourths,
                adjusment: intPositive75inc
            )

            return [ng75, ng50, ng25, ps25, ps50, ps75]
        } else {
            return []
        }
    }
}

