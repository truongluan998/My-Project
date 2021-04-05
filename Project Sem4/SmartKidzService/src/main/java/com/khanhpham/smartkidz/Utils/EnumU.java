package com.khanhpham.smartkidz.Utils;

import java.io.Serializable;

public class EnumU implements Serializable {
    /**
     *
     */
    private static final long serialVersionUID = 2989250202472226703L;

    public enum Gender {

        male(true), female(false);

        public boolean value;

        private Gender(boolean value) {
            this.value = value;
        }

        public static Gender find(boolean value) {
            return value ? Gender.male : Gender.female;
        }
    }

    public enum Status {

        active(true), inactive(false);

        public boolean value;

        private Status(boolean value) {
            this.value = value;
        }

        public static Status find(boolean value) {
            return value ? Status.active : Status.inactive;
        }
    }

    public enum Role {

        admin(true), user(false);

        public boolean value;

        private Role(boolean value) {
            this.value = value;
        }

        public static Role find(boolean value) {
            return value ? Role.admin : Role.user;
        }
    }
}
