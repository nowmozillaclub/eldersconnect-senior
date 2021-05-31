package club.nowmozilla.ec_senior.activities;

import android.content.Context;
import android.content.Intent;
import android.icu.util.Calendar;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.AttributeSet;
import android.view.WindowManager;

import androidx.annotation.Nullable;

import java.util.Random;

import club.nowmozilla.ec_senior.data.Alarm;
import club.nowmozilla.ec_senior.service.AlarmService;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterNativeView;
import io.flutter.view.FlutterView;

public class RingActivity extends FlutterActivity {
    public static final String CHANNEL_ID = "ALARM_SERVICE_STARTED";

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState, @Nullable PersistableBundle persistentState) {
        super.onCreate(savedInstanceState, persistentState);
        startActivity(new Intent(this, RingActivity.class));
    }

    @Override
    public FlutterView createFlutterView(Context context) {
        WindowManager.LayoutParams matchParent = new WindowManager.LayoutParams(-1, -1);
        FlutterNativeView nativeView = this.createFlutterNativeView();
        FlutterView flutterView = new FlutterView(this, (AttributeSet) null, nativeView);
        flutterView.setInitialRoute("/alarm");
        flutterView.setLayoutParams(matchParent);
        this.setContentView(flutterView);
        new MethodChannel(flutterView, CHANNEL_ID).setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "snooze": {
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTimeInMillis(System.currentTimeMillis());
                    calendar.add(Calendar.MINUTE, 10);

                    Alarm alarm = new Alarm(
                            new Random().nextInt(Integer.MAX_VALUE),
                            calendar.get(Calendar.HOUR_OF_DAY),
                            calendar.get(Calendar.MINUTE),
                            "Snooze",
                            System.currentTimeMillis(),
                            true,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false
                    );

                    alarm.schedule(getApplicationContext());

                    Intent intentService = new Intent(getApplicationContext(), AlarmService.class);
                    getApplicationContext().stopService(intentService);
                    finish();
                    break;
                }
                case "dismiss": {
                    Intent intentService = new Intent(getApplicationContext(), AlarmService.class);
                    getApplicationContext().stopService(intentService);
                    finish();
                    break;
                }
                default:
                    result.notImplemented();
            }
        });
        return flutterView;
    }
}
