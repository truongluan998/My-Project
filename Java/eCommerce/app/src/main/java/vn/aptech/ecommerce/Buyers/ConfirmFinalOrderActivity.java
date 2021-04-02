package vn.aptech.ecommerce.Buyers;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

import vn.aptech.ecommerce.Prevalent.Prevalent;
import vn.aptech.ecommerce.R;

public class ConfirmFinalOrderActivity extends AppCompatActivity {

    private EditText nameEdtx, phoneEdtx, addressEdtx, cityEdtx;
    private Button confirmOrderBtn;

    private String totalAmount = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_confirm_final_order);

        totalAmount = getIntent().getStringExtra("Total Price");
        Toast.makeText(this, "Total Price = " + totalAmount +"$", Toast.LENGTH_LONG).show();

        initialize();

        confirmOrderBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Check();
            }
        });
    }

    private void Check() {
        if (TextUtils.isEmpty(nameEdtx.getText().toString())) {
            Toast.makeText(this, "Please provide your full name.", Toast.LENGTH_SHORT).show();
        }
        else if (TextUtils.isEmpty(phoneEdtx.getText().toString())) {
            Toast.makeText(this, "Please provide your phone number.", Toast.LENGTH_SHORT).show();
        }
        else if (TextUtils.isEmpty(addressEdtx.getText().toString())) {
            Toast.makeText(this, "Please provide your address.", Toast.LENGTH_SHORT).show();
        }
        else if (TextUtils.isEmpty(cityEdtx.getText().toString())) {
            Toast.makeText(this, "Please provide your city name.", Toast.LENGTH_SHORT).show();
        }
        else {
            ConfirmOrder();
        }
    }

    private void ConfirmOrder() {
        Calendar calFordate = Calendar.getInstance();
        SimpleDateFormat currentDate = new SimpleDateFormat("MM dd, yyyy");
        final String saveCurrentDate = currentDate.format(calFordate.getTime());

        SimpleDateFormat currentTime = new SimpleDateFormat("HH:mm:ss a");
        final String saveCurrentTime = currentTime.format(calFordate.getTime());

        final DatabaseReference ordersRef = FirebaseDatabase.getInstance().getReference()
                .child("Orders")
                .child(Prevalent.currentOnlineUser.getPhone());

        HashMap<String, Object> ordersMap = new HashMap<>();
        ordersMap.put("totalAmount", totalAmount);
        ordersMap.put("name", nameEdtx.getText().toString());
        ordersMap.put("phone", phoneEdtx.getText().toString());
        ordersMap.put("address", addressEdtx.getText().toString());
        ordersMap.put("date", saveCurrentDate);
        ordersMap.put("time", saveCurrentTime);
        ordersMap.put("city", cityEdtx.getText().toString());
        ordersMap.put("state", "not shipped");

        ordersRef.updateChildren(ordersMap).addOnCompleteListener(new OnCompleteListener<Void>() {
            @Override
            public void onComplete(@NonNull Task<Void> task) {
                if (task.isSuccessful()) {
                    FirebaseDatabase.getInstance().getReference().child("Cart List")
                            .child("User View")
                            .child(Prevalent.currentOnlineUser.getPhone())
                            .removeValue()
                            .addOnCompleteListener(new OnCompleteListener<Void>() {
                                @Override
                                public void onComplete(@NonNull Task<Void> task) {
                                    if (task.isSuccessful()) {
                                        Toast.makeText(ConfirmFinalOrderActivity.this, "Your final order has been placed successfully.", Toast.LENGTH_SHORT).show();
                                        Intent intent = new Intent(ConfirmFinalOrderActivity.this, HomeActivity.class);
                                        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
                                        startActivity(intent);
                                        finish();
                                    }
                                }
                            });
                }
            }
        });

    }

    private void initialize() {
        confirmOrderBtn = findViewById(R.id.confirm_final_order_btn);
        nameEdtx = findViewById(R.id.shipment_name);
        phoneEdtx = findViewById(R.id.shipment_phone_number);
        addressEdtx = findViewById(R.id.shipment_address);
        cityEdtx = findViewById(R.id.shipment_city);
    }


}