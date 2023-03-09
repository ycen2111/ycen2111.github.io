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

# WIFI scaner

## Main.java
``` Bash
package com.example.a4wi_fi;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.Manifest;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import java.util.List;

public class MainActivity extends AppCompatActivity {

    WifiManager wifiManager;
    String wifis[];
    ListView lv;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //ask and check permissions
        askWiFiPermissions();

        lv = (ListView) findViewById(R.id.listView);

        //provide us an instance WifiManager and allow to access WiFi functionality
        wifiManager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);

        //check wifi state and turn it on when disabled
        if (wifiManager.getWifiState() == wifiManager.WIFI_STATE_DISABLED) {
            wifiManager.setWifiEnabled(true);
        }

        //can be seens as wifi listerner, listen WifiManager.SCAN_RESULTS_AVAILABLE_ACTION
        registerReceiver(wifiScanReceiver, new IntentFilter(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION));
        Log.v("wifi", "wifiManager" + String.valueOf(wifiManager));

        //star wifi scans
        wifiManager.startScan();
        Toast.makeText(this, "Scanning WIFI ...", Toast.LENGTH_SHORT).show();
    }

    private static final int REQUEST_ID_READ_WRITE_PERMISSION = 99;

    private void askWiFiPermissions() {
        if (Build.VERSION.SDK_INT >= 23) {
            //check if we have read or write permission
            int wifiAccessPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_WIFI_STATE);
            int ChangePermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.CHANGE_WIFI_STATE);
            int findLocationPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION);
            int coarseLocationPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION);

            if (wifiAccessPermission != PackageManager.PERMISSION_GRANTED ||
                    ChangePermission != PackageManager.PERMISSION_GRANTED ||
                    findLocationPermission != PackageManager.PERMISSION_GRANTED ||
                    coarseLocationPermission != PackageManager.PERMISSION_GRANTED) {
                //prompt the user if dont have permission
                this.requestPermissions(
                        new String[]{Manifest.permission.ACCESS_WIFI_STATE,
                                Manifest.permission.CHANGE_WIFI_STATE,
                                Manifest.permission.ACCESS_FINE_LOCATION,
                                Manifest.permission.ACCESS_COARSE_LOCATION},
                        REQUEST_ID_READ_WRITE_PERMISSION
                );
                return;
            }
        }
    }

    //When you have the request results
    @Override
    public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {
            case REQUEST_ID_READ_WRITE_PERMISSION: {
                //(read and write and camera) permissions granted
                if (grantResults.length > 1 &&
                        grantResults[0] == PackageManager.PERMISSION_GRANTED &&
                        grantResults[1] == PackageManager.PERMISSION_GRANTED &&
                        grantResults[2] == PackageManager.PERMISSION_GRANTED &&
                        grantResults[3] == PackageManager.PERMISSION_GRANTED) {
                    Toast.makeText(this, "Permission granted!", Toast.LENGTH_LONG).show();
                }
                //cancelled or denied
                else {
                    Toast.makeText(this, "Permission denied", Toast.LENGTH_LONG).show();
                }
                break;
            }
        }
    }

    BroadcastReceiver wifiScanReceiver = new BroadcastReceiver() {
        @Override
        //active when WifiManager.SCAN_RESULTS_AVAILABLE_ACTION enabled
        public void onReceive(Context c, Intent intent) {
            List<ScanResult> wifiScanList = wifiManager.getScanResults();
            unregisterReceiver(this);

            wifis=new String[wifiScanList.size()];
            Log.e("WiFi",String.valueOf(wifiScanList.size()));
            //SSID (name), BSSID (MAC address), level (signal strength (in dBm))
            for(int i=0;i<wifiScanList.size();i++){
                wifis[i]=wifiScanList.get(i).SSID+","+wifiScanList.get(i).BSSID+","+String.valueOf(wifiScanList.get(i).level);
                Log.e("WiFi",String.valueOf(wifis[i]));
            }

            //set adapter to lv. android.R.layout.simple_list_item_1 isa sort of layout resource
            lv.setAdapter(new ArrayAdapter<String>(getApplicationContext(),android.R.layout.simple_list_item_1,wifis));
        }
    };

    protected void onResume(){
        registerReceiver(wifiScanReceiver, new IntentFilter(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION));
        super.onResume();
    }

    protected void onPause(){
        unregisterReceiver(wifiScanReceiver);
        super.onPause();
    }
}
```

