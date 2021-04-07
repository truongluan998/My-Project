package eu.tutorials.projectmanage.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import eu.tutorials.projectmanage.R
import eu.tutorials.projectmanage.adapters.TaskListItemsAdapter
import eu.tutorials.projectmanage.firebase.FireStoreClass
import eu.tutorials.projectmanage.models.Board
import eu.tutorials.projectmanage.models.Task
import eu.tutorials.projectmanage.utils.Constants
import kotlinx.android.synthetic.main.activity_my_profile.*
import kotlinx.android.synthetic.main.activity_my_profile.toolbar_my_profile_activity
import kotlinx.android.synthetic.main.activity_task_lisk.*

class TaskListActivity : BaseActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_task_lisk)

        var boardDocumentId = ""
        if (intent.hasExtra(Constants.DOCUMENT_ID)) {
            boardDocumentId = intent.getStringExtra(Constants.DOCUMENT_ID).toString()
        }

        showProgressDialog(resources.getString(R.string.please_wait))
        FireStoreClass().getBoardDetails(this, boardDocumentId)
    }

    private fun setupActionBar(title: String) {

        setSupportActionBar(toolbar_task_list_activity)

        val actionBar = supportActionBar
        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(true)
            actionBar.setHomeAsUpIndicator(R.drawable.ic_white_back_24dp)
            actionBar.title = title
        }

        toolbar_task_list_activity.setNavigationOnClickListener { onBackPressed() }
    }

    fun boardDetails(board: Board) {
        hideProgressDialog()
        setupActionBar(board.name)

        val addTaskList = Task(resources.getString(R.string.add_list))
        board.taskList.add(addTaskList)

        rv_task_list.layoutManager = LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false)
        rv_task_list.setHasFixedSize(true)

        val adapter = TaskListItemsAdapter(this, board.taskList)
        rv_task_list.adapter = adapter
    }
}