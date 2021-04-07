package eu.tutorials.projectmanage.models

import android.os.Parcel
import android.os.Parcelable

data class Board (
    val name: String = "",
    val image: String = "",
    val createBy: String = "",
    val assignedTo: ArrayList<String> = ArrayList(),
    var documentId: String = ""
):Parcelable {
    constructor(parcel: Parcel) : this(
        parcel.readString()!!,
        parcel.readString()!!,
        parcel.readString()!!,
        parcel.createStringArrayList()!!,
        parcel.readString()!!
    ) {
    }

    override fun describeContents(): Int {
        TODO("Not yet implemented")
    }

    override fun writeToParcel(parcel: Parcel, p1: Int) = with(parcel) {
        parcel.writeString(name)
        parcel.writeString(image)
        parcel.writeString(createBy)
        parcel.writeStringList(assignedTo)
        parcel.writeString(documentId)
    }

    companion object CREATOR : Parcelable.Creator<Board> {
        override fun createFromParcel(parcel: Parcel): Board {
            return Board(parcel)
        }

        override fun newArray(size: Int): Array<Board?> {
            return arrayOfNulls(size)
        }
    }
}