## Manifest.xml
``` Bash
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

## layout.xml
``` bash
<ListView
        android:id="@+id/listView"
        android:layout_width="409dp"
        android:layout_height="729dp"
        tools:layout_editor_absoluteX="1dp"
        tools:layout_editor_absoluteY="1dp"
        tools:ignore="MissingConstraints" />
```

## result
![301.png](301.png)

# BlueTooth
## Main.java
``` Bash
package com.example.a5blue_tooth;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.Manifest;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Set;

public class MainActivity extends AppCompatActivity {

    Button on,off,discoverable,device;
    ListView listView;

    //varibale to hold BluetoothAdapter instance
    private BluetoothAdapter BA;
    //display list of paired Bluetooth device
    private Set<BluetoothDevice> pairedDevices;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //check and ask permissions
        askBlueToothPermissions();

        on = (Button) findViewById(R.id.on);
        off = (Button) findViewById(R.id.off);
        discoverable = (Button) findViewById(R.id.discoverable);
        device = (Button) findViewById(R.id.device);
        listView = (ListView)findViewById(R.id.listView);

        //Bluetooth init
        BA = BluetoothAdapter.getDefaultAdapter();
    }

    private static final int REQUEST_ID_READ_WRITE_PERMISSION = 99;

    private void askBlueToothPermissions(){
        if (Build.VERSION.SDK_INT >= 23) {
            //check if we have read or write permission
            int blueToothPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH);
            int blueToothAdminPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_ADMIN);
            int blueToothAdvertisePermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_ADVERTISE); //requires API level S
            int blueToothConnectPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_CONNECT);//requires API level S
            int findLocationPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION);
            int coarseLocationPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION);

            if (blueToothPermission != PackageManager.PERMISSION_GRANTED ||
                    blueToothAdminPermission != PackageManager.PERMISSION_GRANTED ||
                    blueToothAdvertisePermission != PackageManager.PERMISSION_GRANTED ||
                    blueToothConnectPermission != PackageManager.PERMISSION_GRANTED ||
                    findLocationPermission != PackageManager.PERMISSION_GRANTED ||
                    coarseLocationPermission != PackageManager.PERMISSION_GRANTED) {
                //prompt the user if dont have permission
                this.requestPermissions(
                        new String[]{Manifest.permission.BLUETOOTH,
                                Manifest.permission.BLUETOOTH_ADMIN,
                                Manifest.permission.BLUETOOTH_ADVERTISE,
                                Manifest.permission.BLUETOOTH_CONNECT,
                                Manifest.permission.ACCESS_FINE_LOCATION,
                                Manifest.permission.ACCESS_COARSE_LOCATION},
                        REQUEST_ID_READ_WRITE_PERMISSION
                );
                return;
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {
            case REQUEST_ID_READ_WRITE_PERMISSION: {
                //(read and write and camera) permissions granted
                if (grantResults.length > 1 &&
                        grantResults[0] == PackageManager.PERMISSION_GRANTED &&
                        grantResults[1] == PackageManager.PERMISSION_GRANTED &&
                        grantResults[2] == PackageManager.PERMISSION_GRANTED &&
                        grantResults[3] == PackageManager.PERMISSION_GRANTED &&
                        grantResults[4] == PackageManager.PERMISSION_GRANTED &&
                        grantResults[5] == PackageManager.PERMISSION_GRANTED) {
                    Toast.makeText(this, "Permission granted!", Toast.LENGTH_LONG).show();
                }
                //cancelled or denied
                else {
                    Toast.makeText(this, "Permission denied", Toast.LENGTH_LONG).show();
                }
                break;
            }
        }
    }

    public void on(View v){
        if (!BA.isEnabled()){
            Intent turnOn = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(turnOn,0);
            Toast.makeText(getApplicationContext(),"Turned on",Toast.LENGTH_LONG).show();
        }
        else {
            Toast.makeText(getApplicationContext(),"Already on",Toast.LENGTH_LONG).show();
        }
    }

    public void off(View v){
        BA.disable();
        Toast.makeText(getApplicationContext(),"Turned off",Toast.LENGTH_LONG).show();
    }

    //let other device can detect phone in next several seconds
    public void visible(View v){
        Intent getVisible = new Intent(BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE);
        startActivityForResult(getVisible,0);
    }

    public void list(View v) {
        //get list
        pairedDevices = BA.getBondedDevices();
        ArrayList list = new ArrayList();

        for (BluetoothDevice bt : pairedDevices) {
            list.add(bt.getName() + "," + bt.getAddress());
        }

        Toast.makeText(getApplicationContext(),"Showing Paired Devices",Toast.LENGTH_SHORT).show();

        final ArrayAdapter adapter = new ArrayAdapter(this,android.R.layout.simple_list_item_1,list);
        listView.setAdapter(adapter);
    }
}
```

## Manifest.xml
``` Bash
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE"/>
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
```

## layout.xml
``` Bash
<Button
        android:id="@+id/on"
        android:onClick="on"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="44dp"
        android:layout_marginTop="36dp"
        android:text="Turn on"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

    <Button
        android:id="@+id/discoverable"
        android:onClick="visible"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="131dp"
        android:layout_marginTop="36dp"
        android:layout_marginEnd="48dp"
        android:text="turn discoverable"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="1.0"
        app:layout_constraintStart_toEndOf="@+id/on"
        app:layout_constraintTop_toTopOf="parent" />

    <Button
        android:id="@+id/off"
        android:onClick="off"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="44dp"
        android:layout_marginTop="44dp"
        android:text="Turn off"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/on" />

    <Button
        android:id="@+id/device"
        android:onClick="list"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="44dp"
        android:layout_marginBottom="103dp"
        android:text="list device"
        app:layout_constraintBottom_toTopOf="@+id/listView"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="0.644"
        app:layout_constraintStart_toEndOf="@+id/off"
        app:layout_constraintTop_toBottomOf="@+id/discoverable"
        app:layout_constraintVertical_bias="0.0" />

    <TextView
        android:id="@+id/textView"
        android:layout_width="117dp"
        android:layout_height="25dp"
        android:layout_marginStart="44dp"
        android:layout_marginTop="32dp"
        android:layout_marginEnd="254dp"
        android:layout_marginBottom="32dp"
        android:text="paired device"
        android:textSize="20sp"
        app:layout_constraintBottom_toTopOf="@+id/listView"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="0.0"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/off"
        app:layout_constraintVertical_bias="1.0" />

    <ListView
        android:id="@+id/listView"
        android:layout_width="339dp"
        android:layout_height="400dp"
        android:layout_marginStart="36dp"
        android:layout_marginTop="8dp"
        android:layout_marginEnd="36dp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="1.0"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/textView" />
