import Foundation

let ColorCodes = [
    "red": 31,
    "green": 32,
    "yellow": 33,
    "blue": 34,
    "magenta": 35,
    "cyan": 36,
    "white": 37 
]

func colorPrint(args:AnyObject..., color:String) {

    let colorCode = ColorCodes[color]

    if let colorCode = colorCode {

        for arg in args {
            print("\u{001B}[1;\(colorCode)m\(arg)\u{001B}[0m")
        }

    } else {
        colorPrint("==== [\(color)] not supported ===", color:"red")
        for arg in args {
            print(arg)
        }
    }

}
