package vn.aptech.ecommerce.Buyers;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.HashMap;

import vn.aptech.ecommerce.Prevalent.Prevalent;
import vn.aptech.ecommerce.R;

public class ResertPasswordActivity extends AppCompatActivity {

    private String check = "";
    private TextView pageTitle, titleQuestions;
    private Button verifyBtn;
    private EditText phoneNumber, question1, question2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_resert_password);

        check = getIntent().getStringExtra("check");

        initialize();
    }


    @Override
    protected void onStart() {
        super.onStart();
        phoneNumber.setVisibility(View.GONE);
        if (check.equals("settings"))
        {
            pageTitle.setText("Set Questions");
            titleQuestions.setText("Please set Answers for the Following Security Questions?");
            verifyBtn.setText("Set");

            displayPreviousAnswers();

            verifyBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    setAnswers();
                }
            });
        }
        else if (check.equals("login"))
        {
            phoneNumber.setVisibility(View.VISIBLE);

            verifyBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    verifyUser();
                }
            });

        }
    }

    private void setAnswers(){
        String answer1 = question1.getText().toString().toLowerCase();
        String answer2 = question2.getText().toString().toLowerCase();

        if (answer1.isEmpty() || answer2.equals("")) {
            Toast.makeText(ResertPasswordActivity.this, "Please answer both questions.", Toast.LENGTH_SHORT).show();
        }
        else {
            DatabaseReference ref = FirebaseDatabase.getInstance().getReference()
                    .child("Users")
                    .child(Prevalent.currentOnlineUser.getPhone());


            HashMap<String, Object> userdataMap = new HashMap<>();
            userdataMap.put("answer1", answer1);
            userdataMap.put("answer2", answer2);


            ref.child("Security Questions").updateChildren(userdataMap).addOnCompleteListener(new OnCompleteListener<Void>() {
                @Override
                public void onComplete(@NonNull Task<Void> task) {
                    if (task.isSuccessful()) {
                        Toast.makeText(ResertPasswordActivity.this, "You have set answer security questions successfully", Toast.LENGTH_SHORT).show();
                        startActivity(new Intent(ResertPasswordActivity.this, HomeActivity.class));
                    }
                }
            });
        }
    }

    private void displayPreviousAnswers() {
        DatabaseReference ref = FirebaseDatabase.getInstance().getReference()
                .child("Users")
                .child(Prevalent.currentOnlineUser.getPhone());


        ref.child("Security Questions").addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot snapshot) {
                if (snapshot.exists()) {
                    String ans1 = snapshot.child("answer1").getValue().toString();
                    String ans2 = snapshot.child("answer2").getValue().toString();

                    question1.setText(ans1);
                    question2.setText(ans2);
                }
            }

            @Override
            public void onCancelled(@NonNull DatabaseError error) {

            }
        });
    }

    private void verifyUser() {
        final String phone = phoneNumber.getText().toString();
        final String answer1 = question1.getText().toString().toLowerCase();
        final String answer2 = question2.getText().toString().toLowerCase();

        if (!phone.equals("") && !answer1.equals("") && !answer2.equals("")) {
            final DatabaseReference ref = FirebaseDatabase.getInstance().getReference()
                    .child("Users")
                    .child(phone);

            ref.addValueEventListener(new ValueEventListener() {
                @Override
                public void onDataChange(@NonNull DataSnapshot snapshot) {
                    if (snapshot.exists()) {
                        String mPhone = snapshot.child("phone").getValue().toString();

                        if (snapshot.hasChild("Security Questions")) {
                            String ans1 = snapshot.child("Security Questions").child("answer1").getValue().toString();
                            String ans2 = snapshot.child("Security Questions").child("answer2").getValue().toString();

                            if (!ans1.equals(answer1)) {
                                Toast.makeText(ResertPasswordActivity.this, "Your 1st answer is wrong.", Toast.LENGTH_SHORT).show();
                            }
                            else if (!ans2.equals(answer2)) {
                                Toast.makeText(ResertPasswordActivity.this, "Your 2st answer is wrong.", Toast.LENGTH_SHORT).show();
                            }
                            else {
                                AlertDialog.Builder builder = new AlertDialog.Builder(ResertPasswordActivity.this);
                                builder.setTitle("New Password");

                                final EditText newPassword = new EditText(ResertPasswordActivity.this);
                                newPassword.setHint("Write Password here...");
                                builder.setView(newPassword);

                                builder.setPositiveButton("Change", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        if (!newPassword.getText().toString().equals("")) {
                                            ref.child("password")
                                                    .setValue(newPassword.getText().toString())
                                                    .addOnCompleteListener(new OnCompleteListener<Void>() {
                                                        @Override
                                                        public void onComplete(@NonNull Task<Void> task) {
                                                            if (task.isSuccessful()) {
                                                                Toast.makeText(ResertPasswordActivity.this, "Password change successfully.", Toast.LENGTH_SHORT).show();
                                                                startActivity(new Intent(ResertPasswordActivity.this, HomeActivity.class));
                                                            }
                                                        }
                                                    });
                                        }
                                        else {
                                            Toast.makeText(ResertPasswordActivity.this, "Please enter new password", Toast.LENGTH_SHORT).show();
                                        }
                                    }
                                });
                                builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        dialogInterface.cancel();
                                    }
                                });
                                builder.show();
                            }
                        }
                        else {
                            Toast.makeText(ResertPasswordActivity.this, "you have not set the security questions.", Toast.LENGTH_SHORT).show();
                        }
                    }
                    else {
                        Toast.makeText(ResertPasswordActivity.this, "This phone number not exits.", Toast.LENGTH_SHORT).show();
                    }
                }

                @Override
                public void onCancelled(@NonNull DatabaseError error) {

                }
            });
        }
        else {
            Toast.makeText(this, "please complete the form.", Toast.LENGTH_SHORT).show();
        }
    }


    private void initialize() {
        pageTitle = findViewById(R.id.page_title);
        titleQuestions = findViewById(R.id.title_question);
        phoneNumber = findViewById(R.id.find_phone_number);
        verifyBtn = findViewById(R.id.verify_btn);
        question1 = findViewById(R.id.question_1);
        question2 = findViewById(R.id.question_2);
    }


}