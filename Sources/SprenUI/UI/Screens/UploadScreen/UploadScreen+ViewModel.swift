//
//  UploadScreen+ViewModel.swift
//  SprenInternal
//
//  Created by Keith Carolus on 2/3/22.
//

import SwiftUI
import SprenCore

extension UploadScreen {
    
    class ViewModel: ObservableObject {
        
        var readingData: String? = nil
        var guid: String? = nil
        
        let onCancel: () -> Void
        var onError:  () -> Void
        var onFinish: (_ guid: String, _ hr: Double, _ hrvScore: Double) -> Void
        
        // UI
        @Published var circleRotation: Double = 0
        @Published var circleArc: Double = 0.2
        @Published var messageText = "Syncing data..."
        @Published var finished = false
        @Published var showAlert = false
        
        /// spinner
        var circleRotationTimer: Timer? = nil
        var time: Double = 0
        
        /// rotating messages
        var textUpdateTimer: Timer? = nil
        var currentMessageIndex = 0 {
            didSet {
                withAnimation {
                    messageText = rotatedMessages[currentMessageIndex]
                }
            }
        }
        let rotatedMessages = [
            "Syncing data...",
            "Analyzing heart rate...",
            "Performing complex calculations...",
            "Generating results...",
        ]
        
        // networking
        let apiClient = APIClient()
        var postTask: URLSessionTask? = nil
        var getTask: URLSessionTask? = nil
        var cancelled = false
        
        let retryAfterPostDelay: Double = 4
        let retryGetTimeout: Double = 30
        let retryGetDelay: Double = 2
        
        init(onCancel: @escaping () -> Void,
             onError: @escaping () -> Void,
             onFinish: @escaping (_ guid: String, _ hr: Double, _ hrvScore: Double) -> Void,
             readingData: String? = Spren.getReadingData()
        ) {

            self.onCancel = onCancel
            self.onError = onError
            self.onFinish = onFinish
            self.readingData = readingData
                        
            startUITimers()
            post()
        }
        
        // MARK: - Timers
        
        func startUITimers() {
            self.circleRotationTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                
                self.time += 0.01
                self.circleRotation = 360 * self.time.truncatingRemainder(dividingBy: 1)
            }
            self.textUpdateTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                
                self.currentMessageIndex = (self.currentMessageIndex + 1) % self.rotatedMessages.count
            }
        }
        
        func cleanupUITimers() {
            circleRotationTimer?.invalidate()
            textUpdateTimer?.invalidate()
        }
        
        // MARK: - UI
        
        func handleCancel() {
            cancelled = true
            cleanupUITimers()
            postTask?.cancel()
            getTask?.cancel()
            onError = {}
            onFinish = { _, _, _ in}
            onCancel()
        }
        
        func handleShowAlert() {
            SprenUI.config.logger?.info("network connectivity alert")
            cleanupUITimers()
            showAlert = true
        }
        
        func handleTapTryAgain() {
            startUITimers()
            if let guid = self.guid {
                SprenUI.config.logger?.info("try again with guid (GET failed)")
                startGet(guid: guid)
            } else {
                SprenUI.config.logger?.info("try again (POST failed)")
                post()
            }
        }
        
        func handleError() {
            SprenUI.config.logger?.info("handle error")
            cleanupUITimers()
            onError()
        }
        
        func handleFinish(guid: String, hr: Double, hrvScore: Double) {
            DispatchQueue.main.async {
                withAnimation {
                    self.finished = true
                    self.circleArc = 1
                }
            }
                
            self.guid = nil
            cleanupUITimers()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if !self.cancelled {
                    self.onFinish(guid, hr, hrvScore)
                }
            }
        }
        
        // MARK: - POST
        
        public func post() {
            guard let readingData = self.readingData else {
                SprenUI.config.logger?.error("readingData nil for POST")
                handleError()
                return
            }
                        
            let body = [
                "user": SprenUI.config.userID,
                "readingData": readingData,
            ]
            
            (_, postTask) = apiClient.post(path: "/submit/sdkData", body: body, completionHandler: { response in
                switch response {
                case .success(let data):
                    print("POST success!")
                    self.handlePostSuccess(data: data)
                case .error(let error, let response, _):
                    SprenUI.config.logger?.error("POST errored, status code: \(response?.statusCode ?? -1)")
                    self.handleResponseError(error)
                }
            })
            
        }
        
        func handlePostSuccess(data: Data) {
            do {
                let apiResponse = try JSONDecoder().decode(PostSDKDataResponse.self, from: data)
                self.guid = apiResponse.guid
                startGet(guid: apiResponse.guid, delaySeconds: retryAfterPostDelay)
            } catch {
                SprenUI.config.logger?.error("could not decode POST response: \(String(data: data, encoding: .utf8) ?? "")")
                handleError()
            }
        }
        
        // MARK: - GET
        
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
                SprenUI.config.logger?.info("GET timeout")
                handleShowAlert()
                return
            }
            
            let getTimeout = retryGetTimeout - timeElapsed
            
            (_, getTask) = apiClient.get(path: "/results/\(guid)", timeout: getTimeout) { response in
                switch response {
                case .success(let data):
                    print("GET success!")
                    
                    guard let getResultsResponse = try? JSONDecoder().decode(GetResultsResponse.self, from: data) else {
                        SprenUI.config.logger?.error("could not decode GET response: \(String(data: data, encoding: .utf8) ?? "")")
                        self.handleError()
                        return
                    }
                    
                    if getResultsResponse.isComplete() {
                        print("results complete!")
                        guard let hr = getResultsResponse.biomarkers.hr.value,
                                let hrvScore = getResultsResponse.biomarkers.hrvScore.value else {
                            SprenUI.config.logger?.error("hr or hrvScore nil")
                            self.handleError()
                            return
                        }
                        
                        print("hr \(hr)")
                        print("hrvScore \(hrvScore)")
                        
                        self.handleFinish(guid: guid, hr: hr, hrvScore: hrvScore)
                        
                    } else if getResultsResponse.hasError() {
                        SprenUI.config.logger?.info("response has errored biomarker")
                        self.handleError()
                        
                    } else {
                        print("scheduling get retry")
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.retryGetDelay) {
                            if !self.cancelled {
                                self.retryGet(getStartTime: getStartTime, guid: guid)
                            }
                        }
                    }
                    
                case .error(let error, let response, _):
                    SprenUI.config.logger?.info("GET errored, status code: \(response?.statusCode ?? -1)")
                    self.handleResponseError(error)
                }
            }
        }
        
        // MARK: - ERROR
        
        func handleResponseError(_ error: Error) {
            if error is RequestError { // data nil, url nil, HTTP error, non HTTP response
                SprenUI.config.logger?.info("request type error")
                handleError()
            } else {
                SprenUI.config.logger?.info("non request type error")
                handleShowAlert() // I think it's a connectivity error
            }
        }
        
    }
    
}