```

## Result
![302.png](302.png)

# Location and Google Map
## MainActivity.java
``` Bash
package com.example.a7map;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.fragment.app.FragmentActivity;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.example.a7map.databinding.ActivityMapsBinding;

public class MapsActivity extends FragmentActivity implements OnMapReadyCallback {

    private GoogleMap mMap;
    private ActivityMapsBinding binding;

    private static final int REQUEST_ID_LOCATION_PERMISSION = 99;

    TextView textLat;
    TextView textLong;
    LocationManager locationManager;
    LocationListener locationListener;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMapsBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        //let us know the map is ready
        mapFragment.getMapAsync(this);

        askLocationPermission();

        locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
        locationListener = new mylocationlistener();
    }

    /**
     * Manipulates the map once available.
     * This callback is triggered when the map is ready to be used.
     * This is where we can add markers or lines, add listeners or move the camera. In this case,
     * we just add a marker near Sydney, Australia.
     * If Google Play services is not installed on the device, the user will be prompted to install
     * it inside the SupportMapFragment. This method will only be triggered once the user has
     * installed Google Play services and returned to the app.
     */
    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;

        // Add a marker in Sydney and move the camera
        LatLng Edinburgh = new LatLng(55.953251, -3.188267);
        //add new markers
        mMap.addMarker(new MarkerOptions().position(Edinburgh).title("Marker in Edinburgh"));
        //move the center of camera to marker
        mMap.moveCamera(CameraUpdateFactory.newLatLng(Edinburgh));

        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return;
        }
        //enable the location button
        mMap.setMyLocationEnabled(true);

        mMap.setMapType(GoogleMap.MAP_TYPE_HYBRID);
        mMap.getUiSettings().setCompassEnabled(true);
        mMap.getUiSettings().setRotateGesturesEnabled(true);
        mMap.getUiSettings().setScrollGesturesEnabled(true);
        mMap.getUiSettings().setTiltGesturesEnabled(true);
    }

    private void askLocationPermission() {
        if (android.os.Build.VERSION.SDK_INT >= 23) {
            //check if we have location permission
            int CoarseLocation = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION);
            int FinaLocationPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION);
            int internetPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.INTERNET);

            if (CoarseLocation != PackageManager.PERMISSION_GRANTED ||
                    internetPermission != PackageManager.PERMISSION_GRANTED ||
                    FinaLocationPermission != PackageManager.PERMISSION_GRANTED) {
                //if dont permitted yet, prompt user
                this.requestPermissions(
                        new String[]{
                                Manifest.permission.ACCESS_COARSE_LOCATION,
                                Manifest.permission.ACCESS_FINE_LOCATION,
                                Manifest.permission.INTERNET
                        },
                        REQUEST_ID_LOCATION_PERMISSION
                );
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        switch (requestCode) {
            case REQUEST_ID_LOCATION_PERMISSION: {
                //if request cancelled, result array becomes empty
                if (grantResults.length > 1
                        && grantResults[0] == PackageManager.PERMISSION_GRANTED
                        && grantResults[1] == PackageManager.PERMISSION_GRANTED
                        && grantResults[2] == PackageManager.PERMISSION_GRANTED) {
                    Toast.makeText(this, "Permission granted!", Toast.LENGTH_LONG).show();
                }
                //if cancelled or denied
                else {
                    Toast.makeText(this, "Permission denied!", Toast.LENGTH_LONG).show();
                }

                if (!locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
                    Toast.makeText(this, "Open GPS", Toast.LENGTH_SHORT).show();
                }

                if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                    // TODO: Consider calling
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                    //                                          int[] grantResults)
                    // to handle the case where the user grants the permission. See the documentation
                    // for ActivityCompat#requestPermissions for more details.
                    return;
                }
                locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, locationListener);
                break;
            }
        }
    }

    double tlat;
    double tlong;
    class mylocationlistener implements  LocationListener{
        @Override
        //called when GPS changes
        public void onLocationChanged(@NonNull Location location) {
            if (location != null) {
                tlat = location.getLatitude();
                tlong = location.getLongitude();
                textLat.setText(Double.toString(tlat));
                textLong.setText(Double.toString(tlong));
                Toast.makeText(MapsActivity.this,"New Location "+String.valueOf(tlat)+" "+String.valueOf(tlong),Toast.LENGTH_LONG).show();
                updateMap();
            }
        }
    }

    //add a new point marker and move camera to that place
    private void updateMap(){
        //Add a marker in the Edinburgh and move the camera
        LatLng latLng = new LatLng(tlat,tlong);
        mMap.addMarker(new MarkerOptions().position(latLng).title("New location"));
        //Move tie map camera to the new location
        mMap.moveCamera(CameraUpdateFactory.newLatLng(latLng));
    }

    private void setUpMapIfNeeded(){
        //null check
        if(mMap==null){
            SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map);
            mapFragment.getMapAsync(this);
        }
    }

    @Override
    protected void onPause() {
        
        super.onPause();
    }

    @Override
    protected void onResume() {
        super.onResume();

        setUpMapIfNeeded();
    }
}
```

## Manifest.xml
``` Bash
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

