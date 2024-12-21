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
              let total = call.getObject("total")
        else {
            call.reject("Invalid parameters")
            return
        }
        
        guard let totalAmount = total["amount"] as? String,
              let totalLabel = total["label"] as? String
        else {
            call.reject("Missing total label or total amount")
            return;
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
            call.reject("Invalid Apple Pay payment request parameters")
            return
        }
        
        guard let paymentController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) else {
            call.reject("Unable to create PKPaymentAuthorizationViewController");
            return;
        }
        
        paymentController.delegate = self
        DispatchQueue.main.async { [weak self] in
            if let viewController = self?.bridge?.viewController {
                viewController.present(paymentController, animated: true, completion: nil)
                call.resolve()
            } else {
                call.reject("Failed to get bridge.viewController")
            }
        }
        
    }
    
    private func createPaymentRequest(itemLabel: String, itemAmount: String, merchantId: String, countryCode: String, currencyCode: String, supportedNetworks: [String], merchantCapabilities: [String]) -> PKPaymentRequest? {
        let request = PKPaymentRequest()
        request.merchantIdentifier = merchantId
        request.supportedNetworks = supportedPaymentNetworks(for: supportedNetworks)
        request.merchantCapabilities = merchantCapabilites(for: merchantCapabilities)
        request.countryCode = countryCode
        request.currencyCode = currencyCode
        
        let item = PKPaymentSummaryItem(label: itemLabel, amount: NSDecimalNumber(string: itemAmount))
        request.paymentSummaryItems = [item]
        
        return request
    }
    
    
    
    
    
    @objc func paymentAuthorizationSuccess(_ call: CAPPluginCall) {
        if let currentCompletionHandler = self.currentCompletionHandler {
            currentCompletionHandler(PKPaymentAuthorizationResult(status: .success, errors: nil))
            
        }
        currentCompletionHandler = nil
        call.resolve()
    }
    
    @objc func paymentAuthorizationFail(_ call: CAPPluginCall) {
        if let currentCompletionHandler = self.currentCompletionHandler {
            currentCompletionHandler(PKPaymentAuthorizationResult(status: .failure, errors: nil))
        }
        currentCompletionHandler = nil
        call.resolve()
    }
    
    private func merchantCapabilites(for merchantCapabilities: [String]) -> PKMerchantCapability {
        
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
    
    
    private func supportedPaymentNetworks(for networks: [String]) -> [PKPaymentNetwork] {
        var availableNetworks: [PKPaymentNetwork] = []
        
        for network in networks {
            switch network {
            case "amex":
                availableNetworks.append(.amex)
            case "bancomat":
                if #available(iOS 16.0, *) {
                    availableNetworks.append(.bancomat)
                }
            case "bancontact":
                if #available(iOS 16.0, *) {
                    availableNetworks.append(.bancontact)
                }
            case "cartesBancaires":
                availableNetworks.append(.cartesBancaires)
            case "chinaUnionPay":
                availableNetworks.append(.chinaUnionPay)
            case "dankort":
                if #available(iOS 15.1, *) {
                    availableNetworks.append(.dankort)
                }
            case "discover":
                availableNetworks.append(.discover)
            case "eftpos":
                availableNetworks.append(.eftpos)
            case "electron":
                availableNetworks.append(.electron)
            case "elo":
                availableNetworks.append(.elo)
            case "girocard":
                if #available(iOS 14.0, *) {
                    availableNetworks.append(.girocard)
                }
            case "interac":
                availableNetworks.append(.interac)
            case "jcb":
                availableNetworks.append(.JCB)
            case "mada":
                availableNetworks.append(.mada)
            case "maestro":
                availableNetworks.append(.maestro)
            case "masterCard":
                availableNetworks.append(.masterCard)
            case "mir":
                if #available(iOS 14.5, *) {
                    availableNetworks.append(.mir)
                }
            case "privateLabel":
                availableNetworks.append(.privateLabel)
            case "visa":
                availableNetworks.append(.visa)
            case "vPay":
                availableNetworks.append(.vPay)
            default:
                break // Ignore unsupported networks
            }
        }
        
        return availableNetworks
    }
}
    
   

extension CapacitorApplePayPlugin: PKPaymentAuthorizationViewControllerDelegate {
    
    
    
    @objc public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil);
    }
    
    @objc public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Extracting data from the PKPayment object
        
        do {
            let tokenPaymentData = try JSONSerialization.jsonObject(
                with: payment.token.paymentData,
                options: .mutableContainers
            )
            
            let tokenPaymentMethod: [String: Any] = [
                "displayName": payment.token.paymentMethod.displayName,
                "network": payment.token.paymentMethod.network?.rawValue,
                "type": payment.token.paymentMethod.type.rawValue
            ]
            
            
            let tokenTransactionIdentifier = payment.token.transactionIdentifier;
            
            let tokenData = [
                "paymentData": tokenPaymentData,
                "paymentMethod": tokenPaymentMethod,
                "transactionIdentifier": tokenTransactionIdentifier
            ]
            
            let paymentData = [
                "token": tokenData
            ]
            
            self.currentCompletionHandler = completion
            
            notifyListeners("authorizePayment", data: ["payment": paymentData])
        } catch {
            print("Error notify authorizePayment: \(error)")
            self.currentCompletionHandler = completion
        }
        
    
        
       
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
