package com.juhesass.j_operate;

import androidx.annotation.NonNull;

import android.content.Context;
import android.text.TextUtils;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.Log;
import org.json.JSONObject;
import java.util.Map;
import java.util.Set;
import java.util.List;

import cn.jiguang.api.JCoreInterface;
import cn.jiguang.internal.JConstants;
import cn.jiguang.joperate.api.JOperateInterface;

/**
 * JOperatePlugin
 */
public class JOperatePlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context mContext = null;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        if (mContext == null) {
            mContext = flutterPluginBinding.getApplicationContext();
        }
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "j_operate");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        Log.e("JOperatePlugin", "onMethodCall: " + call.method);
        if (call.method.equals("setup")) {
            setup(call, result);
        } else if (call.method.equals("setDebug")) {
            setDebug(call, result);
        } else if (call.method.equals("login")) {
            login(call, result);
        } else if (call.method.equals("setChannel")) {
            setChannel(call, result);
        } else if (call.method.equals("onEvent")) {
            onEvent(call, result);
        } else if (call.method.equals("getCuid")) {
            getCuid(call, result);
        } else if (call.method.equals("registerSuperProperties")) {
            registerSuperProperties(call, result);

        } else if (call.method.equals("clearSuperProperties")) {
            clearSuperProperties(call,result);
        } else if (call.method.equals("setUtmProperties")) {
            setUtmProperties(call, result);
        } else if (call.method.equals("profileSet")) {
            profileSet(call, result);
        } else if (call.method.equals("profileSetValues")) {
            profileSetValues(call, result);
        } else if (call.method.equals("profileSetOnceValues")) {
            profileSetOnceValues(call, result);
        } else if (call.method.equals("profileSetOnce")) {
            profileSetOnce(call, result);
        } else if (call.method.equals("profileIncrement")) {
            profileIncrement(call, result);
        } else if (call.method.equals("profileAppend")) {
            profileAppend(call, result);
        } else if (call.method.equals("profileAppendValues")) {
            profileAppendValues(call, result);
        } else if (call.method.equals("profileUnset")) {
            profileUnset(call, result);
        } else if (call.method.equals("onEventTimerStart")) {
            onEventTimerStart(call, result);
        } else if (call.method.equals("onEventTimerPause")) {
            onEventTimerPause(call, result);
        } else if (call.method.equals("onEventTimerResume")) {
            onEventTimerResume(call, result);
        } else if (call.method.equals("onEventTimerEnd")) {
            onEventTimerEnd(call, result);
        } else if (call.method.equals("removeTimer")) {
            removeTimer(call, result);
        } else if (call.method.equals("getPeripheralProperty")) {
            getPeripheralProperty(call, result);
        } else if (call.method.equals("setPermissionsAll")) {
            setPermissionsAll(call, result);
        } else if (call.method.equals("setPermissionsLocation")) {
            setPermissionsLocation(call, result);
        } else if (call.method.equals("setPermissionsMac")) {
            setPermissionsMac(call, result);
        } else if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    public void setup(MethodCall call, Result result) {
        JOperateInterface.setDebug(false);//生产环境须删除
        JOperateInterface.getInstance(mContext).init();
    }

    void setDebug(MethodCall call, Result result) {
        boolean debug = call.argument("debug");
        JOperateInterface.getInstance(mContext).setDebug(debug);
    }

    void login(MethodCall call, Result result) {
        Map<String, Object> params = call.arguments();
        JSONObject property = new JSONObject(params);
        JOperateInterface.getInstance(mContext).login(property, new JOperateInterface.CallBack() {
            @Override
            public void onCallBack(int i, String s) {
                result.success(s);
            }
        });
    }

    void setChannel(MethodCall call, Result result) {
        Map<String, Object> params = call.arguments();
        JSONObject property = new JSONObject(params);
        JOperateInterface.getInstance(mContext).setChannel(property, new JOperateInterface.CallBack() {
            @Override
            public void onCallBack(int i, String s) {
                result.success(s);
            }
        });
    }

    void onEvent(MethodCall call, Result result) {
        String key = call.argument("key");
        Map<String, Object> params = call.arguments();
        JSONObject property = new JSONObject(params);
        JOperateInterface.getInstance(mContext).onEvent(key, property);
    }


    void getCuid(MethodCall call, Result result) {
        String cuid = JOperateInterface.getInstance(mContext).getCuid();
        result.success(cuid);
    }

    void registerSuperProperties(MethodCall call, Result result) {
        Map<String, Object> params = call.arguments();
        JSONObject property = new JSONObject(params);
        JOperateInterface.getInstance(mContext).registerSuperProperties(property);
    }

    void clearSuperProperties(MethodCall call, Result result) {
        String key = call.argument("key");
        JOperateInterface.getInstance(mContext).clearSuperProperties();
    }


    void setUtmProperties(MethodCall call, Result result) {
        Map<String, Object> params = call.arguments();
        JSONObject properties = new JSONObject(params);
        JOperateInterface.getInstance(mContext).setUtmProperties(properties);
    }

    void profileSet(MethodCall call, Result result) {
        String key = call.argument("key");
        String value = call.argument("value");
        JOperateInterface.getInstance(mContext).profileSet(key, value, new JOperateInterface.CallBack() {
            @Override
            public void onCallBack(int i, String s) {

            }
        });
    }

    void profileSetValues(MethodCall call, Result result) {
        Map<String, Object> params = call.arguments();
        JSONObject properties = new JSONObject(params);
        JOperateInterface.getInstance(mContext).profileSet(properties, new JOperateInterface.CallBack() {
            @Override
            public void onCallBack(int i, String s) {

            }
        });
    }

    void profileSetOnceValues(MethodCall call, Result result) {
        Map<String, Object> params = call.arguments();
        JSONObject properties = new JSONObject(params);
        JOperateInterface.getInstance(mContext).profileSetOnce(properties, new JOperateInterface.CallBack() {
            @Override
            public void onCallBack(int i, String s) {
                result.success(s);
            }
        });
    }

    void profileSetOnce(MethodCall call, Result result) {
        String key = call.argument("key");
        String value = call.argument("value");
        JOperateInterface.getInstance(mContext).profileSetOnce(key, value, new JOperateInterface.CallBack() {
            @Override
            public void onCallBack(int i, String s) {
                result.success(s);
            }
        });
    }

    void profileIncrement(MethodCall call, Result result) {
        Map<String,  ? extends Number> params = call.arguments();
        JOperateInterface.getInstance(mContext).profileIncrement(params,
                new JOperateInterface.CallBack() {
                    @Override
                    public void onCallBack(int i, String s) {
                        result.success(s);
                    }
                });
    }


    void profileAppend(MethodCall call, Result result) {
        String key = call.argument("key");
        String values = call.argument("values");
        JOperateInterface.getInstance(mContext).profileAppend(key, values,
                new JOperateInterface.CallBack() {
                    @Override
                    public void onCallBack(int i, String s) {
                        result.success(s);
                    }
                });
    }

    void profileAppendValues(MethodCall call, Result result) {
        String key = call.argument("key");
        Set<String> values = call.argument("values");
        JOperateInterface.getInstance(mContext).profileAppend(key, values,
                new JOperateInterface.CallBack() {
                    @Override
                    public void onCallBack(int i, String s) {
                        result.success(s);
                    }
                });
    }


    void profileUnset(MethodCall call, Result result) {
        String property = call.argument("property");
        JOperateInterface.getInstance(mContext).profileUnset(property,
                new JOperateInterface.CallBack() {
                    @Override
                    public void onCallBack(int i, String s) {
                        result.success(s);
                    }
                });
    }


    void onEventTimerStart(MethodCall call, Result result) {
        String eventName = call.argument("eventName");
        String key = JOperateInterface.getInstance(mContext).onEventTimerStart(eventName);
        result.success(key);
    }

    void onEventTimerPause(MethodCall call, Result result) {
        String eventNameKey = call.argument("eventNameKey");
        JOperateInterface.getInstance(mContext).onEventTimerPause(eventNameKey);
    }

    void onEventTimerResume(MethodCall call, Result result) {
        String eventNameKey = call.argument("eventNameKey");
        JOperateInterface.getInstance(mContext).onEventTimerResume(eventNameKey);
    }

    void onEventTimerEnd(MethodCall call, Result result) {
        String eventNameKey = call.argument("eventNameKey");
        Map<String, Object> params = call.arguments();
        JSONObject property = new JSONObject(params);
        JOperateInterface.getInstance(mContext).onEventTimerEnd(eventNameKey, property);
    }

    void removeTimer(MethodCall call, Result result) {
        String eventNameKey = call.argument("eventNameKey");
        JOperateInterface.getInstance(mContext).removeTimer(eventNameKey);
    }

    void getPeripheralProperty(MethodCall call, Result result) {
        JSONObject jsonObject = JOperateInterface.getInstance(mContext).getPeripheralProperty();
        result.success(jsonObject.toString());
    }

    void setPermissionsAll(MethodCall call, Result result) {
        boolean isGranted = call.argument("isGranted");
        JOperateInterface.getInstance(mContext).setPermissionsAll(isGranted);
    }

    void setPermissionsLocation(MethodCall call, Result result) {
        boolean isGranted = call.argument("isGranted");

        JOperateInterface.getInstance(mContext).setPermissionsLocation(isGranted);
    }

    void setPermissionsMac(MethodCall call, Result result) {
        boolean isGranted = call.argument("isGranted");
        JOperateInterface.getInstance(mContext).setPermissionsMac(isGranted);
    }
}
