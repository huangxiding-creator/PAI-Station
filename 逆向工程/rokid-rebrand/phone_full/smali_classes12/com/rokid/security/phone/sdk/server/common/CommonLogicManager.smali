.class public final Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;
.super Ljava/lang/Object;
.source "CommonLogicManager.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0007*\u0001\u0006\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0008\u001a\u00020\tJ\u0010\u0010\n\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\u0004H\u0002J\u0006\u0010\u000c\u001a\u00020\tJ\u0006\u0010\r\u001a\u00020\tJ\u0006\u0010\u000e\u001a\u00020\tJ\u0006\u0010\u000f\u001a\u00020\tR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0007\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;",
        "",
        "()V",
        "TAG",
        "",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/common/CommonLogicManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager$mInterMessageListener$1;",
        "init",
        "",
        "parseMessage",
        "msg",
        "release",
        "sendAppInfo",
        "sendUserInfo",
        "syncSystemTime",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

.field private static final TAG:Ljava/lang/String; = "CommonLogicManager"

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager$mInterMessageListener$1;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    .line 25
    new-instance v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager$mInterMessageListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;
    .param p1, "msg"    # Ljava/lang/String;

    .line 22
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 6
    .param p1, "msg"    # Ljava/lang/String;

    .line 37
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "COMMON_ACTION"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 38
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 39
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 40
    const-string v1, "extra"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 41
    .local v1, "extraJson":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    if-eqz v2, :cond_0

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    const/4 v5, 0x1

    :cond_1
    if-nez v5, :cond_2

    .line 42
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 43
    .local v2, "extraJsonObject":Lorg/json/JSONObject;
    const-string v3, "extraType"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 44
    .local v3, "extraType":Ljava/lang/String;
    nop

    .line 50
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "extraJson":Ljava/lang/String;
    .end local v2    # "extraJsonObject":Lorg/json/JSONObject;
    .end local v3    # "extraType":Ljava/lang/String;
    :cond_2
    return-void
.end method


# virtual methods
.method public final init()V
    .locals 2

    .line 53
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 54
    return-void
.end method

.method public final release()V
    .locals 2

    .line 118
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 119
    return-void
.end method

