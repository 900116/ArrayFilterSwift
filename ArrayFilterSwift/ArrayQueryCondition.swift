//
//  ArrayQueryCondition.swift
//  TestArrayFilter2
//
//  Created by 51Talk_zhaoguanghui on 2018/2/11.
//  Copyright © 2018年 ApesStudio. All rights reserved.
//

import UIKit

class ArrayQueryCondition: NSObject {
    
    fileprivate var conditionStr = ""
    
    private func filter_opt(_ opt: String, _ value: CVarArg? = nil) {
        if let value = value as? String {
            conditionStr.append(opt)
            conditionStr.append(" '\(value)' ")
        } else if let value = value{
            conditionStr.append(opt)
            conditionStr.append(" \(value) ")
        } else {
            conditionStr.append(opt)
            conditionStr.append(" ")
        }
    }
    
    func equal(_ value: CVarArg) -> ArrayQueryCondition{
        filter_opt("=", value)
        return self
    }
    
    func no_equal(_ value: CVarArg) -> ArrayQueryCondition {
        filter_opt("!=", value)
        return self
    }
    
    func less(_ value: CVarArg) -> ArrayQueryCondition {
        filter_opt("<", value)
        return self
    }
    
    func more(_ value: CVarArg) -> ArrayQueryCondition {
        filter_opt(">", value)
        return self
    }
    
    func less_equal(_ value: CVarArg) -> ArrayQueryCondition {
        filter_opt("<=", value)
        return self
    }
    
    func more_equal(_ value: CVarArg) -> ArrayQueryCondition {
        filter_opt(">=", value)
        return self
    }
    
    func beginswith(_ value: CVarArg) -> ArrayQueryCondition {
        filter_opt("BEGINSWITH", value)
        return self
    }
    
    func endswith(_ value: CVarArg) -> ArrayQueryCondition {
        filter_opt("ENDSWITH", value)
        return self
    }
    
    func like(_ wild: CVarArg) -> ArrayQueryCondition {
        filter_opt("LIKE", wild)
        return self
    }
    
    func matches(_ regex: CVarArg) -> ArrayQueryCondition {
        filter_opt("MATCHES", regex)
        return self
    }
    
    func In(_ arr: [Any]) -> ArrayQueryCondition {
        var values = "{"
        let length = arr.count
        for i in 0..<length {
            if arr[i] is String {
                values.append("'\(arr[i])'")
            }else {
                values.append("\(arr[i])")
            }
            if i != arr.count - 1 {
                values.append(",")
            }
        }
        values.append("}")
        conditionStr.append("IN")
        conditionStr.append(" \(values) ")
        return self
    }
}

func Where(_ keyPath: String? = nil) -> ArrayQueryCondition{
    let condition = ArrayQueryCondition()
    if let keyPath = keyPath{
        condition.conditionStr.append("SELF." + keyPath)
    } else {
        condition.conditionStr.append("SELF")
    }
    condition.conditionStr.append(" ")
    return condition
}

func > (left: ArrayQueryCondition, right: CVarArg) -> ArrayQueryCondition {
    return left.more(right)
}

func >= (left: ArrayQueryCondition, right: CVarArg) -> ArrayQueryCondition {
    return left.more_equal(right)
}

func < (left: ArrayQueryCondition, right: CVarArg) -> ArrayQueryCondition {
    return left.less(right)
}

func <= (left: ArrayQueryCondition, right: CVarArg) -> ArrayQueryCondition {
    return left.less_equal(right)
}

func && (left: ArrayQueryCondition, right: ArrayQueryCondition) -> ArrayQueryCondition {
    left.conditionStr = left.conditionStr + " && " + right.conditionStr
    return left;
}

func || (left: ArrayQueryCondition, right: ArrayQueryCondition) -> ArrayQueryCondition {
    left.conditionStr = left.conditionStr + " || " + right.conditionStr
    return left;
}

func % (left: ArrayQueryCondition, right: CVarArg) -> ArrayQueryCondition {
    return left.like(right)
}

func == (left: ArrayQueryCondition, right: CVarArg) -> ArrayQueryCondition {
    return left.equal(right)
}

func != (left: ArrayQueryCondition, right: CVarArg) -> ArrayQueryCondition {
    return left.no_equal(right)
}

func SOME (_ value: ArrayQueryCondition) -> ArrayQueryCondition {
    value.conditionStr = "SOME " + value.conditionStr
    return value
}

func ANY (_ value: ArrayQueryCondition) -> ArrayQueryCondition {
    value.conditionStr = "ANY " + value.conditionStr
    return value
}

func ALL (_ value: ArrayQueryCondition) -> ArrayQueryCondition {
    value.conditionStr = "ALL " + value.conditionStr
    return value
}

func NONE (_ value: ArrayQueryCondition) -> ArrayQueryCondition {
    value.conditionStr = "NONE " + value.conditionStr
    return value
}

extension Array {
    func query(_ condi: ArrayQueryCondition) -> [Element]{
        let t_conditionStr = condi.conditionStr
        if t_conditionStr.lengthOfBytes(using: .utf8) == 0 {
            return self
        } else {
            if let array = (self as NSArray).filtered(using: NSPredicate(format: t_conditionStr)) as? [Element] {
                return array
            }
            return [Element]()
        }
    }
}
