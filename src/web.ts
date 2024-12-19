import { WebPlugin } from '@capacitor/core';

import type {IMakePaymentOptions, ApplePayPaymentRequest, CapacitorApplePayPlugin} from "./definitions";

export class CapacitorApplePayWeb extends WebPlugin implements CapacitorApplePayPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async canMakePayments(): Promise<boolean> {
    if(!ApplePaySession) {
      return false;
    }

    return await ApplePaySession.canMakePayments();
  }

  async makePayment<TAuthorizationResult>(version: number, request: ApplePayPaymentRequest, options: IMakePaymentOptions<TAuthorizationResult>): Promise<TAuthorizationResult> {
    if(!await this.canMakePayments()) {
      throw new Error(`Can't make payments with Apple Pay`);
    }

    return new Promise<TAuthorizationResult>((resolve, reject) => {
      const session = new ApplePaySession(version, request);
      session.onvalidatemerchant = async (event) => {
        try {

          const merchantValidationResult = await options.validateMerchant(event);

          session.completeMerchantValidation(JSON.parse(merchantValidationResult.merchantSession));
        } catch (err) {
          reject(err);
        }
      }

      session.onpaymentauthorized = async (event) => {
        try {
          const authorizationResult = await options.merchantAuthorizePayment(event);
          if(authorizationResult.isSuccess) {
            session.completePayment(ApplePaySession.STATUS_SUCCESS);
          } else {
            session.completePayment(ApplePaySession.STATUS_FAILURE);
          }
          resolve(authorizationResult.authorizationResult);
        } catch (err) {
          session.completePayment(ApplePaySession.STATUS_FAILURE);
          reject(err);
        }

      }

      session.begin();

    });

  }
}
