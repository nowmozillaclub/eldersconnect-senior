package club.nowmozilla.ec_senior.activities;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Build;
import android.os.Bundle;

import java.lang.reflect.Array;

import club.nowmozilla.ec_senior.data.Alarm;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String SERVICE_CHANNEL_ID = "ec_senior/alarm_service";
    public static final String CHANNEL_ID  = "ALARM_SERVICE_NOTIFY";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        createNotificationChannnel();
        new MethodChannel(getFlutterView(), SERVICE_CHANNEL_ID).setMethodCallHandler(
                (call, result) -> {
                    switch (call.method) {
                        case "helloFromNativeCode":
                            String greetings = helloFromNativeCode();
                            result.success(greetings);
                            break;
                        case "schedule_alarm":
                            if (
                                    call.argument("alarmId") == null ||
                                    call.argument("hour") == null ||
                                    call.argument("minute") == null ||
                                    call.argument("title") == null ||
                                    call.argument("created") == null ||
                                    call.argument("started") == null ||
                                    call.argument("recurring") == null ||
                                    call.argument("monday") == null ||
                                    call.argument("tuesday") == null ||
                                    call.argument("wednesday") == null ||
                                    call.argument("thursday") == null ||
                                    call.argument("friday") == null ||
                                    call.argument("saturday") == null ||
                                    call.argument("sunday") == null
                            ) {
                                result.error("68", "one or more parameters passed were null",
                                        String.format("%d, %d, %d, %s, %d, %b, %b, %b, %b, %b, %b, %b, %b, %b", call.argument("alarmId"),
                                                call.argument("hour"),
                                                call.argument("minute"),
                                                call.argument("title"),
                                                call.argument("created"),
                                                call.argument("started"),
                                                call.argument("recurring"),
                                                call.argument("monday"),
                                                call.argument("tuesday"),
                                                call.argument("wednesday"),
                                                call.argument("thursday"),
                                                call.argument("friday"),
                                                call.argument("saturday"),
                                                call.argument("sunday")));
                                break;
                            }
                            Alarm alarm = new Alarm(
                                    (int)call.argument("alarmId"),
                                    (int)call.argument("hour"),
                                    (int)call.argument("minute"),
                                    call.argument("title"),
                                    ((Number)call.argument("created")).longValue(),
                                    (boolean)call.argument("started"),
                                    (boolean)call.argument("recurring"),
                                    (boolean)call.argument("monday"),
                                    (boolean)call.argument("tuesday"),
                                    (boolean)call.argument("wednesday"),
                                    (boolean)call.argument("thursday"),
                                    (boolean)call.argument("friday"),
                                    (boolean)call.argument("saturday"),
                                    (boolean)call.argument("sunday")
                            );
                            alarm.schedule(MainActivity.this);
                            result.success("Alarm Set");
                            break;
                        default:
                            result.notImplemented();
                    }
                });
    }

    private void createNotificationChannnel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel serviceChannel = new NotificationChannel(
                    CHANNEL_ID,
                    "Alarm Service Channel",
                    NotificationManager.IMPORTANCE_DEFAULT
            );

            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(serviceChannel);
        }
    }

    private String helloFromNativeCode() {
        callResponse();
        return "Hello from Native Android Code";
    }

    private void callResponse() {
        MethodChannel channel = new MethodChannel(getFlutterView(), "RESPONSE_CHANNEL");
        channel.invokeMethod("response", "Native");
    }

}