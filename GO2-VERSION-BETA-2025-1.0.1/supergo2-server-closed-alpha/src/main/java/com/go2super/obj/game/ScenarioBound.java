package com.go2super.obj.game;

import lombok.Builder;
import lombok.Data;
import lombok.ToString;

import java.util.Date;

@Data
@Builder
@ToString
public class ScenarioBound {

    private int maximumX;
    private int maximumY;

    private int minimumX;
    private int minimumY;

}
