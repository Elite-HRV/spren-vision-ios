//
//  HTTPClient.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 06/01/22.
//

import Foundation

/// HTTP methods we use
enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

/// HTTP headers we use
enum HTTPHeader: String {
    case apiKey          = "X-API-KEY"
    case contentType     = "content-type"
    case contentEncoding = "content-encoding"
    case contentLength   = "content-length"
}

/// Type to represent request headers
typealias RequestHeaders = [HTTPHeader: String]

/// Type to represent request body/url options
typealias Params = [String: Any]

/// Type to handle network request completion
typealias RequestCompletionHandler = (Response) -> Void

typealias RequestProgressUpdate = (Double) -> Void

/// Represents an internal HTTP client error
enum RequestError: Error {
    case invalidData
    case invalidResponse
    case invalidURL
    case statusCode
}

/// Represents an HTTP response
enum Response {
    case success(data: Data)
    case error(error: Error, response: HTTPURLResponse?, data: Data?)
}

class APIClient: NSObject {
    let logger = Logger(label: "HTTPClient")
    let session = URLSession.shared
}

extension APIClient {
    /// Default request headers sent on all requests
    var defaultRequestHeaders: RequestHeaders {
        return [
            .apiKey: SprenUI.config.apiKey,
            .contentType: "application/json"
        ]
    }
}

extension APIClient {
    
    @discardableResult
    public func dataTask(_ request: URLRequest,
                         completionHandler: RequestCompletionHandler? = nil)
    -> URLSessionDataTask {
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let completionHandler = completionHandler else { return }
            let response = self.processRequestCompletion(data, response: response, error: error)
            completionHandler(response)
        }
        task.resume()
        return task
    }
    
    @discardableResult
    public func post<Body: Encodable>(
        path: String,
        headers: RequestHeaders? = nil,
        body: Body,
        completionHandler: RequestCompletionHandler? = nil
    ) -> (URLRequest, URLSessionDataTask) {
        logger.debug("\(HTTPMethod.post.rawValue), \(path), \(body)")
        
        var request = baseURLRequest(.post, path: path, headers: headers)
        if let bodyData = try? JSONEncoder().encode(body) {
            request.httpBody = bodyData
        }
        
        return (request, dataTask(request, completionHandler: completionHandler))
    }
    
    @discardableResult
    public func get(
        path: String,
        headers: RequestHeaders? = nil,
        params: Params? = nil,
        timeout: Double = 30,
        completionHandler: RequestCompletionHandler? = nil
    ) -> (URLRequest, URLSessionDataTask) {
        logger.debug("\(HTTPMethod.get.rawValue), \(path), \(params ?? [:])")
        
        var request = baseURLRequest(.get, path: path, headers: headers)
        request.timeoutInterval = timeout
        
        if let params = params, let url = request.url {
            request.url = URL(string: url.absoluteString + "?" + urlEncodedQueryString(params))
        }
        
        return (request, dataTask(request, completionHandler: completionHandler))
    }
    
    /// Builds a URL request based on a given HTTP method and options
    private func baseURLRequest(
        _ httpMethod: HTTPMethod,
        path: String,
        headers: RequestHeaders? = nil
    ) -> URLRequest {
        // Build Spren api url
        let url = URL(string: SprenUI.config.baseURL.appending(path))!

        // Build request object
        var request = URLRequest(url: url)

        // Merge additional headers, overriding default
        let headers = defaultRequestHeaders.merging(headers ?? [:]) { $1 }

        // Apply request headers
        for (header, value) in headers {
            request.addValue(value, forHTTPHeaderField: header.rawValue)
        }

        // Method
        request.httpMethod = httpMethod.rawValue
        
        // Timeout
        request.timeoutInterval = 30

        return request
    }

    /// Converts a dict to url encoded query string
    private func urlEncodedQueryString(_ params: Params) -> String {
        let queryParts: [String] = params.compactMap { param in
            guard
                let safeKey = param.key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                let safeValue = "\(param.value)".addingPercentEncoding(
                    withAllowedCharacters: .urlHostAllowed
                )
            else { return nil }
            return "\(safeKey)=\(safeValue)"
        }

        return queryParts.joined(separator: "&")
    }
    
    /// Process a response
    fileprivate func processRequestCompletion(_ data: Data?, response: URLResponse?, error: Swift.Error?) -> Response {
        if let error = error {
            logger.warning("Request Error: \(error)")
            return .error(error: error, response: response as? HTTPURLResponse, data: nil)
        }

        guard let data = data else {
            logger.warning("Request Data Error: data is nil")
                return .error(
                error: RequestError.invalidData,
                response: response as? HTTPURLResponse,
                data: nil
            )
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            logger.warning("Request Response Error: response is not an http response")
            return .error(
                error: RequestError.invalidResponse,
                response: response as? HTTPURLResponse,
                data: data
            )
        }

        guard let url = httpResponse.url else {
            logger.warning("Request URL Error: url is nil")
            return .error(error: RequestError.invalidURL, response: httpResponse, data: data)
        }

        switch httpResponse.statusCode {
        case 200..<400:
            return .success(data: data)
        default:
            logger.error("Request Failed: \(httpResponse.statusCode), \(url)")
            return .error(error: RequestError.statusCode, response: httpResponse, data: data)
        }
    }
    
}
