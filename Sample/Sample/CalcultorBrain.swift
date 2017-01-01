//
//  CalcultorBrain.swift
//  Sample
//
//  Created by Ajit Kumar Baral on 12/24/16.
//  Copyright © 2016 Ajit Kumar Baral. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "x" : Operation.BinaryOpeation({$0 * $1}),
        "/" : Operation.BinaryOpeation({$0 / $1}),
        "+" : Operation.BinaryOpeation({$0 + $1}),
        "-" : Operation.BinaryOpeation({$0 - $1}),
        "=" : Operation.Equals
    ]
    
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOpeation((Double, Double)->Double)
        case Equals
    }
    
    func performOperation(symbol: String){
        
        if let operation = operations[symbol]{
        switch operation {
        case .Constant(let value): accumulator = value
            break
        case .UnaryOperation(let function): accumulator = function(accumulator)
            break
        case .BinaryOpeation(let function):
            executePendingBinaryOperation()
            pending = PendingBinaryOperationInfo(binaryFunction: function, firstOprand: accumulator)
            break
        case .Equals:
            executePendingBinaryOperation()
            
            break
        }
    }
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOprand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) ->Double
        var firstOprand: Double
        //var secondOprand: Double
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
    
}
