---
title: Embedded mobile and Wireless System Code Example
date: 2023-01-26 13:15:24
tags:
 - 2022-2023
categories: 
 - academic material

home_invisible: True
---

Lecture notes: (https://pipirima.top/2022-2023/Embedded-mobile-and-Wireless-System-e97c63b4991e)

# Button click
create a page which will collect string in text box. When click the button, a new page with collected string will be generated.

## MainActivity.java
``` Bash
public class MainActivity extends AppCompatActivity {

    @Override
    // default init programe
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public static final String EXTRA_MESSAGE="com.example.myapplication.MESSAGE";

    public void sendMessage(View view){
        Intent intent=new Intent(this,DisplayMessageActivity.class); // create an intent class which will communicated with DisplayMessageActivity.class
        EditText editText=(EditText) findViewById(R.id.editTextTextPersonName); // find the EditText object id (target this component)
        String message=editText.getText().toString(); // get written string in this EditText 
        intent.putExtra(EXTRA_MESSAGE, message); // put the string into EXTRA_MESSAGE. this can be seen as a convenience store place
        startActivity (intent); // running intent, or running the class the intent has (DisplayMessageActivity.class)
    }
}
```

## MainActivity.xml
``` Bash
    <EditText
        android:id="@+id/editTextTextPersonName"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:ems="10"

        android:hint="@string/edit_message"
        android:inputType="textPersonName"
        app:layout_constraintBottom_toBottomOf="parent"

        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="0.079"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintVertical_bias="0.023"
        tools:ignore="TouchTargetSizeCheck" />

    <Button
        android:id="@+id/button"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"

        android:onClick="sendMessage"
        android:text="@string/button_send"
        app:layout_constraintBaseline_toBaselineOf="@+id/editTextTextPersonName"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="0.752"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintVertical_bias="0.023" />

    <Spinner
        android:id="@+id/spinner"
        android:layout_width="409dp"
        android:layout_height="wrap_content"
        tools:ignore="TouchTargetSizeCheck"
        tools:layout_editor_absoluteX="1dp"
        tools:layout_editor_absoluteY="77dp" />
```

## DisplayMessageActivity.java
``` Bash
public class DisplayMessageActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_display_message);

        Intent intent=getIntent();
        String message=intent.getStringExtra(MainActivity.EXTRA_MESSAGE); // get input string from EXTRA_MESSAGE

        TextView textView=findViewById(R.id.textView); // find target textView
        textView.setText(message); // input message to textView
    }
}
```

## DisplayMessageActivity.xml
``` Bash
    <TextView
        android:id="@+id/textView"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="Hello!"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="0.498"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />
```

## results:
![101.png](101.png)
![102.png](102.png)

# EMF sensor
a gyroscope sensor, will display rotate angles on the screen. Based on SensorEventListener.
when sensor's value changed, the function onSensorChanged will be enabled and read, changem display sensor's value into 4 TextView boxes

## MainActivity.java
``` Bash
public class MainActivity extends AppCompatActivity implements SensorEventListener {

    private SensorManager mSensorManager; // access to a sensor
    private Sensor mMagneticField; // represent a sensor

    //Sensor manager guidance: http://developer.android.com/reference/android/hardware/SensorManager.html
    // Sensor guidance: http://developer.android.com/reference/android/hardware/Sensor.html

    private TextView mag_x;
    private TextView mag_y;
    private TextView mag_z;
    private TextView mag_h;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mag_x = (TextView) findViewById(R.id.emf_Xaxis);
        mag_y=(TextView) findViewById(R.id.emf_Yaxis);
        mag_z=(TextView) findViewById(R.id.emf_Zaxis);
        mag_h=(TextView) findViewById(R.id.emf_magnetic_field);

        //get an instance of sensor manager for accessing sensors
        mSensorManager=(SensorManager) getSystemService(Context.SENSOR_SERVICE);
        //determine default sensor type ()magnetometer
        mMagneticField=mSensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);
    }

    private double h;
    // called when sensor value have changed
    @Override
    public void onSensorChanged(SensorEvent sensorEvent) {
        h=Math.sqrt(sensorEvent.values[0]*sensorEvent.values[0]+sensorEvent.values[1]*sensorEvent.values[1]+sensorEvent.values[2]*sensorEvent.values[2]);
        mag_x.setText("mag_Xaxis:"+sensorEvent.values[0]);
        mag_y.setText("mag_Yaxis:"+sensorEvent.values[1]);
        mag_z.setText("mag_Zaxis:"+sensorEvent.values[2]);
        mag_h.setText("magneticField:"+h);
    }

    // called when sensor accuracy changed
    @Override
    public void onAccuracyChanged(Sensor sensor, int i) {

    }

    @Override
    protected void onPause() {
        super.onPause();
        mSensorManager.unregisterListener(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
        mSensorManager.registerListener(this,mMagneticField,SensorManager.SENSOR_DELAY_NORMAL);
    }
}
```

## MainActivity.xml
``` Bash
    <LinearLayout
        android:layout_width="332dp"
        android:layout_height="565dp"
        android:layout_marginStart="24dp"
        android:layout_marginTop="24dp"
        android:layout_marginEnd="24dp"
        android:orientation="vertical"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="0.483"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintVertical_bias="0.147">

        <TextView
            android:id="@+id/emf_Xaxis"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="emf_Xaxis" />

        <TextView
            android:id="@+id/emf_Yaxis"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="emf_Yaxis" />

        <TextView
            android:id="@+id/emf_Zaxis"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="emf_Zaxis" />

        <TextView
            android:id="@+id/emf_magnetic_field"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="emf_Haxis" />
    </LinearLayout>
```

## result:
![103.png](103.png)

## extra: Accelerometer
The accelerometer with low pass filter, and remove gravity.
``` Bash
        gravity[0]=alpha*gravity[0]+(1-alpha)*sensorEvent.values[0];
        gravity[1]=alpha*gravity[1]+(1-alpha)*sensorEvent.values[1];
        gravity[2]=alpha*gravity[2]+(1-alpha)*sensorEvent.values[2];

        float linear_acceleration [] = new float[3];
        linear_acceleration[0] = sensorEvent.values[0]-gravity[0];
        linear_acceleration[1] = sensorEvent.values[1]-gravity[1];
        linear_acceleration[2] = sensorEvent.values[2]-gravity[2];
```


# Battery Manager
read batteyr states from 'Intent.ACTION_BATTERY_CHANGED', and print them out

## MainActivity.java
``` Bash
package com.example.a3power_management;

import androidx.appcompat.app.AppCompatActivity;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    // IntentFilter is a structured description of Intent values to be matched.
    private IntentFilter ifilter;
    public TextView TV;

    private int BatteryL; //battery level
    private int BatteryV; //battery voltage
    private double BatteryT; //battery temperature
    private String BatteryTe; //battery technology
    private String BatteryStatus;
    private String BatteryHealth;
    private String BatteryPlugged;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED); //ifilter have matched with a type of action
        registerReceiver(mBatInforReceiver,ifilter); //the receiver will be called when any broadcast matches filter

        TV=(TextView)findViewById(R.id.TV);
    }

    private BroadcastReceiver mBatInforReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            //Retrieve data from intent
            if (Intent.ACTION_BATTERY_CHANGED.equals(action)){
                BatteryL=intent.getIntExtra("level",0);
                BatteryV=intent.getIntExtra("voltage",0);
                BatteryT=intent.getIntExtra("temperature",0);
                BatteryTe=intent.getStringExtra("technology");

                switch (intent.getIntExtra("status", BatteryManager.BATTERY_HEALTH_UNKNOWN)){
                    case BatteryManager.BATTERY_STATUS_CHARGING:
                        BatteryStatus="Charging";
                        break;
                    case BatteryManager.BATTERY_STATUS_DISCHARGING:
                        BatteryStatus="Discharging";
                        break;
                    case BatteryManager.BATTERY_STATUS_NOT_CHARGING:
                        BatteryStatus="Not Charging";
                        break;
                    case BatteryManager.BATTERY_STATUS_FULL:
                        BatteryStatus="Fully Charging";
                        break;
                    case BatteryManager.BATTERY_STATUS_UNKNOWN:
                        BatteryStatus="Unknown status";
                        break;
                }

                switch (intent.getIntExtra("health",BatteryManager.BATTERY_STATUS_UNKNOWN)){
                    case BatteryManager.BATTERY_HEALTH_UNKNOWN:
                        BatteryHealth="Unknown Status";
                        break;
                    case BatteryManager.BATTERY_HEALTH_GOOD:
                        BatteryHealth="Good Status";
                        break;
                    case BatteryManager.BATTERY_HEALTH_DEAD:
                        BatteryHealth="Dead Status";
                        break;
                    case BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE:
                        BatteryHealth="Over Status";
                        break;
                    case BatteryManager.BATTERY_HEALTH_OVERHEAT:
                        BatteryHealth="Overheat";
                        break;
                }

                switch (intent.getIntExtra("plugged",0)){
                    case BatteryManager.BATTERY_PLUGGED_AC:
                        BatteryPlugged="Plugged to AC";
                        break;
                    case BatteryManager.BATTERY_PLUGGED_USB:
                        BatteryPlugged="Plugged to USB";
                        break;
                    case BatteryManager.BATTERY_PLUGGED_WIRELESS:
                        BatteryPlugged="Plugged to wireless";
                        break;
                    default:
                        BatteryPlugged="------";
                }

                TV.setText("Battery level:"+BatteryL+"%"+"\n\n"+
                        "Battery status:"+BatteryStatus+"\n\n"+
                        "Battery Plugged:"+BatteryPlugged+"\n\n"+
                        "Battery Health:"+BatteryHealth+"\n\n"+
                        "Battery Voltage:"+(BatteryV/1000)+"V"+"\n\n"+
                        "Battery Temperature:"+(BatteryT*0.1)+"℃"+"\n\n"+
                        "Battery Techology:"+BatteryTe);
            }
        }
    };
}

```

## MainActivity.xdc
``` Bash
<TextView
        android:id="@+id/TV"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="TextView"
        tools:layout_editor_absoluteX="35dp"
        tools:layout_editor_absoluteY="48dp" />
```

## results
![201.png](201.png)