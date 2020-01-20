package io.prefs;

import android.content.Context;
import android.content.SharedPreferences;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

public class SyncPreferenceModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    private final String preferencesName = "react-native";

    private final SharedPreferences prefs;

    public SyncPreferenceModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        this.prefs = reactContext.getSharedPreferences(preferencesName, Context.MODE_PRIVATE);
    }

    @Override
    public String getName() {
        return "SyncPreference";
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, String> map = new HashMap<>();
        Map<String, ?> allEntries = prefs.getAll();
        for (Map.Entry<String, ?> entry : allEntries.entrySet()) {
            map.put(entry.getKey(), entry.getValue().toString());
        }
        final Map<String, Object> res = new HashMap<>();
        res.put("InitialPrefs", map);
        return res;
    }

    private SharedPreferences.Editor getEditor() {
        return prefs.edit();
    }

    @ReactMethod
    public void clearAll(Promise promise) {
        SharedPreferences.Editor editor = getEditor();
        Map<String, ?> allEntries = prefs.getAll();
        for (Map.Entry<String, ?> entry : allEntries.entrySet()) {
            editor.remove(entry.getKey());
        }
        editor.commit();
        promise.resolve(null);
    }

    @ReactMethod
    public void clearMultiple(ReadableArray keys, Promise promise) {
        SharedPreferences.Editor editor = getEditor();
        for(int i = 0; i < keys.size(); i++) {
            editor.remove(keys.getString(i));
        }
        editor.commit();
        promise.resolve(null);
    }

    @ReactMethod
    public void clear(String key, Promise promise) {
        getEditor().remove(key).commit();
        promise.resolve(null);
    }

    @ReactMethod
    public void set(String key, String value, Promise promise) {
        getEditor().putString(key, value).commit();
        promise.resolve(null);
    }

    @ReactMethod
    public void setMultiple(ReadableMap data, Promise promise) {
        SharedPreferences.Editor editor = getEditor();
        ReadableMapKeySetIterator iter = data.keySetIterator();
        while(iter.hasNextKey()) {
            String key = iter.nextKey();
            editor.putString(key, data.getString(key)).commit();
        }
        promise.resolve(null);
    }


}
