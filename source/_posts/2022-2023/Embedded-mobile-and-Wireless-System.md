---
title: Embedded mobile and Wireless System
date: 2023-01-20 14:48:35
tags:
 - 2022-2023
categories: 
 - academic material

password: frank
---

code example: (https://pipirima.top/2022-2023/Embedded-mobile-and-Wireless-System-Code-Example-7273817ad39d/)

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
Common parameters
``` Bash
android:text="text"

android:layout_width="wrap_content"
android:layout_height="wrap_content"

app:layout_constraintBottom_toBottomOf="parent"
app:layout_constraintEnd_toEndOf="parent"
app:layout_constraintStart_toStartOf="parent"
app:layout_constraintTop_toTopOf="parent"
```

Special parametres
``` Bash
Edit Text:
android:id="@+id/editTextTextPersonName"
android:hint="@string/edit_message"

Button:
android:id="@+id/button"
android:onClick="sendMessage" // behavier function name
```

Sensors
``` Bash
//Init
private SensorManager mSensorManager; // access to a sensor
private Sensor %Sensor Name%; // represent a sensor (change %Sensor Name%)

@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mSensorManager=(SensorManager) getSystemService(Context.SENSOR_SERVICE);
        %Sensor Name%=%Sensor Name%.getDefaultSensor(Sensor.%Your Sesor Terminal%); //change %Sensor Name% and %Your Sesor Terminal%
    }
```

|Name|Code|
|:----|:----|
|MagneticField|Sensor.TYPE_MAGNETIC_FIELD|
|Accelerometer|Sensor.TYPE_ACCELEROMETER|
|Gyroscope|Sensor.TYPE_GYROSCOPE|

# usful code group
## intent
``` bash
//in main class
intent intent=new Intent(this,New_class.class); // create an intent class which will communicated with new class
intent.putExtra('extras_name', 'your_message'); // put the string into EXTRA_MESSAGE.
startActivity (intent); // running intent

//in new class
Intent intent=getIntent();
string message=intent.getStringExtra('extras_name');// message will get string value
//you can use intent.getIntExtra('extras_name') to get integer value
```

## set veiwText's value
``` bash
//in .java
TextView your_view_name=findViewById(R.id.your_view_id); // find target textView
String message=your_view_name.getText().toString(); // get written string in this EditText 
your_view_name.setText(message); // input message to textView

//in .xml
android:id="@+id/your_view_name"
```

## read battery states
``` bash
private IntentFilter ifilter;
//in OnCreate
ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED); //ifilter have matched with a type of action
registerReceiver(mBatInforReceiver,ifilter); //the receiver will be called when any broadcast matches filter

//in mBatInforReceiver
String action = intent.getAction();
if (Intent.ACTION_BATTERY_CHANGED.equals(action)){
    BatteryL=intent.getIntExtra("level",0);
    ...
}
```

|String|Constant Value|
|:----|:----|
|EXTRA_LEVEL|level|
|EXTRA_VOLTAGE|voltage|
|EXTRA_TEMPERATURE|temperature|
|EXTRA_TECHNOLOGY|technology|

|EXTRA_STATUS|status|
|:----|:----|
|BATTERY_STATUS_CHARGING|2 (0x00000002)|
|BATTERY_STATUS_DISCHARGING|3 (0x00000003)|
|BATTERY_STATUS_NOT_CHARGING|4 (0x00000004)|
|BATTERY_STATUS_FULL|5 (0x00000005)|
|BATTERY_STATUS_UNKNOWN|1 (0x00000001)|

|EXTRA_PLUGGED|plugged|
|:----|:----|
|BATTERY_PLUGGED_AC|1 (0x00000001)|
|BATTERY_PLUGGED_USB|2 (0x00000002)|
|BATTERY_PLUGGED_WIRELESS|4 (0x00000004)|

|EXTRA_HEALTH|health|
|:----|:----|
|BATTERY_HEALTH_UNKNOWN|1 (0x00000001)|
|BATTERY_HEALTH_GOOD|2 (0x00000002)|
|BATTERY_HEALTH_DEAD|4 (0x00000004)|
|BATTERY_HEALTH_OVER_VOLTAGE|5 (0x00000005)|
|BATTERY_HEALTH_OVERHEAT|3 (0x00000003)|

## create onclick event on View
``` Bash
imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //your code
            }
        });
```

## count down timer
``` Bash
CountDownTimer countDownTimer = new CountDownTimer(500, 1000) {

        public void onTick(long millisUntilFinished) {
            // do something after 0.5s
        }

        public void onFinish() {
            // do something end after 1s
            start(); //restart the timer
        }
    };
```

# tips
in res -> values -> strings.xml, we can set some default variable strings, in form like
``` Bash
<resources>
    <string name="app_name">My Application</string>
    <string name="edit_message">Enter a message</string>
    <string name="button_send">Send</string>
</resources>
```
![001.png](001.png)
this code is like:
``` Bash
android:hint="@string/edit_message" // which shows "Enter a message" in layout
```