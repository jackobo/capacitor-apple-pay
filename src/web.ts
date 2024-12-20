import { WebPlugin } from '@capacitor/core';

import type {ApplePaySessionObject} from "./apple-pay";
import type {
  CapacitorApplePayPlugin,
  AuthorizePaymentEvent,
  CompleteMerchantValidationRequest, PaymentRequest,
  ValidateMerchantEvent,
  CanMakePaymentsResult
} from "./definitions";



export class CapacitorApplePayWeb extends WebPlugin implements CapacitorApplePayPlugin {

  async canMakePayments(): Promise<CanMakePaymentsResult> {
    if(!(window as any).ApplePaySession) {
      return {
        canMakePayments: false
      };
    }

    return {
      canMakePayments: await ApplePaySession.canMakePayments()
    };
  }

  private _session: ApplePaySessionObject | null = null;
  async startPayment(request: PaymentRequest): Promise<void> {
    if(!await this.canMakePayments()) {
      throw new Error(`Can't make payments with Apple Pay`);
    }

    this._session = new ApplePaySession(1, {
      countryCode: request.countryCode,
      currencyCode: request.currencyCode,
      merchantCapabilities: request.merchantCapabilities,
      supportedNetworks: request.supportedNetworks,
      total: {
        label: request.totalLabel,
        amount: request.totalAmount
      }
    });

    this._session.onvalidatemerchant = async (event) => {
        const validateMerchantEvent: ValidateMerchantEvent = {
          validationURL: event.validationURL
        }
        this.notifyListeners('validateMerchant', validateMerchantEvent);
    }

    this._session.onpaymentauthorized = async (event) => {
      const authorizePaymentEvent: AuthorizePaymentEvent = {
        payment: event.payment
      }

      this.notifyListeners('authorizePayment', authorizePaymentEvent);
    }

    this._session.oncancel = () => {
      this.notifyListeners('cancel', undefined);
    }

    this._session.begin();
  }

  async completeMerchantValidation(request: CompleteMerchantValidationRequest): Promise<void> {
    if(!this._session) {
      throw new Error('ApplePay session not initialized ');
    }

    this._session.completeMerchantValidation(JSON.parse(request.merchantSession));
  }
  async paymentAuthorizationSuccess(): Promise<void> {
    if(!this._session) {
      throw new Error('ApplePay session not initialized ');
    }
    this._session.completePayment(ApplePaySession.STATUS_SUCCESS);
    this._session = null;
  }
  async paymentAuthorizationFail(): Promise<void> {
    if(!this._session) {
      throw new Error('ApplePay session not initialized ');
    }
    this._session.completePayment(ApplePaySession.STATUS_FAILURE);
    this._session = null;
  }

}
