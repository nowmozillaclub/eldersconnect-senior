package club.nowmozilla.ec_senior.activities;

import android.os.Bundle;
import android.os.PersistableBundle;

import androidx.annotation.Nullable;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class RingActivity extends FlutterActivity {
    public static final String CHANNEL_ID = "ALARM_SERVICE_STARTED";

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState, @Nullable PersistableBundle persistentState) {
        super.onCreate(savedInstanceState, persistentState);
        MethodChannel channel = new MethodChannel(getFlutterView(), CHANNEL_ID);
        channel.invokeMethod("response", null);

    }
}


//    @BindView(R.id.activity_ring_dismiss) Button dismiss;
//    @BindView(R.id.activity_ring_snooze) Button snooze;
//    @BindView(R.id.activity_ring_clock) ImageView clock;
//
//    @Override
//    protected void onCreate(@Nullable Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//
//        setContentView(R.layout.activity_ring);
//
//        ButterKnife.bind(this);
//
//        dismiss.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                Intent intentService = new Intent(getApplicationContext(), AlarmService.class);
//                getApplicationContext().stopService(intentService);
//                finish();
//            }
//        });
//
//        snooze.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                Calendar calendar = Calendar.getInstance();
//                calendar.setTimeInMillis(System.currentTimeMillis());
//                calendar.add(Calendar.MINUTE, 10);
//
//                Alarm alarm = new Alarm(
//                        new Random().nextInt(Integer.MAX_VALUE),
//                        calendar.get(Calendar.HOUR_OF_DAY),
//                        calendar.get(Calendar.MINUTE),
//                        "Snooze",
//                        System.currentTimeMillis(),
//                        true,
//                        false,
//                        false,
//                        false,
//                        false,
//                        false,
//                        false,
//                        false,
//                        false
//                );
//
//                alarm.schedule(getApplicationContext());
//
//                Intent intentService = new Intent(getApplicationContext(), AlarmService.class);
//                getApplicationContext().stopService(intentService);
//                finish();
//            }
//        });
//
//        animateClock();
//    }
//
//    private void animateClock() {
//        ObjectAnimator rotateAnimation = ObjectAnimator.ofFloat(clock, "rotation", 0f, 20f, 0f, -20f, 0f);
//        rotateAnimation.setRepeatCount(ValueAnimator.INFINITE);
//        rotateAnimation.setDuration(800);
//        rotateAnimation.start();
//    }