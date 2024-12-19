import type {PluginListenerHandle} from "@capacitor/core";

export interface PaymentRequestTotal {
  label: string;
  amount: string;
}


export interface PaymentRequest {
  countryCode: string;
  currencyCode: string;
  supportedNetworks: string[];
  merchantCapabilities: string[];
  total: PaymentRequestTotal;
}


export interface ValidateMerchantEvent {
  validationURL: string;
}

export type ValidateMerchantEventHandler = (event: ValidateMerchantEvent) => void;

export interface AuthorizePaymentEvent {
  payment: string;
}

export type AuthorizePaymentEventHandler = (event: AuthorizePaymentEvent) => void;

export type CancelPaymentEventHandler = () => void;

export interface CompleteMerchantValidationRequest {
  merchantSession: string;
}



export interface CapacitorApplePayPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;

  canMakePayments(): Promise<boolean>;

  addListener(eventName: 'validateMerchant', handler: ValidateMerchantEventHandler): Promise<PluginListenerHandle>;
  addListener(eventName: 'authorizePayment', handler: AuthorizePaymentEventHandler): Promise<PluginListenerHandle>;
  addListener(eventName: 'cancel', handler: CancelPaymentEventHandler): Promise<PluginListenerHandle>;


  startPayment(request: PaymentRequest): Promise<void>;
  completeMerchantValidation(request: CompleteMerchantValidationRequest): Promise<void>;
  paymentAuthorizationSuccess(): Promise<void>;
  paymentAuthorizationFail(): Promise<void>;
  removeAllListeners(): Promise<void>;

}