.method public final sendAppInfo()V
    .locals 14

    .line 91
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->snapshot()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    move-result-object v0

    .line 92
    .local v0, "envInfo":Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;->getEnvType()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_1

    :cond_0
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getEnvType()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_1

    const-string v1, ""

    .line 93
    .local v1, "envType":Ljava/lang/String;
    :cond_1
    sget-object v2, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getClientIds()Ljava/util/ArrayList;

    move-result-object v2

    if-nez v2, :cond_2

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 94
    .local v2, "clientIds":Ljava/util/ArrayList;
    :cond_2
    new-instance v3, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;

    invoke-direct {v3}, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;-><init>()V

    move-object v4, v3

    .local v4, "$this$sendAppInfo_u24lambda_u242":Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;
    const/4 v5, 0x0

    .line 95
    .local v5, "$i$a$-apply-CommonLogicManager$sendAppInfo$extra$1":I
    const-string v6, "SYNC_COMPANION_APP_INFO"

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->setMethodName(Ljava/lang/String;)V

    .line 96
    new-instance v6, Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;

    .line 97
    nop

    .line 98
    nop

    .line 99
    nop

    .line 96
    invoke-direct {v6, v1, v2, v0}, Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;-><init>(Ljava/lang/String;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/EnvInfo;)V

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;->setCompanionAppInfo(Lcom/rokid/security/sdk/base/common/outside/CompanionAppInfo;)V

    .line 101
    nop

    .line 94
    .end local v4    # "$this$sendAppInfo_u24lambda_u242":Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;
    .end local v5    # "$i$a$-apply-CommonLogicManager$sendAppInfo$extra$1":I
    nop

    .line 102
    .local v3, "extra":Lcom/rokid/security/sdk/base/common/SyncCompanionAppInfoExtra;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    invoke-virtual {v4, v3}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 103
    .local v4, "extraJson":Ljava/lang/String;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v6, "extraJson"

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v11, 0x1c

    const/4 v12, 0x0

    const-string v6, "COMMON_ACTION"

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object v7, v4

    invoke-static/range {v5 .. v12}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 106
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    move-object v6, v5

    .local v6, "$this$sendAppInfo_u24lambda_u244":Lorg/json/JSONObject;
    const/4 v7, 0x0

    .line 107
    .local v7, "$i$a$-apply-CommonLogicManager$sendAppInfo$legacyExtra$1":I
    const-string v8, "extraType"

    const-string v9, "SYNC_PhoneAppInfo"

    invoke-virtual {v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 108
    const-string v8, "methodName"

    const-string v9, "SYNC_PHONE_APP_INFO"

    invoke-virtual {v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 109
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8}, Lorg/json/JSONObject;-><init>()V

    move-object v9, v8

    .local v9, "$this$sendAppInfo_u24lambda_u244_u24lambda_u243":Lorg/json/JSONObject;
    const/4 v10, 0x0

    .line 110
    .local v10, "$i$a$-apply-CommonLogicManager$sendAppInfo$legacyExtra$1$1":I
    const-string v11, "envType"

    invoke-virtual {v9, v11, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 111
    new-instance v11, Lorg/json/JSONArray;

    move-object v12, v2

    check-cast v12, Ljava/util/Collection;

    invoke-direct {v11, v12}, Lorg/json/JSONArray;-><init>(Ljava/util/Collection;)V

    const-string v12, "clientIds"

    invoke-virtual {v9, v12, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 112
    nop

    .end local v9    # "$this$sendAppInfo_u24lambda_u244_u24lambda_u243":Lorg/json/JSONObject;
    .end local v10    # "$i$a$-apply-CommonLogicManager$sendAppInfo$legacyExtra$1$1":I
    sget-object v9, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 109
    const-string v9, "phoneAppInfo"

    invoke-virtual {v6, v9, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 113
    nop

    .line 106
    .end local v6    # "$this$sendAppInfo_u24lambda_u244":Lorg/json/JSONObject;
    .end local v7    # "$i$a$-apply-CommonLogicManager$sendAppInfo$legacyExtra$1":I
    nop

    .line 114
    .local v5, "legacyExtra":Lorg/json/JSONObject;
    sget-object v6, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v8

    const-string v7, "legacyExtra.toString()"

    invoke-static {v8, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v12, 0x1c

    const/4 v13, 0x0

    const-string v7, "COMMON_ACTION"

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-static/range {v6 .. v13}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 115
    return-void
.end method

.method public final sendUserInfo()V
    .locals 11

    .line 74
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v0

    .line 75
    .local v0, "userInfo":Lcom/rokid/security/sdk/base/common/outside/UserInfo;
    if-eqz v0, :cond_4

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getUserName()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_1

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    move v1, v2

    goto :goto_1

    :cond_1
    :goto_0
    move v1, v3

    :goto_1
    if-nez v1, :cond_4

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getId()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    if-eqz v1, :cond_2

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_3

    :cond_2
    move v2, v3

    :cond_3
    if-nez v2, :cond_4

    .line 76
    new-instance v1, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendUserInfo_u24lambda_u241":Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;
    const/4 v3, 0x0

    .line 77
    .local v3, "$i$a$-apply-CommonLogicManager$sendUserInfo$extra$1":I
    const-string v4, "SYNC_USERINFO"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->setMethodName(Ljava/lang/String;)V

    .line 78
    invoke-virtual {v2, v0}, Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;->setUserInfo(Lcom/rokid/security/sdk/base/common/outside/UserInfo;)V

    .line 79
    nop

    .line 76
    .end local v2    # "$this$sendUserInfo_u24lambda_u241":Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;
    .end local v3    # "$i$a$-apply-CommonLogicManager$sendUserInfo$extra$1":I
    nop

    .line 80
    .local v1, "extra":Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 81
    .local v2, "extraJson":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v4, "extraJson"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const-string v4, "COMMON_ACTION"

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v5, v2

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .end local v1    # "extra":Lcom/rokid/security/sdk/base/common/SyncUserInfoExtra;
    .end local v2    # "extraJson":Ljava/lang/String;
    goto :goto_2

    .line 83
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "sendUserInfo userInfo = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "CommonLogicManager"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 85
    :goto_2
    return-void
.end method

.method public final syncSystemTime()V
    .locals 12

    .line 60
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 61
    .local v0, "time":J
    new-instance v2, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;

    invoke-direct {v2}, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;-><init>()V

    move-object v3, v2

    .local v3, "$this$syncSystemTime_u24lambda_u240":Lcom/rokid/security/sdk/base/common/SyncTimeExtra;
    const/4 v4, 0x0

    .line 62
    .local v4, "$i$a$-apply-CommonLogicManager$syncSystemTime$extra$1":I
    const-string v5, "SYNC_TIME"

    invoke-virtual {v3, v5}, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->setMethodName(Ljava/lang/String;)V

    .line 63
    invoke-virtual {v3, v0, v1}, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->setTime(J)V

    .line 64
    nop

    .line 61
    .end local v3    # "$this$syncSystemTime_u24lambda_u240":Lcom/rokid/security/sdk/base/common/SyncTimeExtra;
    .end local v4    # "$i$a$-apply-CommonLogicManager$syncSystemTime$extra$1":I
    nop

    .line 65
    .local v2, "extra":Lcom/rokid/security/sdk/base/common/SyncTimeExtra;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    invoke-virtual {v3, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 66
    .local v3, "extraJson":Ljava/lang/String;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v5, "extraJson"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v10, 0x1c

    const/4 v11, 0x0

    const-string v5, "COMMON_ACTION"

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v6, v3

    invoke-static/range {v4 .. v11}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 67
    return-void
.end method
