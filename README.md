# @jackobo/capacitor-apple-pay

Capacitor plugin for Apple Pay

## Install

```bash
npm install @jackobo/capacitor-apple-pay
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`canMakePayments()`](#canmakepayments)
* [`makePayment(...)`](#makepayment)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### canMakePayments()

```typescript
canMakePayments() => Promise<boolean>
```

**Returns:** <code>Promise&lt;boolean&gt;</code>

--------------------


### makePayment(...)

```typescript
makePayment<TAuthorizationResultData>(version: number, request: ApplePayPaymentRequest, options: IMakePaymentOptions<TAuthorizationResultData>) => Promise<TAuthorizationResultData>
```

| Param         | Type                                                                                                |
| ------------- | --------------------------------------------------------------------------------------------------- |
| **`version`** | <code>number</code>                                                                                 |
| **`request`** | <code><a href="#applepaypaymentrequest">ApplePayPaymentRequest</a></code>                           |
| **`options`** | <code><a href="#imakepaymentoptions">IMakePaymentOptions</a>&lt;TAuthorizationResultData&gt;</code> |

**Returns:** <code>Promise&lt;TAuthorizationResultData&gt;</code>

--------------------


### Interfaces


#### ApplePayPaymentRequest

| Prop                       | Type                                                                                |
| -------------------------- | ----------------------------------------------------------------------------------- |
| **`countryCode`**          | <code>string</code>                                                                 |
| **`currencyCode`**         | <code>string</code>                                                                 |
| **`supportedNetworks`**    | <code>string[]</code>                                                               |
| **`merchantCapabilities`** | <code>string[]</code>                                                               |
| **`total`**                | <code><a href="#applepaypaymentrequesttotal">ApplePayPaymentRequestTotal</a></code> |


#### ApplePayPaymentRequestTotal

| Prop         | Type                |
| ------------ | ------------------- |
| **`label`**  | <code>string</code> |
| **`amount`** | <code>string</code> |


#### IMakePaymentOptions

| Prop                           | Type                                                                                                                                                                                                                             |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`validateMerchant`**         | <code>(event: <a href="#applepayvalidatemerchantevent">ApplePayValidateMerchantEvent</a>) =&gt; Promise&lt;<a href="#applepayvalidatemerchantresult">ApplePayValidateMerchantResult</a>&gt;</code>                               |
| **`merchantAuthorizePayment`** | <code>(event: <a href="#applepaypaymentauthorizedevent">ApplePayPaymentAuthorizedEvent</a>) =&gt; Promise&lt;<a href="#imerchantauthorizationresult">IMerchantAuthorizationResult</a>&lt;TAuthorizationResultData&gt;&gt;</code> |


#### ApplePayValidateMerchantEvent

| Prop                | Type                |
| ------------------- | ------------------- |
| **`validationURL`** | <code>string</code> |


#### ApplePayValidateMerchantResult

| Prop                  | Type                |
| --------------------- | ------------------- |
| **`merchantSession`** | <code>string</code> |


#### ApplePayPaymentAuthorizedEvent

| Prop          | Type             |
| ------------- | ---------------- |
| **`payment`** | <code>any</code> |


#### IMerchantAuthorizationResult

| Prop                      | Type                                  |
| ------------------------- | ------------------------------------- |
| **`isSuccess`**           | <code>boolean</code>                  |
| **`authorizationResult`** | <code>TAuthorizationResultData</code> |

</docgen-api>
