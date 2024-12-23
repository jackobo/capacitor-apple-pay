import type {PluginListenerHandle} from "@capacitor/core";

/**
 * All available payment networks
 */
export type PaymentNetwork =
    'amex' | 'bancomat' | 'bancontact' | 'cartesBancaires' | 'chinaUnionPay' | 'dankort'
    | 'discover' | 'eftpos' | 'electron' | 'elo' | 'girocard' | 'interac'
    | 'jcb' | 'mada' | 'maestro' | 'masterCard' | 'mir' | 'privateLabel'
    | 'visa' | 'vPay';


/**
 * Merchant capabilities
 */
export type MerchantCapability = 'supports3DS' | 'supportsCredit' | 'supportsDebit' | 'supportsEMV';

/**
 * Response returned by the canMakePayments method
 */
export interface CanMakePaymentsResult {
  /**
   * It is true if Apple Pay is available
   */
  canMakePayments: boolean;
}

export interface PaymentRequestTotal {
  /**
   * The name that appears next to the amount. Usually this is your merchant name
   */
  label: string;
  /**
   * The amount formatted as string
   * yourAmount.toFixed(2)
   */
  amount: string;
  /**
   * Defaults to final
   */
  type?: 'final' | 'pending'
}

/**
 * The payload for startPayment method
 */
export interface PaymentRequest {
  merchantId: string;
  countryCode: string;
  currencyCode: string;
  supportedNetworks: PaymentNetwork[];
  merchantCapabilities: MerchantCapability[];
  total: PaymentRequestTotal;
}

/**
 * The validateMerchant event payload
 */
export interface ValidateMerchantEvent {
  /**
   * The URL that your backend needs to use in order to perform merchant validation with Apple
   */
  validationURL: string;
}

/**
 * validateMerchant event callback
 */
export type ValidateMerchantEventHandler = (event: ValidateMerchantEvent) => void;

/**
 * authorizePayment event payload
 */
export interface AuthorizePaymentEvent {
  payment: any;
}

/**
 * authorizePayment event callback
 */
export type AuthorizePaymentEventHandler = (event: AuthorizePaymentEvent) => void;

/**
 * cancel event callback
 */
export type CancelPaymentEventHandler = () => void;

/**
 * completeMerchantValidation method request
 */
export interface CompleteMerchantValidationRequest {
  /**
   * Contains the merchant session obtained from your server in the merchant validation process
   */
  merchantSession: string;
}



export interface CapacitorApplePayPlugin {

  /**
   * Checks if Apple Pay is available
   * @returns CanMakePaymentsResult
   */
  canMakePayments(): Promise<CanMakePaymentsResult>;

  /**
   * Subscribe to the validateMerchant event
   * @param eventName
   * @param handler
   */
  addListener(eventName: 'validateMerchant', handler: ValidateMerchantEventHandler): Promise<PluginListenerHandle>;

  /**
   * Subscribe to the authorizePayment event
   * @param eventName
   * @param {AuthorizePaymentEventHandler} handler
   */
  addListener(eventName: 'authorizePayment', handler: AuthorizePaymentEventHandler): Promise<PluginListenerHandle>;

  /**
   * Subscribe to the cancel event (when the payment is canceled by the user by closing Apple Pay payment sheet)
   * @param {cancel} eventName
   * @param {CancelPaymentEventHandler} handler
   */
  addListener(eventName: 'cancel', handler: CancelPaymentEventHandler): Promise<PluginListenerHandle>;

  /**
   * Starts the payment process
   * @param {PaymentRequest} request
   */
  startPayment(request: PaymentRequest): Promise<void>;

  /**
   * You call this from your code after you performed merchant validation with your server.
   * @param request
   */
  completeMerchantValidation(request: CompleteMerchantValidationRequest): Promise<void>;

  /**
   * You call this from your code after the payment processing was successful
   */
  paymentAuthorizationSuccess(): Promise<void>;

  /**
   * You call this from your code after when the payment processing failed
   */
  paymentAuthorizationFail(): Promise<void>;

  /**
   * Unsubscribe from all events
   */
  removeAllListeners(): Promise<void>;

}
