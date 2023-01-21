---
title: Embedded mobile and Wireless System
date: 2023-01-20 14:48:35
tags:
 - 2022-2023
categories: 
 - academic material

password: frank
---

# initialization
APP: Android Studio v.2020.3.1.26 Patch4, published at December 8, 2021
(https://developer.android.com/studio/archive) please note: Change to English language or may not find this version
language: JAVA
Minimum SDK platform: Android 9 (pie)

tools -> SDK manger
SDK tools: Android SDK build, Android Emulator, Android SDK platform (tool), (optional) HAXM installer

tools -> AVD manager
Harware: Phone-Pixle 2
the emulator can be actived after build. If terminated, please check device's virtual device support.

![000.png](000.png)

one group of xml page have sutomatically initialized when creating a new project.
MainActivity (logic code) and activity_main.xml (page design)
![001.png](001.png)

and a "Hello Word" programe is already coded, can directly ran the programe and test the setting.

# Usual parameter values
``` Bash
android:text="text"

android:layout_width="wrap_content"
android:layout_height="wrap_content"

app:layout_constraintBottom_toBottomOf="parent"
app:layout_constraintEnd_toEndOf="parent"
app:layout_constraintStart_toStartOf="parent"
app:layout_constraintTop_toTopOf="parent"
```

# Button click
create a page which will collect string in text box. When click the button, a new page with collected string will be generated.

MainActivity.java
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

activity_main.xml
``` Bash
Edit Text:
android:id="@+id/editTextTextPersonName"
android:hint="@string/edit_message"

Button:
android:id="@+id/button"
android:onClick="sendMessage" // behavier function name
```

DisplayMessageActivity.java
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

results:
![002.png](002.png)
![003.png](003.png)

# EMF sensor
a gyroscope sensor, will display rotate angles on the screen. Based on SensorEventListener.
when sensor's value changed, the function onSensorChanged will be enabled and read, changem display sensor's value into 4 TextView boxes

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

result:
![004.png](004.png)