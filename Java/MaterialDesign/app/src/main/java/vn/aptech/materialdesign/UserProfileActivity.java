package vn.aptech.materialdesign;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class UserProfileActivity extends AppCompatActivity {

    TextInputLayout fullName, email, phoneNo, password;
    TextView fullNameLabel, usernameLabel;

    String _USERNAME, _NAME, _EMAIL, _PHONENO, _PASSWORD;

    DatabaseReference reference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_user_profile);

        reference = FirebaseDatabase.getInstance().getReference("users");

        initialize();

        //show all data
        showAllUserData();

    }

    private void showAllUserData() {

        Intent intent = getIntent();
        _USERNAME = intent.getStringExtra("username");
        _NAME = intent.getStringExtra("name");
        _EMAIL = intent.getStringExtra("email");
        _PHONENO = intent.getStringExtra("phoneNo");
        _PASSWORD = intent.getStringExtra("password");

        fullNameLabel.setText(_NAME);
        usernameLabel.setText(_USERNAME);
        email.getEditText().setText(_EMAIL);
        fullName.getEditText().setText(_NAME);
        phoneNo.getEditText().setText(_PHONENO);
        password.getEditText().setText(_PASSWORD);

    }

    public void update(View view) {

        if (isNameChanged() && isPasswordChange()){
            Toast.makeText(this, "Data has been update", Toast.LENGTH_SHORT).show();
        }
        else if (isNameChanged() ) {
            Toast.makeText(this, "Data has been update", Toast.LENGTH_SHORT).show();
        } else if(isPasswordChange()) {
            Toast.makeText(this, "Data has been update", Toast.LENGTH_SHORT).show();
        }
        else {
            Toast.makeText(this, "Data is same and can not be updated", Toast.LENGTH_SHORT).show();
        }

    }

    private boolean isNameChanged() {

        if (!_NAME.equals(fullName.getEditText().getText().toString())) {
            reference.child(_USERNAME).child("name").setValue(fullName.getEditText().getText().toString());
            _NAME = fullName.getEditText().getText().toString();
            return true;
        } else {
            return false;
        }
    }

    private boolean isPasswordChange() {
        if (!_PASSWORD.equals(password.getEditText().getText().toString())) {
            reference.child(_USERNAME).child("password").setValue(password.getEditText().getText().toString());
            _PASSWORD = password.getEditText().getText().toString();
            return true;
        } else {
            return false;
        }
    }

    private void initialize() {
        fullName = findViewById(R.id.full_name_profile);
        email = findViewById(R.id.email_profile);
        phoneNo = findViewById(R.id.phone_no_profile);
        password = findViewById(R.id.password_profile);
        fullNameLabel = findViewById(R.id.full_name_field);
        usernameLabel = findViewById(R.id.username_field);
    }
}