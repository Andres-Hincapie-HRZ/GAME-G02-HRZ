package com.go2super.resources.data.meta;

import com.go2super.database.entity.User;
import com.go2super.database.entity.sub.UserBuildings;
import com.go2super.resources.JsonData;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BuildIfMeta extends JsonData {

    private String type;

    private int id;
    private int lv;
    private int add;

}
