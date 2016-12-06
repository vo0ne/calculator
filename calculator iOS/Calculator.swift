//
//  Calculator.swift
//  calculator iOS
//
//  Created by Volodymyr Lavryk on 06.12.16.
//  Copyright © 2016 Volodymyr Lavryk. All rights reserved.
//

import Foundation

class Calculator {
    
    var accumulator = 0.0
    
    enum Operation {
        case constant(Double)
        case unaryOperation((Double)-> Double)
        case binaryOperation((Double, Double)-> Double)
        case equals
    }
    
    
    var operations: [String: Operation] = [
        "AC": Operation.constant(0.0),
        "±": Operation.unaryOperation({ -$0 }),
        "%": Operation.unaryOperation({$0 / 10}),
        "×": Operation.binaryOperation({$0 * $1}),
        "÷": Operation.binaryOperation({$0 / $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "−": Operation.binaryOperation({$0 - $1}),
        "=": Operation.equals

    ]
    
    func setOperand(operand: Double) { // set operand to calculate
        accumulator = operand
    }
    
    func performOperationWith (symbol: String) { // operations
        if let operition = operations[symbol] {
            switch operition {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                accumulator = function(accumulator)
            case .binaryOperation(let function):
                executeBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryOperation: function, firstOperand: accumulator)
            case .equals:
                executeBinaryOperation()
            }
        }
        
    }
    
    func executeBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryOperation(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    var pending: PendingBinaryOperationInfo?

    struct PendingBinaryOperationInfo {
        var binaryOperation: (Double, Double) ->Double
        var firstOperand: Double
    }
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
