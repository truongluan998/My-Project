package vn.aptech.materialdesign;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatButton;

import android.app.ActivityOptions;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Pair;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.google.firebase.database.ValueEventListener;

import vn.aptech.materialdesign.Model.UserHelperClass;

public class LoginActivity extends AppCompatActivity {

    private AppCompatButton btnSignUp, btnLogin;
    private ImageView imageView;
    private TextView logoText, sloganText;
    private TextInputLayout username, password;
    private ProgressDialog loadingBar;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_login);

        initialize();

        loadingBar = new ProgressDialog(this, R.style.AppCompatAlertDialogStyle);


//        btnLogin.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//               loginUser();
//            }
//        });

        btnSignUp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(LoginActivity.this, SignUpActivity.class);

                Pair[] pairs = new Pair[7];

                pairs[0] = new Pair<View, String>(imageView, "logo_image");
                pairs[1] = new Pair<View, String>(logoText, "logo_text");
                pairs[2] = new Pair<View, String>(sloganText, "slogan_text");
                pairs[3] = new Pair<View, String>(username, "username_tran");
                pairs[4] = new Pair<View, String>(password, "password_tran");
                pairs[5] = new Pair<View, String>(btnLogin, "button_go_tran");
                pairs[6] = new Pair<View, String>(btnSignUp, "button_signup_tran");


                ActivityOptions options = ActivityOptions.makeSceneTransitionAnimation(LoginActivity.this, pairs);
                startActivity(intent, options.toBundle());

            }
        });

    }

    private Boolean validateUsername() {
        String val = username.getEditText().getText().toString();

        if (val.isEmpty()) {
            username.setError("Field cannot be empty");
            return false;
        } else {
            username.setError(null);
            username.setErrorEnabled(false);
            return true;
        }
    }

    private Boolean validatePassword() {
        String val = password.getEditText().getText().toString();
        if (val.isEmpty()) {
            password.setError("Field cannot be empty");
            return false;
        } else {
            password.setError(null);
            password.setErrorEnabled(false);
            return true;
        }
    }

    public void loginUser(View view) {
        if (!validateUsername() | !validatePassword()) {
            return;
        } else {
            isUser();
        }
    }

    private void isUser() {

        loadingBar.setTitle("Login Account");
        loadingBar.setMessage("Please wait, while we are checking the credentials.");
        loadingBar.setCanceledOnTouchOutside(false);
        loadingBar.show();

        final String userEnteredUsername = username.getEditText().getText().toString().trim();
        final String userEnteredPassword = password.getEditText().getText().toString().trim();

        DatabaseReference reference = FirebaseDatabase.getInstance().getReference("users");

        Query checkUser = reference.orderByChild("username").equalTo(userEnteredUsername);
        checkUser.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot snapshot) {

               loadingBar.dismiss();

                if (snapshot.exists()) {

                    username.setError(null);
                    username.setErrorEnabled(false);

                    for (DataSnapshot user : snapshot.getChildren()) {

                        UserHelperClass usersBean = user.getValue(UserHelperClass.class);
                        String passwordFromDB = usersBean.getPassword();


                        if (passwordFromDB.equals(userEnteredPassword)) {

                            username.setError(null);
                            username.setErrorEnabled(false);

                            String nameFromDB = snapshot.child(userEnteredUsername).child("name").getValue(String.class);
                            String usernameFromDB = snapshot.child(userEnteredUsername).child("username").getValue(String.class);
                            String phoneFromDB = snapshot.child(userEnteredUsername).child("phoneNo").getValue(String.class);
                            String emailFromDB = snapshot.child(userEnteredUsername).child("email").getValue(String.class);

                            Intent intent = new Intent(getApplicationContext(), UserProfileActivity.class);

                            intent.putExtra("name", nameFromDB);
                            intent.putExtra("username", usernameFromDB);
                            intent.putExtra("phoneNo", phoneFromDB);
                            intent.putExtra("email", emailFromDB);
                            intent.putExtra("password", passwordFromDB);

                            startActivity(intent);
                        } else {
                            loadingBar.dismiss();
                            password.setError("Wrong Password");
                            password.requestFocus();
                        }
                    }
                } else {
                    loadingBar.dismiss();
                    username.setError("No such User exits");
                    username.requestFocus();
                }

            }

            @Override
            public void onCancelled(@NonNull DatabaseError error) {

            }
        });

    }


    private void initialize() {
        btnSignUp = findViewById(R.id.btn_sign_up);
        btnLogin = findViewById(R.id.btn_go_login);
        imageView = findViewById(R.id.logo_img);
        logoText = findViewById(R.id.logo_name);
        sloganText = findViewById(R.id.sologan_login);
        username = findViewById(R.id.username_login);
        password = findViewById(R.id.password_login);
    }
}