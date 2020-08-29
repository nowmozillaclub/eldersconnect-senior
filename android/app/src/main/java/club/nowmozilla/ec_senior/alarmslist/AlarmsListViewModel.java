package club.nowmozilla.ec_senior.alarmslist;

import android.app.Application;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import club.nowmozilla.ec_senior.data.Alarm;
import club.nowmozilla.ec_senior.data.AlarmRepository;

import java.util.List;

public class AlarmsListViewModel extends AndroidViewModel {
    private AlarmRepository alarmRepository;
    private LiveData<List<Alarm>> alarmsLiveData;

    public AlarmsListViewModel(@NonNull Application application) {
        super(application);

        alarmRepository = new AlarmRepository(application);
        alarmsLiveData = alarmRepository.getAlarmsLiveData();
    }

    public void update(Alarm alarm) {
        alarmRepository.update(alarm);
    }

    public LiveData<List<Alarm>> getAlarmsLiveData() {
        return alarmsLiveData;
    }

    public void onToggle(Alarm alarm, Context context) {
        if (alarm.isStarted()) {
            alarm.cancelAlarm(context);
            update(alarm);
        } else {
            alarm.schedule(context);
            update(alarm);
        }
    }
}
