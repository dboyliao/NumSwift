import Foundation

func read_csvD(path: String) -> [Double] {

    var data = [Double]()

    do {

        let content = try NSString(contentsOfFile:path, encoding: NSUTF8StringEncoding)

        let tempData = content.componentsSeparatedByString(",")

        data = [Double](count:tempData.count, repeatedValue:0.0)
        var t:String

        for i in 0..<data.count {
            t = tempData[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            data[i] = Double(t)!

        }
    } catch {

    } 

    return data
}

func read_csv(path: String) -> [Float] {

    var data = [Float]()

    do {

        let content = try NSString(contentsOfFile:path, encoding: NSUTF8StringEncoding)

        let tempData = content.componentsSeparatedByString(",")

        data = [Float](count:tempData.count, repeatedValue:0.0)
        var t:String

        for i in 0..<data.count {
            t = tempData[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

            data[i] = Float(t)!

        }
    } catch {

    } 

    return data
}