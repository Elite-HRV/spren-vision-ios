//
//  AsyncAPIService.swift
//  SprenInternal
//
//  Created by Keith Carolus on 7/14/22.
//

import Foundation
//import Sentry

class AsyncAPIService<E: Encodable, D: Decodable & CompletableErrorable> {
    private let postEndpoint: String
    private let getEndpoint: String
    private let decodable: D.Type

    private let apiClient = APIClient()
    private var postTask: URLSessionTask? = nil
    private var getTask: URLSessionTask? = nil
    private var cancelled = false

    private let retryAfterPostDelay: Double = 4
    private let retryGetTimeout: Double = 30
    private let retryGetDelay: Double = 2

    private var guid: String? = nil
    
    init(postEndpoint: String, getEndpoint: String, decodable: D.Type) {
        self.postEndpoint = postEndpoint
        self.getEndpoint = getEndpoint
        self.decodable = decodable
    }

    // MARK: public config and API
    
    public var onCancel: () -> Void = {}
    public var onNetworkConnectivityAlert: () -> Void = {}
    public var onError: (String, Bool) -> Void = { _,_  in }
    public var onFinish: (D) -> Void = { _ in }

    public func cancel() {
        cancelled = true
        postTask?.cancel()
        getTask?.cancel()
        onCancel()
    }

    public func post(body: E) {
        (_, postTask) = apiClient.post(path: postEndpoint, body: body, completionHandler: { response in
            switch response {
            case .success(let data):
                print("POST success!")
                self.handlePostSuccess(data: data)
            case .error(let error, let response, _):
                self.handleResponseError(httpMethod: "POST", response: response, error: error)
            }
        })
    }

    public func tryAgain(body: E) {
        if let guid = self.guid {
//            SentrySDK.capture(message: "try again with guid (GET failed)")
            startGet(guid: guid)
        } else {
//            SentrySDK.capture(message: "try again (POST failed)")
            post(body: body)
        }
    }

    // MARK: - private

    func handlePostSuccess(data: Data) {
        guard let apiResponse = parseJSON(data: data, type: PostSDKDataResponse.self) else {
//            SentrySDK.capture(message: String(data: data, encoding: .utf8) ?? "")
            handleError(ServerError("could not decode POST response"))
            return
        }

        self.guid = apiResponse.guid
        startGet(guid: apiResponse.guid, delaySeconds: retryAfterPostDelay)
    }

    func startGet(guid: String, delaySeconds: Double = 0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds) {
            if !self.cancelled {
                self.retryGet(getStartTime: NSDate().timeIntervalSince1970, guid: guid)
            }
        }
    }

    func retryGet(getStartTime: TimeInterval, guid: String) {
        let timeElapsed = NSDate().timeIntervalSince1970 - getStartTime

        if timeElapsed >= self.retryGetTimeout {
//            SentrySDK.capture(message: "GET timeout")
            networkConnectivityAlert()
            return
        }

        let getTimeout = retryGetTimeout - timeElapsed

        (_, getTask) = apiClient.get(path: "\(getEndpoint)/\(guid)", timeout: getTimeout) { response in
            print("response Get", response)
            switch response {
            case .success(let data):
                print("GET success!")

                guard let getResultsResponse = self.parseJSON(data: data, type: self.decodable) else {
//                    SentrySDK.capture(message: String(data: data, encoding: .utf8) ?? "")
                    self.handleError(ServerError("could not decode GET response"))
                    return
                }

                if getResultsResponse.isComplete() {
                    print("results complete!")
                    self.handleFinish(getResultsResponse)
                } else if getResultsResponse.hasError() {
                    let isHumanNotDetectedError = getResultsResponse.isHumanNotDetectedError()
                    self.handleError(ServerError("response has errored biomarker", isHumanNotDetectedError))
                } else {
                    print("scheduling get retry")
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.retryGetDelay) {
                        if !self.cancelled {
                            self.retryGet(getStartTime: getStartTime, guid: guid)
                        }
                    }
                }

            case .error(let error, let response, _):
                self.handleResponseError(httpMethod: "GET", response: response, error: error)
            }
        }
    }

    func handleResponseError(httpMethod: String, response: HTTPURLResponse?, error: Error) {
//        SentrySDK.capture(error: error)
        print("handling response error...")
        if error is RequestError { // data nil, url nil, HTTP error, non HTTP response
            handleError(ServerError("\(httpMethod) errored, status code: \(response?.statusCode ?? -1)"))
        } else {
//            SentrySDK.capture(message: "non request type error")
            networkConnectivityAlert() // I think it's a connectivity error
        }
    }

    private func networkConnectivityAlert() {
//        SentrySDK.capture(message: "network connectivity alert")
        onNetworkConnectivityAlert()
    }

    private func handleError(_ serverError: ServerError) {
        print(serverError.errorDescription)
//        SentrySDK.capture(message: serverError.errorDescription)
        onError(serverError.errorDescription, serverError.isHumanNotDetectedError)
    }

    private func handleFinish(_ response: D) {
        onFinish(response)
    }

    // MARK: - helpers

    private func parseJSON<T: Decodable>(data: Data, type: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            return nil
        }
    }

    private struct ServerError {
        let errorDescription: String
        let isHumanNotDetectedError: Bool

        init(_ errorDescription: String, _ isHumanNotDetectedError: Bool = false) {
            self.errorDescription = errorDescription
            self.isHumanNotDetectedError = isHumanNotDetectedError
        }
    }
}
