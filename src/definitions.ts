export interface CapacitorApplePayPluginPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
