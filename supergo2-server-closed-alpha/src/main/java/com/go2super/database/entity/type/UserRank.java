package com.go2super.database.entity.type;

import lombok.Getter;

public enum UserRank {

    ADMIN(0, 100, true, "*"),
    GM(1, 107, false, "permission.restart", "permission.broadcast", "permission.i.g.c", "permission.spy", "permission.warn", "permission.mute", "permission.ban", "permission.icon", "permission.staff", "permission.discord", "permission.block", "permission.blackList", "permission.hasblock", "permission.notdisturb", "permission.unban", "permission.sban", "permission.userinfo", "permission.changenickname"),

    MOD(2, 101, false, "permission.warn", "permission.mute", "permission.ban", "permission.icon", "permission.staff", "permission.discord", "permission.block", "permission.blackList", "permission.hasblock", "permission.notdisturb"),
    USER(3, -1, false, "permission.icon", "permission.discord", "permission.block", "permission.blackList", "permission.hasblock", "permission.notdisturb"),

    BATTLE_REVIEWER(4, 106, false, "permission.icon", "permission.discord", "permission.block", "permission.blackList", "permission.hasblock", "permission.notdisturb", "permission.get", "permission.add"),
    QA(5, 108, false, "permission.qa"),

    VIP(6, 102, false, "permission.icon", "permission.discord", "permission.block", "permission.blackList", "permission.hasblock", "permission.notdisturb", "permission.vip"),
    MVP(7, 104, false, "permission.icon", "permission.discord", "permission.block", "permission.blackList", "permission.hasblock", "permission.notdisturb", "permission.mvp"),

    ;

    @Getter private int id;
    @Getter private int prefix;
    @Getter private boolean admin;

    @Getter private String[] permissions;

    UserRank(int id, int prefix, boolean admin, String...permissions) {
        this.id = id;
        this.prefix = prefix;
        this.admin = admin;

        if(permissions == null) {

            this.permissions = new String[0];
            return;

        }

        this.permissions = permissions;

    }

    public boolean hasAnyPermission(String[] permissions) {
        for(String permission : permissions)
            if(hasPermission(permission))
                return true;
        return false;
    }

    public boolean hasPermission(String permission) {

        if(isAdmin()) return true;
        if(permission == null) return false;

        for(String rankPermission : permissions)
            if(rankPermission.equals(permission) || rankPermission.equals("*"))
                return true;

        return false;

    }

}
