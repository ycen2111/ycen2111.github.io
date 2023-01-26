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