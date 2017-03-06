//
//  API_WRAPPER.swift
//  Flickr_Client
//
//  Created by Gregory House on 24.09.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class API_WRAPPER
{
    class func composeGenericHTTPGetRequest (forBaseURL baseURL: String, andParameters parameters: NSDictionary) -> NSURLRequest
    {
        var requestString = baseURL + "?"
        
        let keysArray = parameters.allKeys as! [String]
        
        for i in 0..<keysArray.count
        {
            let key = keysArray[i]
            let value = parameters[key] as! String
            
            if ( i < keysArray.count - 1)
            {
                requestString += "\(key)=\(value)&"
            }
            else
            {
                requestString += "\(key)=\(value)"
            }
        }
        
        print("запрос - \(requestString)")
        
        let request = NSMutableURLRequest ()
        
        request.httpMethod = "GET"
        request.url = URL(string: requestString)
        
        return request
    }
}

//MARK получение списков постов

extension API_WRAPPER
{
    class func getPost (withPageNumber pageNumber : Int, pageSize: Int, successBlock: @escaping ( _ jsonResponse : NSDictionary) -> Void, failureBlock: @escaping ( _ errorCode: Int) -> Void)
    {
        let argsDictionary = NSMutableDictionary ()
        
        argsDictionary.setObject("\(pageNumber)", forKey: Const.URLConst.Arguments.kPageNumber)
        argsDictionary.setObject("\(pageSize)", forKey: Const.URLConst.Arguments.kPageSize)
        argsDictionary.setObject("6df64f7cdbac6add7e745a97942ee4df", forKey: Const.URLConst.Arguments.kAPIKey)
        argsDictionary.setObject("json", forKey: Const.URLConst.Arguments.kFormat)
        argsDictionary.setObject("1", forKey: Const.URLConst.Arguments.kNoJSONCallback)
        argsDictionary.setObject("flickr.interestingness.getList", forKey: Const.URLConst.Arguments.kMethod)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: Const.URLConst.kBaseURL, andParameters: argsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            genericCompletetionCallback(withResponseData: data, response: response, error: error , successBlock: successBlock, failureBlock: failureBlock)
        }
            task.resume()
    }
}



//MARK: общий обработчик ответов
extension API_WRAPPER
{
    class func genericCompletetionCallback ( withResponseData data: Data?, response: URLResponse?, error: Error?, successBlock: ( _ jsonResponse : NSDictionary) -> Void, failureBlock: ( _ errorCode: Int) -> Void)
    {
        if ( error != nil)
        {
            failureBlock(( error as! NSError).code)
        }
        
        if (data != nil )
        {
           
            do
            {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                {
                    print("ответ : \(json)")
                    successBlock(json)
                }
                else
                {
                    failureBlock(-80)
                }
            }
            catch
            {
                failureBlock(-80)
            }
        }
        else
        {
            failureBlock(-90)
        }
        
    }
}



