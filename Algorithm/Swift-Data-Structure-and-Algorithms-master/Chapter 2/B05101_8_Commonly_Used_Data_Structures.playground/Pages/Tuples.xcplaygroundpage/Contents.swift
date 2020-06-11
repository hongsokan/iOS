//: [Previous](@previous)

import Foundation

//: ## Tuples

//: ### Unamed Tuples
//:
//: You can create tuples with any number and combination of types. Let’s create a tuple that would contain an integer, string, and integer types

let responseCode = (4010, "Invalid file contents", 0x21451fff3b)

//: If you want to control the type used and not rely on the compiler inferring the type from the literal expression you can explicitly declare the value type:

let explicitResponseCode: (Int, String, Double) = (4010, "Invalid file contents", 0x8fffffffffffffff)

// You can verify the tuple types assigned
print(type(of: responseCode))


//: ### Named Tuples
//:
//: Named tuples are just as their name implies; they allow you to name the tuple values. Using named tuples will allow you to write terser code and can be helpful for identifying what an index position is when returning a tuple from a method.

let errorCode = (errorCode:4010, errorMessage:"Invalid file contents", offset:0x7fffffffffffffff)
print(errorCode.errorCode)

//: Tuples are most useful as providing temporary structured values fthat are returned from methods.

func getPartnerList() -> (statusCode:Int, description:String, metaData:(partnerStatusCode:Int, partnerErrorMessage:String, parterTraceId:String)) {
    
    //... some error occurred
    return (503, "Service Unavailable", (32323, "System is down for maintainance until 2015-11-05T03:30:00+00:00", "5A953D9C-7781-427C-BC00-257B2EB98426"))
}

var result = getPartnerList()

result.statusCode

result.description

result.metaData.partnerErrorMessage

result.metaData.partnerStatusCode

result.metaData.parterTraceId


/*:

[Next](@next)

The license for this document is available [here](License).
*/