## layout.xml
``` Bash
<?xml version="1.0" encoding="utf-8"?>
<fragment xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:map="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/map"
    android:name="com.google.android.gms.maps.SupportMapFragment"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MapsActivity" />
```

## google_maps_api.xml
``` Bash
<resources>
    <!--
    TODO: Before you run your application, you need a Google Maps API key.

    To get one, follow this link, follow the directions and press "Create" at the end:

    https://console.developers.google.com/flows/enableapi?apiid=maps_android_backend&keyType=CLIENT_SIDE_ANDROID&r=E0:45:B0:55:16:4B:78:90:33:A3:6E:54:2F:7A:F7:8E:E2:44:DF:DB%3Bcom.example.a7map

    You can also add your credentials to an existing key, using these values:

    Package name:
    com.example.a7map

    SHA-1 certificate fingerprint:
    E0:45:B0:55:16:4B:78:90:33:A3:6E:54:2F:7A:F7:8E:E2:44:DF:DB

    Alternatively, follow the directions here:
    https://developers.google.com/maps/documentation/android/start#get-key

    Once you have your key (it starts with "AIza"), replace the "google_maps_key"
    string in this file.
    -->
    <string name="google_maps_key" templateMergeStrategy="preserve" translatable="false">AIzaSyBr7Z2f7_RceTGRvkK4XibuetGI5ScLItk</string>
</resources>
```

