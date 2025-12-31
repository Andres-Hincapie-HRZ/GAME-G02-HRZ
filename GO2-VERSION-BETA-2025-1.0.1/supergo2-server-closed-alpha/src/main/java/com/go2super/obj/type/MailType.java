package com.go2super.obj.type;

import lombok.Getter;

public enum MailType {

    BOUGHT(0),
    SOLD(1),

    ;

    @Getter
    private int titleType;

    MailType(int titleType) {
        this.titleType = titleType;
    }

}
