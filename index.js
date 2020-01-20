import { NativeModules } from 'react-native';

const { SyncPreference } = NativeModules;

let preferences = SyncPreference.InitialPrefs

function invalidParams() {
    return Promise.reject(new Error('Invalid Parameters'))
}

function get(key) {
    if (typeof key === 'string') {
        return preferences[key]   
    }
}

function set(key, value) {
    if (typeof key === 'string' && typeof value === 'string') {
        preferences[key] = value
        return SyncPreference.set(key, value)
    }
    return invalidParams()
}

function clear(key) {
    if (typeof key === 'string') {
        delete preferences[key]
        return SyncPreference.clear(key)
    }
    return invalidParams()
}

function getMultiple(keys) {

    if (!Array.isArray(keys)) {
        return {}
    }

    let res = {}
    for (let i = 0; i < keys.length; i++) {
        if (typeof keys[i] === 'string')
            res[keys[i]] = preferences[keys[i]]
    }
    return res
}

function setMultiple(data) {
    if (typeof data !== 'object') {
        return invalidParams()
    }

    for (key in data) {
        if (typeof data[key] !== 'string') {
            return invalidParams()
        }
    }

    for (key in data) {
        preferences[key] = data[key]
    }

    return SyncPreference.setMultiple(data)
}

function clearMultiple(keys) {

    if (!Array.isArray(keys)) {
        return invalidParams()
    }

    for (let i = 0; i < keys.length; i++) {
        if (typeof keys[i] !== 'string') {
            return invalidParams()
        }
    }

    for (let i = 0; i < keys.length; i++) {
        delete preferences[keys[i]]
    }

    return SyncPreference.clearMultiple(keys)
}

function clearAll() {
    preferences = {}
    return SyncPreference.clearAll()
}

function getAll() {
    return {...preferences}
}

export default {
    get,
    set,
    clear,
    getMultiple,
    setMultiple,
    clearMultiple,
    getAll,
    clearAll
}
