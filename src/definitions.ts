import type {PluginListenerHandle} from "@capacitor/core";

export interface CanMakePaymentsResult {
  canMakePayments: boolean;
}

export type SupportedNetworks = 'visa' | 'masterCard' | 'amex';

/*
AmEx,
    Bancomat,
    Bancontact,
    PagoBancomat,
    CarteBancaire,
    CarteBancaires,
    CartesBancaires,
    ChinaUnionPay,
    Dankort,
    Discover,
    Eftpos,
    Electron,
    Elo,
    girocard,
    Interac,
    iD,
    JCB,
    mada,
    Maestro,
    MasterCard,
    Meeza,
    Mir,
    NAPAS,
    BankAxept,
    PostFinanceAG,
    PrivateLabel,
    QUICPay,
    Suica,
    Visa,
    VPay
 */

export type MerchantCapability = 'supports3DS' | 'supportsCredit' | 'supportsDebit' | 'supportsEMV';

export interface PaymentRequest {
  merchantId: string;
  countryCode: string;
  currencyCode: string;
  supportedNetworks: SupportedNetworks[];
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
