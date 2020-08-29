package club.nowmozilla.ec_senior;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_ID = "ec_senior/alarm_service";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL_ID).setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("helloFromNativeCode")) {

                        String greetings = helloFromNativeCode();
                        result.success(greetings);
                    }
                });
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