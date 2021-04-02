package vn.aptech.materialdesign;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;

import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import vn.aptech.materialdesign.Model.UserHelperClass;

public class SignUpActivity extends AppCompatActivity {

    private TextInputLayout regName, regUsername, regEmail, regPhoneNo, regPassword;
    private Button regBtn, regToLoginBtn;

    private ProgressDialog loadingBar;

    private FirebaseDatabase rootNode;
    private DatabaseReference reference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_sign_up);

        initialize();

        loadingBar = new ProgressDialog(this, R.style.AppCompatAlertDialogStyle);

        rootNode = FirebaseDatabase.getInstance();
        reference = rootNode.getReference("users");


//        regBtn.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                registerUser();
//            }
//        });

    }

    private Boolean validateName() {
        String val = regName.getEditText().getText().toString();

        if (val.isEmpty()) {
            regName.setError("Field cannot be empty");
            return false;
        } else {
            regName.setError(null);
            regName.setEnabled(false);
            return true;
        }
    }

    private Boolean validateUsername() {
        String val = regUsername.getEditText().getText().toString();
        String noWhiteSpace = "\\A\\w{4,20}\\z";

        if (val.isEmpty()) {
            regUsername.setError("Field cannot be empty");
            return false;
        } else if (val.length() >= 15) {
            regUsername.setError("Username to long");
            return false;
        } else if (!val.matches(noWhiteSpace)) {
            regUsername.setError("White spaces are no allow");
            return false;
        } else {
            regUsername.setError(null);
            regUsername.setEnabled(false);
            return true;
        }
    }

    private Boolean validateEmail() {
        String val = regEmail.getEditText().getText().toString();
        String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";

        if (val.isEmpty()) {
            regEmail.setError("Field cannot be empty");
            return false;
        } else if (!val.matches(emailPattern)) {
            regEmail.setError("Invalid email address");
            return false;
        } else {
            regEmail.setError(null);
            regEmail.setEnabled(false);
            return true;
        }
    }

    private Boolean validatePhone() {
        String val = regPhoneNo.getEditText().getText().toString();

        if (val.isEmpty()) {
            regPhoneNo.setError("Field cannot be empty");
            return false;
        } else {
            regPhoneNo.setError(null);
            regPhoneNo.setEnabled(false);
            return true;
        }
    }

    private Boolean validatePassword() {
        String val = regPassword.getEditText().getText().toString();
        String passwordVal = "^" +
                //"(?=.*[0-9])" +         //at least 1 digit
                //"(?=.*[a-z])" +         //at least 1 lower case letter
                //"(?=.*[A-Z])" +         //at least 1 upper case letter
                "(?=.*[a-zA-Z])" +      //any letter
                "(?=.*[@#$%^&+=])" +    //at least 1 special character
                "(?=\\S+$)" +           //no white spaces
                ".{4,}" +               //at least 4 characters
                "$";

        if (val.isEmpty()) {
            regPassword.setError("Field cannot be empty");
            return false;
        } else if (!val.matches(passwordVal)) {
            regPassword.setError("Password is too weak");
            return false;
        } else {
            regPassword.setError(null);
            regPassword.setEnabled(false);
            return true;
        }
    }


    public void registerUser(View view) {

        loadingBar.setTitle("Create new Account");
        loadingBar.setMessage("Please wait...");
        loadingBar.setCanceledOnTouchOutside(false);
        loadingBar.show();

        if (!validateName() | !validatePassword() | !validatePhone() | !validateEmail() | !validateUsername()) {
            loadingBar.dismiss();
            return;

        } else {


//            String name = regName.getEditText().getText().toString();
//            String username = regUsername.getEditText().getText().toString();
//            String email = regEmail.getEditText().getText().toString();
            String phoneNo = regPhoneNo.getEditText().getText().toString();
//            String password = regPassword.getEditText().getText().toString();

            Intent intent = new Intent(getApplicationContext(), VerifyPhoneNoActivity.class);
            intent.putExtra("phoneNo", phoneNo);
            startActivity(intent);


//            UserHelperClass helperClass = new UserHelperClass(name, username, email, phone, password);
//            reference.child(username).setValue(helperClass);

            loadingBar.dismiss();
//            startActivity(new Intent(getApplicationContext(), LoginActivity.class));
//            finish();
        }

    }

    private void initialize() {
        regName = findViewById(R.id.reg_name);
        regUsername = findViewById(R.id.reg_username);
        regEmail = findViewById(R.id.reg_email);
        regPhoneNo = findViewById(R.id.reg_phone);
        regPassword = findViewById(R.id.reg_password);
        regBtn = findViewById(R.id.reg_btn);
        regToLoginBtn = findViewById(R.id.reg_to_login_btn);
    }
}