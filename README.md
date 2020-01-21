# react-native-sync-preference

Synchronous gets for user preferences. Uses standard UserDefaults on iOS and SharedPreferences with name `react-native` and `MODE_PRIVATE`

## Getting started

`$ npm install react-native-sync-preference --save`

### Mostly automatic installation

Auto linking for RN 0.60+

Older Version:

`$ react-native link react-native-sync-preference`

## Usage
```javascript

interface PreferenceKeys {
    [key: string]: string;
}

class SyncPreference {
    static get(key: string): string | undefined;
    static set(key: string, value: string): Promise<void>;
    static clear(key: string): Promise<void>;
    static getMultiple(keys: string[]): PreferenceKeys;
    static setMultiple(data: PreferenceKeys): Promise<void>;
    static clearMultiple(keys: string[]): Promise<void>;
    static getAll(): PreferenceKeys;
    static clearAll(): Promise<void>;
}

import SyncPreference from 'react-native-sync-preference';

// Get a value from preferences
SyncPreference.get('favorites')
```

## Synchronous

All write operations are reflected immediately through the JS module. You can use the returned promise to know when the changes have been acknowledged by the native platform. 