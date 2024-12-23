# @jackobo/capacitor-apple-pay

Capacitor plugin for Apple Pay

## Install

```bash
npm install @jackobo/capacitor-apple-pay
npx cap sync
```

## Usage
```bash

async function payWithApplePay() {
    await CapacitorApplePay.addListener('validateMerchant', async (event: ValidateMerchantEvent) => {
        const merchantSession = await validateMerchantWithYourServer(event.validationURL);
            
        await CapacitorApplePay.completeMerchantValidation({
          merchantSession: merchantSession
        })
    });
    
    await CapacitorApplePay.addListener('authorizePayment', async (event: AuthorizePaymentEvent) => {
        try {
            const success = await processPaymentWithYourServer(event.payment);
            if(success) {
              await CapacitorApplePay.paymentAuthorizationSuccess();
            } else {
              await CapacitorApplePay.paymentAuthorizationFail();        
            }
        } finally {
            await CapacitorApplePay.removeAllListeners();
        }
    }
    
    await CapacitorApplePay.addListener('cancel', async () => {
        await CapacitorApplePay.removeAllListeners();
    });
    
    await CapacitorApplePay.startPayment(paymentRequestObject);
}

```


## API

<docgen-index>

* [`canMakePayments()`](#canmakepayments)
* [`addListener('validateMerchant', ...)`](#addlistenervalidatemerchant-)
* [`addListener('authorizePayment', ...)`](#addlistenerauthorizepayment-)
* [`addListener('cancel', ...)`](#addlistenercancel-)
* [`startPayment(...)`](#startpayment)
* [`completeMerchantValidation(...)`](#completemerchantvalidation)
* [`paymentAuthorizationSuccess()`](#paymentauthorizationsuccess)
* [`paymentAuthorizationFail()`](#paymentauthorizationfail)
* [`removeAllListeners()`](#removealllisteners)
* [Interfaces](#interfaces)
* [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### canMakePayments()

```typescript
canMakePayments() => Promise<CanMakePaymentsResult>
```

Checks if Apple Pay is available

**Returns:** <code>Promise&lt;<a href="#canmakepaymentsresult">CanMakePaymentsResult</a>&gt;</code>

--------------------


### addListener('validateMerchant', ...)

```typescript
addListener(eventName: 'validateMerchant', handler: ValidateMerchantEventHandler) => Promise<PluginListenerHandle>
```

Subscribe to the validateMerchant event

| Param           | Type                                                                                  |
| --------------- | ------------------------------------------------------------------------------------- |
| **`eventName`** | <code>'validateMerchant'</code>                                                       |
| **`handler`**   | <code><a href="#validatemerchanteventhandler">ValidateMerchantEventHandler</a></code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('authorizePayment', ...)

```typescript
addListener(eventName: 'authorizePayment', handler: AuthorizePaymentEventHandler) => Promise<PluginListenerHandle>
```

Subscribe to the authorizePayment event

| Param           | Type                                                                                  |
| --------------- | ------------------------------------------------------------------------------------- |
| **`eventName`** | <code>'authorizePayment'</code>                                                       |
| **`handler`**   | <code><a href="#authorizepaymenteventhandler">AuthorizePaymentEventHandler</a></code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('cancel', ...)

```typescript
addListener(eventName: 'cancel', handler: CancelPaymentEventHandler) => Promise<PluginListenerHandle>
```

Subscribe to the cancel event (when the payment is canceled by the user by closing Apple Pay payment sheet)

| Param           | Type                                                                            |
| --------------- | ------------------------------------------------------------------------------- |
| **`eventName`** | <code>'cancel'</code>                                                           |
| **`handler`**   | <code><a href="#cancelpaymenteventhandler">CancelPaymentEventHandler</a></code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### startPayment(...)

```typescript
startPayment(request: PaymentRequest) => Promise<void>
```

Starts the payment process

| Param         | Type                                                      |
| ------------- | --------------------------------------------------------- |
| **`request`** | <code><a href="#paymentrequest">PaymentRequest</a></code> |

--------------------


### completeMerchantValidation(...)

```typescript
completeMerchantValidation(request: CompleteMerchantValidationRequest) => Promise<void>
```

You call this from your code after you performed merchant validation with your server.

| Param         | Type                                                                                            |
| ------------- | ----------------------------------------------------------------------------------------------- |
| **`request`** | <code><a href="#completemerchantvalidationrequest">CompleteMerchantValidationRequest</a></code> |

--------------------


### paymentAuthorizationSuccess()

```typescript
paymentAuthorizationSuccess() => Promise<void>
```

You call this from your code after the payment processing was successful

--------------------


### paymentAuthorizationFail()

```typescript
paymentAuthorizationFail() => Promise<void>
```

You call this from your code after when the payment processing failed

--------------------


### removeAllListeners()

```typescript
removeAllListeners() => Promise<void>
```

Unsubscribe from all events

--------------------


### Interfaces


#### CanMakePaymentsResult

Response returned by the canMakePayments method

| Prop                  | Type                 | Description                          |
| --------------------- | -------------------- | ------------------------------------ |
| **`canMakePayments`** | <code>boolean</code> | It is true if Apple Pay is available |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### ValidateMerchantEvent

The validateMerchant event payload

| Prop                | Type                | Description                                                                               |
| ------------------- | ------------------- | ----------------------------------------------------------------------------------------- |
| **`validationURL`** | <code>string</code> | The URL that your backend needs to use in order to perform merchant validation with Apple |


#### AuthorizePaymentEvent

authorizePayment event payload

| Prop          | Type             |
| ------------- | ---------------- |
| **`payment`** | <code>any</code> |


#### PaymentRequest

The payload for startPayment method

| Prop                       | Type                                                                |
| -------------------------- | ------------------------------------------------------------------- |
| **`merchantId`**           | <code>string</code>                                                 |
| **`countryCode`**          | <code>string</code>                                                 |
| **`currencyCode`**         | <code>string</code>                                                 |
| **`supportedNetworks`**    | <code>PaymentNetwork[]</code>                                       |
| **`merchantCapabilities`** | <code>MerchantCapability[]</code>                                   |
| **`total`**                | <code><a href="#paymentrequesttotal">PaymentRequestTotal</a></code> |


#### PaymentRequestTotal

| Prop         | Type                              | Description                                                                  |
| ------------ | --------------------------------- | ---------------------------------------------------------------------------- |
| **`label`**  | <code>string</code>               | The text that appears next to the amount. Usually this is your merchant name |
| **`amount`** | <code>string</code>               | The amount formatted as string yourAmount.toFixed(2)                         |
| **`type`**   | <code>'final' \| 'pending'</code> | Defaults to final if not specified                                           |


#### CompleteMerchantValidationRequest

completeMerchantValidation method request

| Prop                  | Type                | Description                                                                                |
| --------------------- | ------------------- | ------------------------------------------------------------------------------------------ |
| **`merchantSession`** | <code>string</code> | Contains the merchant session obtained from your server in the merchant validation process |


### Type Aliases


#### ValidateMerchantEventHandler

validateMerchant event callback

<code>(event: <a href="#validatemerchantevent">ValidateMerchantEvent</a>): void</code>


#### AuthorizePaymentEventHandler

authorizePayment event callback

<code>(event: <a href="#authorizepaymentevent">AuthorizePaymentEvent</a>): void</code>


#### CancelPaymentEventHandler

cancel event callback

<code>(): void</code>


#### PaymentNetwork

All available payment networks

<code>'amex' | 'bancomat' | 'bancontact' | 'cartesBancaires' | 'chinaUnionPay' | 'dankort' | 'discover' | 'eftpos' | 'electron' | 'elo' | 'girocard' | 'interac' | 'jcb' | 'mada' | 'maestro' | 'masterCard' | 'mir' | 'privateLabel' | 'visa' | 'vPay'</code>


#### MerchantCapability

Merchant capabilities

<code>'supports3DS' | 'supportsCredit' | 'supportsDebit' | 'supportsEMV'</code>

</docgen-api>
