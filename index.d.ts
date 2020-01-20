declare module 'react-native-sync-preference' {
    export interface PreferenceKeys {
        [key: string]: string;
    }

    export default class SyncPreference {
        static get(key: string): string | undefined;
        static set(key: string, value: string): Promise<void>;
        static clear(key: string): Promise<void>;
        static getMultiple(keys: string[]): PreferenceKeys;
        static setMultiple(data: PreferenceKeys): Promise<void>;
        static clearMultiple(keys: string[]): Promise<void>;
        static getAll(): PreferenceKeys;
        static clearAll(): Promise<void>;
    }
}