import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func getKnapsack(for array: [Supply]) -> [[Int]] {
        var table: [[Int]] = Array(repeating: Array(repeating: 0, count: maxWeight+1), count: array.count+1)
        for i in 0 ... array.count {
            for j in 0 ... maxWeight {
                if i != 0 && j != 0 {
                    if (array[i - 1].weight > j){
                        table[i][j] = table[i - 1][j]
                    } else {
                        table[i][j] = max(table[i - 1][j], (array[i - 1].value + table[i - 1][j - array[i - 1].weight]))
                    }
                }
            }
        }
        return table
    }
    
    func findMaxKilometres() -> Int {
        guard maxWeight <= 2500 && maxWeight > 0 else {
            return 0
        }
        
        let foodsKnapsack = getKnapsack(for: foods)
        let drinksKnapsack = getKnapsack(for: drinks)
        var maxDistance = 0
        for i in 0...maxWeight {
            maxDistance = max(maxDistance, min(foodsKnapsack[foods.count][i], drinksKnapsack[drinks.count][maxWeight-i]))
        }
        return maxDistance
    }
}