## Result
![401.png](401.png)

# Camera
## MainActivity.java
``` Bash
package com.example.a8camera;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.FileProvider;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.StrictMode;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        askCameraPermission();
    }

    private static final int REQUEST_ID_READ_WRITE_PERMISSION = 99;

    private void askCameraPermission(){
        if (Build.VERSION.SDK_INT>=23){
            //check permissoins
            int readPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE);
            int writePermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE);
            int cameraPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.CAMERA);

            if (readPermission != PackageManager.PERMISSION_GRANTED ||
                    writePermission != PackageManager.PERMISSION_GRANTED ||
                    cameraPermission  != PackageManager.PERMISSION_GRANTED){
                this.requestPermissions(
                        new String[]{
                                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                                Manifest.permission.READ_EXTERNAL_STORAGE,
                                Manifest.permission.CAMERA},
                        REQUEST_ID_READ_WRITE_PERMISSION
                );
                return;
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode){
            case REQUEST_ID_READ_WRITE_PERMISSION: {
                if (grantResults.length > 1
                    && grantResults[0] == PackageManager.PERMISSION_GRANTED
                        && grantResults[1] == PackageManager.PERMISSION_GRANTED
                        && grantResults[2] == PackageManager.PERMISSION_GRANTED) {
                    Toast.makeText(this, "Permission granted!", Toast.LENGTH_LONG).show();
                }
                else{
                    Toast.makeText(this, "Permission denied!", Toast.LENGTH_LONG).show();
                }
                break;
            }
        }
    }

    static final int CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE = 1;

    public void takePhoto(View view){
        //get intent if MediaStore.ACTION_IMAGE_CAPTURE active
        Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        //create file where the photo should go
        File photoFile = null;
        try{
            photoFile = createImageFile();
            Log.e("CameraApp", photoFile.getAbsolutePath());
        } catch (IOException ex){
            Log.e("error:", ex.getMessage() );
        }

        //continue if the file is successfully created
        if (photoFile != null){
            //creates a URI object to represent the location where the photo taken by the camera will be saved
            Uri photoURI = FileProvider.getUriForFile(getApplicationContext(),"com.example.a8camera",photoFile);
            //sets an extra parameter on the camera intent that indicates where the resulting photo should be saved
            takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT,photoURI);
            //starts the camera intent, which opens the camera application and allows the user to take a picture
            startActivityForResult(takePictureIntent, CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE);
        }
    }

    String currentPhotoPath;
    private File createImageFile() throws IOException{
        //create an image file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmms").format(new Date());
        String imageFileName = "JPEG_"+timeStamp+"_";
        File storageDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES);
        File image = File.createTempFile(imageFileName,".jpg",storageDir);

        //save a file
        currentPhotoPath = image.getAbsolutePath();
        return image;
    }

    @Override
    //call this function when finishes taking the picture
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE){
            if (resultCode == RESULT_OK){
                Toast.makeText(this, "Image successfully saved", Toast.LENGTH_SHORT).show();
                galleryAddPic();
            }
            else if (resultCode == RESULT_CANCELED){
                Toast.makeText(this, "Image saving is cancelled", Toast.LENGTH_SHORT).show();
            }
            else{
                Toast.makeText(this, "Image failed", Toast.LENGTH_SHORT).show();
            }
        }
    }

    private void galleryAddPic(){
        Intent mediaScanIntent = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
        File f = new File(currentPhotoPath);
        Uri contentUri = Uri.fromFile(f);
        mediaScanIntent.setData(contentUri);
        this.sendBroadcast(mediaScanIntent);
    }
}
```

