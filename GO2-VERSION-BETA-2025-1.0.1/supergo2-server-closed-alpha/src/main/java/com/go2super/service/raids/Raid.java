package com.go2super.service.raids;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Raid {

    private RaidStatus status;

    private int firstGuid;
    private int secondGuid;

    private int firstPropId;
    private int secondPropId;

    private int time;

}
