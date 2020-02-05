package club.nowmozilla.ec_senior

import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import android.telephony.SmsManager;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class MainActivity: FlutterActivity() {
//    private val CHANNEL = "sendSms"
//    private val callResult:MethodChannel.Result

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this

//                MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
//                object:MethodChannel.MethodCallHandler() {
//                    fun onMethodCall(call:MethodCall, result:MethodChannel.Result) {
//                        if (call.method.equals("send"))
//                        {
//                            val num = call.argument("phone")
//                            val msg = call.argument("msg")
//                            sendSMS(num, msg, result)
//                        }
//                        else
//                        {
//                            result.notImplemented()
//                        }
//                    }
//                })
    }

//    private fun sendSMS(phoneNo:String, msg:String, result:MethodChannel.Result) {
//        try
//
//            val smsManager = SmsManager.getDefault()
//            smsManager.sendTextMessage(phoneNo, null, msg, null, null)
//            result.success("SMS Sent")
//        }
//        catch (ex:Exception) {
//            ex.printStackTrace()
//            result.error("Err", "Sms Not Sent", "")
//        }
//    }
}