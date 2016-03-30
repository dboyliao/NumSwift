#!/usr/bin/env xcrun swift
class MyClass<T> {
    typealias Element = T

    let int:Int

    init(num:Int){
        self.int = num
    }

    func say(){
        switch (self.int, Element.self) {
        case (1, is Double.Type):
            print("Double!")
        case (2, is Float.Type):
            print("Float!")
        default:
            print("Something else")
        }
    }
}

let d = MyClass<Double>(num: 1)
let f = MyClass<Float>(num: 2)
let i = MyClass<Int>(num: 2)

d.say()
f.say()
i.say()