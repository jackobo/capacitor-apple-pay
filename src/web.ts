import { WebPlugin } from '@capacitor/core';

import type { CapacitorApplePayPluginPlugin } from './definitions';

export class CapacitorApplePayPluginWeb extends WebPlugin implements CapacitorApplePayPluginPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
