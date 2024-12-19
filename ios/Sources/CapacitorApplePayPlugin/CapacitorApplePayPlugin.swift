import Foundation
import Capacitor
import PassKit

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorApplePayPlugin)
public class CapacitorApplePayPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "CapacitorApplePayPlugin"
    public let jsName = "CapacitorApplePay"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "canMakePayments", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "startPayment", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "paymentAuthorizationSuccess", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "paymentAuthorizationFail", returnType: CAPPluginReturnPromise)
        
    ]
    
    private var currentCompletionHandler: ((PKPaymentAuthorizationResult) -> Void)?

    
    
    @objc func canMakePayments(_ call: CAPPluginCall) {
        if #available(iOS 10.0, *) {
            let canMakePayments = PKPaymentAuthorizationViewController.canMakePayments()
            call.resolve([ "canMakePayments": canMakePayments ])
        } else {
            call.resolve([ "canMakePayments": false ])
        }
    }
    
    @objc func startPayment(_ call: CAPPluginCall) {
        guard let merchantIdentifier = call.getString("merchantId"),
              let countryCode = call.getString("countryCode"),
              let currencyCode = call.getString("currencyCode"),
              let supportedNetworks = call.getArray("supportedNetworks") as? [String],
              let merchantCapabilities = call.getArray("merchantCapabilities") as? [String],
              let totalLabel = call.getString("totalLabel"),
              let totalAmount = call.getString("totalAmount")
        else {
            call.reject("Invalid parameters")
            return
        }
        
        guard let paymentRequest = createPaymentRequest(
            itemLabel: totalLabel,
            itemAmount: totalAmount,
            merchantId: merchantIdentifier,
            countryCode: countryCode,
            currencyCode: currencyCode,
            supportedNetworks: supportedNetworks,
            merchantCapabilities: merchantCapabilities
        ) else {
            call.reject("Unable to create a payment request")
            return
        }
                
        let paymentController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        if let viewController = self.bridge?.viewController {
            viewController.present(paymentController ?? <#default value#>, animated: true, completion: nil)
            call.resolve()
        } else {
            call.reject("Failed to get bridge.viewController")
        }
        
    }
    
    private func createPaymentRequest(itemLabel: String, itemAmount: String, merchantId: String, countryCode: String, currencyCode: String, supportedNetworks: [String], merchantCapabilities: [String]) -> PKPaymentRequest? {
        let request = PKPaymentRequest()
        request.merchantIdentifier = merchantId
        request.supportedNetworks = getSupportedNetworks(supportedNetworks)
        request.merchantCapabilities = getMerchantCapabilites(merchantCapabilities)
        request.countryCode = countryCode
        request.currencyCode = currencyCode

        let item = PKPaymentSummaryItem(label: itemLabel, amount: NSDecimalNumber(string: itemAmount))
        request.paymentSummaryItems = [item]

        return request
    }
    
    private func getSupportedNetworks(_ supportedNetworks: [String]) -> [PKPaymentNetwork] {
        return supportedNetworks.compactMap { PKPaymentNetwork(rawValue: $0) }
    }
    
    private func getMerchantCapabilites(_ merchantCapabilities: [String]) -> PKMerchantCapability {
        // Convert strings to PKMerchantCapability
        var capabilities: PKMerchantCapability = []
        for capability in merchantCapabilities {
            switch capability {
                case "supports3DS":
                capabilities.insert(.capability3DS)
                case "supportsCredit":
                capabilities.insert(.capabilityCredit)
                case "supportsDebit":
                    capabilities.insert(.capabilityDebit)
                case "supportsEMV":
                    capabilities.insert(.capabilityEMV)
                default:
                    break
            }
        }
        return capabilities;
    }
    
    @objc func paymentAuthorizationSuccess(_ call: CAPPluginCall) {
        if let currentCompletionHandler = self.currentCompletionHandler {
            currentCompletionHandler(PKPaymentAuthorizationResult(status: .success, errors: nil))
        }
        
        call.resolve()
    }
    
    @objc func paymentAuthorizationFail(_ call: CAPPluginCall) {
        if let currentCompletionHandler = self.currentCompletionHandler {
            currentCompletionHandler(PKPaymentAuthorizationResult(status: .failure, errors: nil))
        }
        
        call.resolve()
    }
    
}

extension CapacitorApplePayPlugin: PKPaymentAuthorizationViewControllerDelegate {
    
    
    
    @objc public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil);
    }
    
    @objc public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let paymentToken = payment.token
        let transactionIdentifier = paymentToken.transactionIdentifier
        let paymentData = paymentToken.paymentData

        // Convert payment data to JSON or a format that can be easily handled by JavaScript
        let paymentInfo = [
            "transactionIdentifier": transactionIdentifier,
            "paymentData": paymentData.base64EncodedString() // Convert payment data to a Base64 string
        ]

        // Use a unique identifier to identify the JS callback
        let callId = UUID().uuidString // Generate a unique ID for tracking the call
            
        currentCompletionHandler = completion;
        // Send payment information back to JavaScript
        notifyListeners("authorizePayment", data: ["callId": callId, "paymentInfo": paymentInfo])
    }
    
    //func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didRequestMerchantSessionUpdate handler: @escaping (PKPaymentRequestMerchantSessionUpdate) -> Void)
   
   
}

/*

 public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        // Extract the payment token
        let paymentToken = payment.token
        let transactionIdentifier = paymentToken.transactionIdentifier
        let paymentData = paymentToken.paymentData
        
        // Convert payment data to a suitable format for JavaScript
        let paymentInfo = [
            "transactionIdentifier": transactionIdentifier,
            "paymentData": paymentData.base64EncodedString()
        ]
        
        // Generate a unique call ID for tracking
        let callId = UUID().uuidString
        
        // Store the completion handler using the call ID
        completionHandlers[callId] = completion
        
        // Notify JavaScript with the payment information
        notifyListeners("paymentAuthorized", data: ["callId": callId, "paymentInfo": paymentInfo])
    }
 
 // Method to be called from JS after processing payment
     @objc func confirmPayment(callId: String, success: Bool) {
         guard let completion = completionHandlers[callId] else { return }
         
         // Call the completion handler based on the success of the payment processing
         if success {
             completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
         } else {
             completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
         }
         
         // Remove the completion handler from the dictionary
         completionHandlers.removeValue(forKey: callId)
     }

 */
