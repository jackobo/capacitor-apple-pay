import type {ApplePayPaymentAuthorizedEvent, ApplePayPaymentRequest, ApplePayValidateMerchantEvent} from "./definitions";

export interface ApplePaySessionObject {
    // eslint-disable-next-line @typescript-eslint/no-misused-new
    new(version: number, paymentRequest: ApplePayPaymentRequest): ApplePaySessionObject;
    canMakePayments(): Promise<boolean>;
    onvalidatemerchant: (event: ApplePayValidateMerchantEvent) => void;
    onpaymentauthorized: (event: ApplePayPaymentAuthorizedEvent) => void;
    begin(): void;
    completeMerchantValidation(merchantSession: any): void;
    completePayment(status: number): void;
    STATUS_SUCCESS: number;
    STATUS_FAILURE: number;
    STATUS_INVALID: number;
}


declare global {
    const ApplePaySession: ApplePaySessionObject;
}

export {};