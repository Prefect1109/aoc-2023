import Foundation

let input = """
eightfivesssxxmgthreethreeone1sevenhnz
hzdlftdtfqfdbxgsix9onetwo13
29threelgxljfhrjr
"""

print(input)
let modifiedInput = input.components(separatedBy: "\n")


let numbers: [String: Int] = ["one" : 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9]
var reversedNumbers: [String: Int] = [:]
numbers.forEach { element in
  let newKey = String(element.key.reversed())
  reversedNumbers[newKey] = element.value
}
let minBuffer = 3
let maxBuffer = 5

var totalSum = 0

for i in modifiedInput {
  
  var firstElement = calculate(inputArray: i)
  var secondElement = calculate(inputArray: i, isReversed: true)
  
  var number = Int(String(firstElement) + String(secondElement)) ?? 0
  totalSum += number
}

print(totalSum)

func calculate(inputArray: String, isReversed: Bool = false) -> Int {
  func getValue(with index: Int, for array: [String]) -> String? {
    if array.count > index {
      return array[index]
    } else {
      return nil
    }
  }
  
  var modifiedInput = isReversed ? String(inputArray.reversed()) : inputArray
  var modifiedInputArray = modifiedInput.map { String($0) }
  
  for (index, letter) in modifiedInputArray.enumerated() {
    if let number = Int(String(letter)) {
      return number
    } else {
      for count in minBuffer...maxBuffer {
        var indexCount = count - 1
        var letterBuffer = ""
        for bufferIndex in 0...indexCount {
          if let value = getValue(with: bufferIndex + index, for: modifiedInputArray) {
            letterBuffer += value
          } else {
            break
          }
        }
        var numbers = isReversed ? reversedNumbers : numbers
        for number in numbers {
          if letterBuffer == number.key {
            return number.value
          }
        }
      }
    }
  }
  return 0
}
