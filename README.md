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


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### ValidateMerchantEvent

| Prop                | Type                |
| ------------------- | ------------------- |
| **`validationURL`** | <code>string</code> |


#### AuthorizePaymentEvent

| Prop          | Type                |
| ------------- | ------------------- |
| **`payment`** | <code>string</code> |


#### PaymentRequest

| Prop                       | Type                                                                |
| -------------------------- | ------------------------------------------------------------------- |
| **`countryCode`**          | <code>string</code>                                                 |
| **`currencyCode`**         | <code>string</code>                                                 |
| **`supportedNetworks`**    | <code>string[]</code>                                               |
| **`merchantCapabilities`** | <code>string[]</code>                                               |
| **`total`**                | <code><a href="#paymentrequesttotal">PaymentRequestTotal</a></code> |


#### PaymentRequestTotal

| Prop         | Type                |
| ------------ | ------------------- |
| **`label`**  | <code>string</code> |
| **`amount`** | <code>string</code> |


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

</docgen-api>
