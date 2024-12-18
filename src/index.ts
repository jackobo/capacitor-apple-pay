import { registerPlugin } from '@capacitor/core';

import type { CapacitorApplePayPluginPlugin } from './definitions';

const CapacitorApplePayPlugin = registerPlugin<CapacitorApplePayPluginPlugin>('CapacitorApplePayPlugin', {
  web: () => import('./web').then((m) => new m.CapacitorApplePayPluginWeb()),
});

export * from './definitions';
export { CapacitorApplePayPlugin };
