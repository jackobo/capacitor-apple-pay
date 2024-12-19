export interface ApplePayPaymentRequestTotal {
  label: string;
  amount: string;
}


export interface ApplePayPaymentRequest {
  countryCode: string;
  currencyCode: string;
  supportedNetworks: string[];
  merchantCapabilities: string[];
  total: ApplePayPaymentRequestTotal;
}


export interface ApplePayValidateMerchantEvent {
  validationURL: string;
}

export interface ApplePayValidateMerchantResult {
  merchantSession: string;
}

export interface ApplePayPaymentAuthorizedEvent {
  payment: any
}


export interface IMerchantAuthorizationResult<TAuthorizationResultData> {
  isSuccess: boolean;
  authorizationResult: TAuthorizationResultData;
}

export interface IMakePaymentOptions<TAuthorizationResultData> {
  validateMerchant: (event: ApplePayValidateMerchantEvent) => Promise<ApplePayValidateMerchantResult>;
  merchantAuthorizePayment: (event: ApplePayPaymentAuthorizedEvent) => Promise<IMerchantAuthorizationResult<TAuthorizationResultData>>;
}

export interface CapacitorApplePayPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  canMakePayments(): Promise<boolean>;
  makePayment<TAuthorizationResultData>(version: number, request: ApplePayPaymentRequest, options: IMakePaymentOptions<TAuthorizationResultData>): Promise<TAuthorizationResultData>;
}
