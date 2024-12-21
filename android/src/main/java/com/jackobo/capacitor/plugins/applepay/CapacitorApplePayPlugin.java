package com.jackobo.capacitor.plugins.applepay;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "CapacitorApplePay")
public class CapacitorApplePayPlugin extends Plugin {
    @PluginMethod
    public void canMakePayments(PluginCall call) {
        JSObject ret = new JSObject();
        ret.put("canMakePayments", false);
        call.resolve(ret);
    }

    @PluginMethod
    public void startPayment(PluginCall call) {
        call.unavailable();
    }

    @PluginMethod
    public void completeMerchantValidation(PluginCall call) {
        call.unavailable();
    }

    @PluginMethod
    public void paymentAuthorizationSuccess(PluginCall call) {
        call.unavailable();
    }

    @PluginMethod
    public void paymentAuthorizationFail(PluginCall call) {
        call.unavailable();
    }

}