## Manifest.xml
``` Bash
<uses-permission android:name="android.permission.CAMERA" />
    <uses-feature android:name="android.hardware.camera"
        android:required="true"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

//in <application>
<provider
            android:authorities="com.example.a8camera"
            android:name="androidx.core.content.FileProvider"
            android:exported="false"
            android:grantUriPermissions="true">

            <!-- this one is used to know where to look for the paths to use-->
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/file_paths"></meta-data>
        </provider>
```

## @xml/file_paths.xml
``` Bash
<?xml version="1.0" encoding="utf-8"?>
<paths>
    <external-path
        name="external"
        path="."/>
    <external-files-path
        name="external_files"
        path="."/>
    <cache-path
        name="cache"
        path="."/>
    <external-cache-path
        name="external_cache"
        path="."/>
    <files-path
        name="files"
        path="."/>
</paths>
```

# Result
![601.png](601.png)
![602.png](602.png)

# Build SensorInterface
## MainActivity.java
``` Bash
package com.example.a9sensorandcamera;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.widget.TextView;

import org.w3c.dom.Text;

public class MainActivity extends AppCompatActivity implements MotionSensorManager.OnMotionSensorManagerListener {
    //Motion sensor manager collect sensor information and gives it in a readable form
    private MotionSensorManager mMotionSensorManager;

    private TextView mag_x;
    private TextView mag_y;
    private TextView mag_z;
    private TextView mag_h;
    private TextView acc_x;
    private TextView acc_y;
    private TextView acc_z;
    private TextView gyr_x;
    private TextView gyr_y;
    private TextView gyr_z;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //three motion detectors' manager
        mMotionSensorManager = new MotionSensorManager(this);
        //set listeners
        mMotionSensorManager.setOnMotionSensorManagerListener(this);

        mag_x = findViewById(R.id.mag_x);
        mag_y = findViewById(R.id.mag_y);
        mag_z = findViewById(R.id.mag_z);
        mag_h = findViewById(R.id.mag_h);
        acc_x = findViewById(R.id.acc_x);
        acc_y = findViewById(R.id.acc_y);
        acc_z = findViewById(R.id.acc_z);
        gyr_x = findViewById(R.id.gyr_x);
        gyr_y = findViewById(R.id.gyr_y);
        gyr_z = findViewById(R.id.gyr_z);
    }

    @Override
    protected void onResume() {
        super.onResume();
        mMotionSensorManager.registerMotionSensors();
    }

    @Override
    protected void onPause() {
        super.onPause();
        mMotionSensorManager.unregisterMotionSensors();
    }

    @Override
    public void onAccValueUpdated(float[] acceleration) {
        acc_x.setText("acc_Xaxis = "+acceleration[0]);
        acc_y.setText("acc_Yaxis = "+acceleration[1]);
        acc_z.setText("acc_Zaxis = "+acceleration[2]);
    }

    @Override
    public void onGyoValueUpdated(float[] gyroscope) {
        gyr_x.setText("gyr_Xaxis = "+gyroscope[0]);
        gyr_y.setText("gyr_Yaxis = "+gyroscope[1]);
        gyr_z.setText("gyr_Zaxis = "+gyroscope[2]);
    }

    @Override
    public void onMagValueUpdated(float[] magneticfield) {
        mag_x.setText("mag_Xaxis = "+magneticfield[0]);
        mag_y.setText("mag_Yaxis = "+magneticfield[1]);
        mag_z.setText("mag_zaxis = "+magneticfield[2]);
        mag_h.setText("mag_Haxis = "+magneticfield[3]);
    }
}
```

