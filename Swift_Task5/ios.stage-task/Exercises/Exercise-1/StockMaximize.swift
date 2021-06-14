import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var restPrices = prices
        var buyPrices = [Int]()
        let maxValue = prices.max()
        var sum = 0
        for price in prices {
            restPrices.removeFirst()
            if price == maxValue! {
                for buyPrice in buyPrices {
                    sum += price - buyPrice
                }
                sum += countProfit(prices: restPrices)
                break
            }
            buyPrices.append(price)
        }
        return sum
    }
}
