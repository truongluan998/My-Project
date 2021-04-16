package eu.tutorials.projectmanage.models

import android.os.Parcel
import android.os.Parcelable

data class SelectedMembers (
    val id: String = "",
    val image: String = ""
): Parcelable{
    constructor(source: Parcel) : this(
        source.readString()!!,
        source.readString()!!
    )

    override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
        writeString(id)
        writeString(image)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object {
        @JvmField
        val CREATOR: Parcelable.Creator<SelectedMembers> =
            object : Parcelable.Creator<SelectedMembers> {
                override fun createFromParcel(source: Parcel): SelectedMembers =
                    SelectedMembers(source)

                override fun newArray(size: Int): Array<SelectedMembers?> = arrayOfNulls(size)
            }
    }
}
