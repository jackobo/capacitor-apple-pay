import type {PluginListenerHandle} from "@capacitor/core";

export interface CanMakePaymentsResult {
  canMakePayments: boolean;
}

export type PaymentNetwork =
    'amex' | 'bancomat' | 'bancontact' | 'cartesBancaires' | 'chinaUnionPay' | 'dankort'
    | 'discover' | 'eftpos' | 'electron' | 'elo' | 'girocard' | 'interac'
    | 'jcb' | 'mada' | 'maestro' | 'masterCard' | 'mir' | 'privateLabel'
    | 'visa' | 'vPay';


export type MerchantCapability = 'supports3DS' | 'supportsCredit' | 'supportsDebit' | 'supportsEMV';

export interface PaymentRequest {
  merchantId: string;
  countryCode: string;
  currencyCode: string;
  supportedNetworks: PaymentNetwork[];
  merchantCapabilities: MerchantCapability[];
  totalLabel: string;
  totalAmount: string;
}


export interface ValidateMerchantEvent {
  validationURL: string;
}

export type ValidateMerchantEventHandler = (event: ValidateMerchantEvent) => void;

export interface AuthorizePaymentEvent {
  paymentInfo: {
    transactionIdentifier: string;
    paymentData: string;
  }
}

export type AuthorizePaymentEventHandler = (event: AuthorizePaymentEvent) => void;

export type CancelPaymentEventHandler = () => void;

export interface CompleteMerchantValidationRequest {
  merchantSession: string;
}



export interface CapacitorApplePayPlugin {

  canMakePayments(): Promise<CanMakePaymentsResult>;

  addListener(eventName: 'validateMerchant', handler: ValidateMerchantEventHandler): Promise<PluginListenerHandle>;
  addListener(eventName: 'authorizePayment', handler: AuthorizePaymentEventHandler): Promise<PluginListenerHandle>;
  addListener(eventName: 'cancel', handler: CancelPaymentEventHandler): Promise<PluginListenerHandle>;


  startPayment(request: PaymentRequest): Promise<void>;
  completeMerchantValidation(request: CompleteMerchantValidationRequest): Promise<void>;
  paymentAuthorizationSuccess(): Promise<void>;
  paymentAuthorizationFail(): Promise<void>;
  removeAllListeners(): Promise<void>;

}