## MotionSensorManager.java
``` bash
package com.example.a9sensorandcamera;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

public class MotionSensorManager implements SensorEventListener {
    //Information to the activity is being passed through the listener
    private OnMotionSensorManagerListener motionSensorManagerListerner;
    //Sensor manager is used to get access to all sensors
    private SensorManager sensorManager;
    private Sensor Accelerometer;
    private Sensor Gyroscope;
    private Sensor mMagneticField;

    //class initialize
    public MotionSensorManager(Context context){
        //get instance of the snesor manager and then access of the required sensors
        sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
        mMagneticField = sensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);
        Accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        Gyroscope = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE);
    }

    //link listener
    public void setOnMotionSensorManagerListener(OnMotionSensorManagerListener motionSensorManagerListener){
        this.motionSensorManagerListerner = motionSensorManagerListener;
    }

    public void unregisterMotionSensors(){
        sensorManager.unregisterListener(this);
    }

    //set listener with sensor manager
    public void registerMotionSensors(){
        sensorManager.registerListener(this,mMagneticField, SensorManager.SENSOR_DELAY_NORMAL);
        sensorManager.registerListener(this,Accelerometer,SensorManager.SENSOR_DELAY_NORMAL);
        sensorManager.registerListener(this,Gyroscope,SensorManager.SENSOR_DELAY_NORMAL);
    }

    //height value
    private double h;
    //coefficient of low pass filter
    final float alpha =(float) 0.8;
    private float gravity [] = new float[3];
    @Override
    public void onSensorChanged(SensorEvent event) {
        //be called when sensors are being updated
        switch (event.sensor.getType()){
            case Sensor.TYPE_ACCELEROMETER:
                gravity[0] = alpha * gravity[0] + (1-alpha) * event.values[0];
                gravity[1] = alpha * gravity[1] + (1-alpha) * event.values[1];
                gravity[2] = alpha * gravity[2] + (1-alpha) * event.values[2];

                float linear_acceleration [] = new float[3];
                linear_acceleration[0] = event.values[0] - gravity[0];
                linear_acceleration[1] = event.values[1] - gravity[1];
                linear_acceleration[2] = event.values[2] - gravity[2];

                //[acc_x,acc_y,acc_z]
                motionSensorManagerListerner.onAccValueUpdated(new float[]{linear_acceleration[0],linear_acceleration[1],linear_acceleration[2]});
                break;

            case Sensor.TYPE_GYROSCOPE:
                //[gyr_z,gyr_y,gyr_z]
                motionSensorManagerListerner.onGyoValueUpdated(new float[]{event.values[0],event.values[1],event.values[2]});
                break;

            case Sensor.TYPE_MAGNETIC_FIELD:
                h = Math.sqrt(event.values[0] * event.values[0] + event.values[1] * event.values[1] + event.values[2] * event.values[2]);
                //[mag_x,mag_y,mag_z,mag_h]
                motionSensorManagerListerner.onMagValueUpdated(new float[]{event.values[0],event.values[1],event.values[2],(float) h});
                break;
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }

    //interface the function to other class
    public interface OnMotionSensorManagerListener {

        void onAccValueUpdated(float[] acceleration);

        void onGyoValueUpdated(float[] gyroscope);

        void onMagValueUpdated(float[] magneticfield);
    }
}
```

## Result


## activity_main.xml
``` Bash
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <TextView
        android:id="@+id/textView"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="16dp"
        android:text="EMF"
        android:textSize="34sp"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

    <TextView
        android:id="@+id/mag_x"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="mag_x"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/textView" />

    <TextView
        android:id="@+id/mag_y"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="mag_y"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/mag_x" />

    <TextView
        android:id="@+id/mag_z"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="mag_z"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/mag_y" />

    <TextView
        android:id="@+id/mag_h"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="mag_h"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/mag_z" />

    <TextView
        android:id="@+id/textView6"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="24dp"
        android:text="Accelerometer"
        android:textSize="34sp"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/mag_h" />

    <TextView
        android:id="@+id/acc_x"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="acc_x"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/textView6" />

    <TextView
        android:id="@+id/acc_y"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="acc_y"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/acc_x" />

    <TextView
        android:id="@+id/acc_z"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="acc_z"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/acc_y" />

    <TextView
        android:id="@+id/textView10"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="24dp"
        android:text="Gyroscope"
        android:textSize="34sp"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/acc_z" />

    <TextView
        android:id="@+id/gyr_x"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="gyr_x"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/textView10" />

    <TextView
        android:id="@+id/gyr_y"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="gyr_y"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/gyr_x" />

    <TextView
        android:id="@+id/gyr_z"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="24dp"
        android:layout_marginTop="12dp"
        android:text="gyr_z"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/gyr_y" />
</androidx.constraintlayout.widget.ConstraintLayout>
```

## Result
![603.png](603.png)