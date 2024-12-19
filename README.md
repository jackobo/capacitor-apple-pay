# @jackobo/capacitor-apple-pay

Capacitor plugin for Apple Pay

## Install

```bash
npm install @jackobo/capacitor-apple-pay
npx cap sync
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

**Returns:** <code>Promise&lt;<a href="#canmakepaymentsresult">CanMakePaymentsResult</a>&gt;</code>

--------------------


### addListener('validateMerchant', ...)

```typescript
addListener(eventName: 'validateMerchant', handler: ValidateMerchantEventHandler) => Promise<PluginListenerHandle>
```

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

| Param         | Type                                                      |
| ------------- | --------------------------------------------------------- |
| **`request`** | <code><a href="#paymentrequest">PaymentRequest</a></code> |

--------------------


### completeMerchantValidation(...)

```typescript
completeMerchantValidation(request: CompleteMerchantValidationRequest) => Promise<void>
```

| Param         | Type                                                                                            |
| ------------- | ----------------------------------------------------------------------------------------------- |
| **`request`** | <code><a href="#completemerchantvalidationrequest">CompleteMerchantValidationRequest</a></code> |

--------------------


### paymentAuthorizationSuccess()

```typescript
paymentAuthorizationSuccess() => Promise<void>
```

--------------------


### paymentAuthorizationFail()

```typescript
paymentAuthorizationFail() => Promise<void>
```

--------------------


### removeAllListeners()

```typescript
removeAllListeners() => Promise<void>
```

--------------------


### Interfaces


#### CanMakePaymentsResult

| Prop                  | Type                 |
| --------------------- | -------------------- |
| **`canMakePayments`** | <code>boolean</code> |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### ValidateMerchantEvent

| Prop                | Type                |
| ------------------- | ------------------- |
| **`validationURL`** | <code>string</code> |


#### AuthorizePaymentEvent

| Prop              | Type                                                                 |
| ----------------- | -------------------------------------------------------------------- |
| **`paymentInfo`** | <code>{ transactionIdentifier: string; paymentData: string; }</code> |


#### PaymentRequest

| Prop                       | Type                              |
| -------------------------- | --------------------------------- |
| **`merchantId`**           | <code>string</code>               |
| **`countryCode`**          | <code>string</code>               |
| **`currencyCode`**         | <code>string</code>               |
| **`supportedNetworks`**    | <code>SupportedNetworks[]</code>  |
| **`merchantCapabilities`** | <code>MerchantCapability[]</code> |
| **`totalLabel`**           | <code>string</code>               |
| **`totalAmount`**          | <code>string</code>               |


#### CompleteMerchantValidationRequest

| Prop                  | Type                |
| --------------------- | ------------------- |
| **`merchantSession`** | <code>string</code> |


### Type Aliases


#### ValidateMerchantEventHandler

<code>(event: <a href="#validatemerchantevent">ValidateMerchantEvent</a>): void</code>


#### AuthorizePaymentEventHandler

<code>(event: <a href="#authorizepaymentevent">AuthorizePaymentEvent</a>): void</code>


#### CancelPaymentEventHandler

<code>(): void</code>


#### SupportedNetworks

<code>'visa' | 'masterCard' | 'amex'</code>


#### MerchantCapability

<code>'supports3DS' | 'supportsCredit' | 'supportsDebit' | 'supportsEMV'</code>

</docgen-api>
