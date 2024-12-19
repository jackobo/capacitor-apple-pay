import type {PaymentRequest, ValidateMerchantEvent} from "./definitions";

export interface ApplePayPaymentAuthorizedEvent {
    payment: any
}

export interface ApplePaySessionObject {

    // eslint-disable-next-line @typescript-eslint/no-misused-new
    new(version: number, paymentRequest: PaymentRequest): ApplePaySessionObject;

    canMakePayments(): Promise<boolean>;
    begin(): void;
    completeMerchantValidation(merchantSession: any): void;
    completePayment(status: number): void;
    abort(): void;

    onvalidatemerchant: (event: ValidateMerchantEvent) => void;
    onpaymentauthorized: (event: ApplePayPaymentAuthorizedEvent) => void;
    oncancel: () => void;

    STATUS_SUCCESS: number;
    STATUS_FAILURE: number;
    STATUS_INVALID: number;
}


declare global {
    const ApplePaySession: ApplePaySessionObject;
}

export {};