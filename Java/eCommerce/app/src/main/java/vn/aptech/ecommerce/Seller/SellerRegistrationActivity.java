package vn.aptech.ecommerce.Seller;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.HashMap;

import vn.aptech.ecommerce.R;

public class SellerRegistrationActivity extends AppCompatActivity {

    private Button sellerLoginBegin;
    private EditText nameInput, phoneInput, emailInput, passInput, addressInput;
    private Button registerBtn;
    private FirebaseAuth mAuth;
    private ProgressDialog loadingBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_seller_registration);

        mAuth = FirebaseAuth.getInstance();
        loadingBar = new ProgressDialog(this);

        initialize();

        sellerLoginBegin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(SellerRegistrationActivity.this, SellerLoginActivity.class));
            }
        });

        registerBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                registerSeller();
            }
        });
    }

    private void registerSeller() {
        final String name = nameInput.getText().toString();
        final String phone = phoneInput.getText().toString();
        final String email = emailInput.getText().toString();
        String password = passInput.getText().toString();
        final String address = addressInput.getText().toString();

        if (!name.equals("") && !phone.equals("") && !email.equals("") && !password.equals("") && !address.equals("")){

            loadingBar.setTitle("Create Seller account");
            loadingBar.setMessage("Please wait, while we are check the credentials.");
            loadingBar.setCanceledOnTouchOutside(false);
            loadingBar.show();

            mAuth.createUserWithEmailAndPassword(email, password)
                    .addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                        @Override
                        public void onComplete(@NonNull Task<AuthResult> task) {
                            if (task.isSuccessful()) {
                                final DatabaseReference rootRef;
                                rootRef = FirebaseDatabase.getInstance().getReference();

                                String sid = mAuth.getCurrentUser().getUid();

                                HashMap<String, Object> sellerMap = new HashMap<>();
                                sellerMap.put("sid", sid);
                                sellerMap.put("phone", phone);
                                sellerMap.put("email", email);
                                sellerMap.put("address", address);
                                sellerMap.put("name", name);

                                rootRef.child("Sellers").child(sid).updateChildren(sellerMap)
                                        .addOnCompleteListener(new OnCompleteListener<Void>() {
                                            @Override
                                            public void onComplete(@NonNull Task<Void> task) {
                                                loadingBar.dismiss();
                                                Toast.makeText(SellerRegistrationActivity.this, "You are register successfully", Toast.LENGTH_SHORT).show();
                                                startActivity(new Intent(SellerRegistrationActivity.this, SellerHomeActivity.class));
                                            }
                                        });
                            }
                        }
                    });
        }
        else {
            Toast.makeText(this, "Please complete the register form.", Toast.LENGTH_SHORT).show();
        }
    }

    private void initialize() {
        sellerLoginBegin = findViewById(R.id.seller_already_have_account_btn);
        nameInput = findViewById(R.id.seller_name);
        phoneInput = findViewById(R.id.seller_phone);
        emailInput = findViewById(R.id.seller_email);
        passInput = findViewById(R.id.seller_password);
        addressInput = findViewById(R.id.seller_address);
        registerBtn = findViewById(R.id.seller_register_btn);
    }
}