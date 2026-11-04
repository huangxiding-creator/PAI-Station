.class public final Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;
.super Ljava/lang/Object;
.source "ARMixControl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/wifip2p/api/IARMixControl;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000A\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0010\u0002\n\u0000\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\t*\u0001\u000b\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002Jc\u0010\u000e\u001a\u00020\t2!\u0010\u000f\u001a\u001d\u0012\u0013\u0012\u00110\u0008\u00a2\u0006\u000c\u0008\u0010\u0012\u0008\u0008\u0011\u0012\u0004\u0008\u0008(\u0012\u0012\u0004\u0012\u00020\t0\u000726\u0010\u0013\u001a2\u0012\u0013\u0012\u00110\u0004\u00a2\u0006\u000c\u0008\u0010\u0012\u0008\u0008\u0011\u0012\u0004\u0008\u0008(\u0015\u0012\u0013\u0012\u00110\u0016\u00a2\u0006\u000c\u0008\u0010\u0012\u0008\u0008\u0011\u0012\u0004\u0008\u0008(\u0017\u0012\u0004\u0012\u00020\t0\u0014H\u0016J\u0006\u0010\u0018\u001a\u00020\tJ\u0010\u0010\u0019\u001a\u00020\t2\u0006\u0010\u001a\u001a\u00020\u0004H\u0002J\u0006\u0010\u001b\u001a\u00020\tJ3\u0010\u001c\u001a\u00020\t2\u0006\u0010\u001d\u001a\u00020\u00082!\u0010\u000f\u001a\u001d\u0012\u0013\u0012\u00110\u0008\u00a2\u0006\u000c\u0008\u0010\u0012\u0008\u0008\u0011\u0012\u0004\u0008\u0008(\u001e\u0012\u0004\u0012\u00020\t0\u0007H\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\"\u0010\u0005\u001a\u0016\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u0008\u0012\u0004\u0012\u00020\t0\u0007\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u00020\u000bX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u000cR\"\u0010\r\u001a\u0016\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u0008\u0012\u0004\u0012\u00020\t0\u0007\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/api/IARMixControl;",
        "()V",
        "TAG",
        "",
        "getStateRef",
        "Ljava/lang/ref/WeakReference;",
        "Lkotlin/Function1;",
        "",
        "",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/wifip2p/ARMixControl$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl$mInterMessageListener$1;",
        "setStateRef",
        "getARMixState",
        "action",
        "Lkotlin/ParameterName;",
        "name",
        "isOpen",
        "onFail",
        "Lkotlin/Function2;",
        "errMsg",
        "",
        "code",
        "init",
        "parseMessage",
        "msg",
        "release",
        "setARMixEnabled",
        "enable",
        "isSuccess",
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


# instance fields
.field private final TAG:Ljava/lang/String;

.field private getStateRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;>;"
        }
    .end annotation
.end field

.field private final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl$mInterMessageListener$1;

.field private setStateRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const-string v0, "ARMixControl"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    .line 29
    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl$mInterMessageListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl$mInterMessageListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl$mInterMessageListener$1;

    .line 22
    return-void
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;
    .param p1, "msg"    # Ljava/lang/String;

    .line 22
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 7
    .param p1, "msg"    # Ljava/lang/String;

    .line 40
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "ARMixControl"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 41
    :cond_0
    nop

    .line 42
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 43
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    return-void

    .line 44
    :cond_1
    const-string v1, "extra"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 45
    .local v1, "extraJson":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    if-eqz v2, :cond_2

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_3

    :cond_2
    const/4 v5, 0x1

    :cond_3
    if-eqz v5, :cond_4

    return-void

    .line 47
    :cond_4
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 48
    .local v2, "extraJsonObject":Lorg/json/JSONObject;
    const-string v3, "methodName"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 49
    const-string v4, "Set_AR_Mix_Response"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 50
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    const-class v4, Lcom/rokid/security/sdk/base/common/SetARMixResponseExtra;

    invoke-virtual {v3, v1, v4}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/SetARMixResponseExtra;

    .line 51
    .local v3, "extra":Lcom/rokid/security/sdk/base/common/SetARMixResponseExtra;
    if-eqz v3, :cond_6

    .line 52
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "SET_AR_MIX_RESPONSE: isSuccess="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/SetARMixResponseExtra;->isSuccess()Z

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 53
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->setStateRef:Ljava/lang/ref/WeakReference;

    if-eqz v4, :cond_6

    invoke-virtual {v4}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lkotlin/jvm/functions/Function1;

    if-eqz v4, :cond_6

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/SetARMixResponseExtra;->isSuccess()Z

    move-result v5

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    invoke-interface {v4, v5}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 56
    .end local v3    # "extra":Lcom/rokid/security/sdk/base/common/SetARMixResponseExtra;
    :cond_5
    const-string v4, "Get_AR_Mix_State_Response"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 57
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    const-class v4, Lcom/rokid/security/sdk/base/common/GetARMixStateResponseExtra;

    invoke-virtual {v3, v1, v4}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/GetARMixStateResponseExtra;

    .line 58
    .local v3, "extra":Lcom/rokid/security/sdk/base/common/GetARMixStateResponseExtra;
    if-eqz v3, :cond_6

    .line 59
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "GET_AR_MIX_STATE_RESPONSE: isOpen="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/GetARMixStateResponseExtra;->isOpen()Z

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 60
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->getStateRef:Ljava/lang/ref/WeakReference;

    if-eqz v4, :cond_6

    invoke-virtual {v4}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lkotlin/jvm/functions/Function1;

    if-eqz v4, :cond_6

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/GetARMixStateResponseExtra;->isOpen()Z

    move-result v5

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    invoke-interface {v4, v5}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 64
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "extraJson":Ljava/lang/String;
    .end local v2    # "extraJsonObject":Lorg/json/JSONObject;
    .end local v3    # "extra":Lcom/rokid/security/sdk/base/common/GetARMixStateResponseExtra;
    :catch_0
    move-exception v0

    .line 65
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "parseMessage error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 67
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_6
    :goto_0
    return-void
.end method


# virtual methods
.method public getARMixState(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;)V
    .locals 9
    .param p1, "action"    # Lkotlin/jvm/functions/Function1;
    .param p2, "onFail"    # Lkotlin/jvm/functions/Function2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/String;",
            "-",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onFail"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 93
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    const-string v1, "getARMixState"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 94
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isConnected()Z

    move-result v0

    if-nez v0, :cond_0

    .line 95
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    const-string v1, "getARMixState: BT not connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 96
    const/4 v0, -0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string/jumbo v1, "\u84dd\u7259\u672a\u8fde\u63a5"

    invoke-interface {p2, v1, v0}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 97
    return-void

    .line 99
    :cond_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->getStateRef:Ljava/lang/ref/WeakReference;

    .line 100
    nop

    .line 101
    :try_start_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/sdk/base/common/GetARMixStateRequestExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/GetARMixStateRequestExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$getARMixState_u24lambda_u241":Lcom/rokid/security/sdk/base/common/GetARMixStateRequestExtra;
    const/4 v3, 0x0

    .line 102
    .local v3, "$i$a$-apply-ARMixControl$getARMixState$extra$1":I
    const-string v4, "Get_AR_Mix_State_Request"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/GetARMixStateRequestExtra;->setMethodName(Ljava/lang/String;)V

    .line 103
    nop

    .line 101
    .end local v2    # "$this$getARMixState_u24lambda_u241":Lcom/rokid/security/sdk/base/common/GetARMixStateRequestExtra;
    .end local v3    # "$i$a$-apply-ARMixControl$getARMixState$extra$1":I
    invoke-virtual {v0, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 104
    .local v0, "extra":Ljava/lang/String;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v2, "ARMixControl"

    const-string v3, "extra"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v7, 0x1c

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v3, v0

    invoke-static/range {v1 .. v8}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 105
    :catch_0
    move-exception v0

    .line 106
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendGetARMixStateMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 108
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public final init()V
    .locals 2

    .line 70
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 71
    return-void
.end method

.method public final release()V
    .locals 2

    .line 111
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->getStateRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->clear()V

    .line 112
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->setStateRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->clear()V

    .line 113
    :cond_1
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 114
    return-void
.end method

.method public setARMixEnabled(ZLkotlin/jvm/functions/Function1;)V
    .locals 9
    .param p1, "enable"    # Z
    .param p2, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 74
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "setARMixEnabled: enable="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 75
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isConnected()Z

    move-result v0

    if-nez v0, :cond_0

    .line 76
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "setARMixEnabled: BT not connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 77
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-interface {p2, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 78
    return-void

    .line 80
    :cond_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->setStateRef:Ljava/lang/ref/WeakReference;

    .line 81
    nop

    .line 82
    :try_start_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/sdk/base/common/SetARMixRequestExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/SetARMixRequestExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$setARMixEnabled_u24lambda_u240":Lcom/rokid/security/sdk/base/common/SetARMixRequestExtra;
    const/4 v3, 0x0

    .line 83
    .local v3, "$i$a$-apply-ARMixControl$setARMixEnabled$extra$1":I
    const-string v4, "Set_AR_Mix_Request"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/SetARMixRequestExtra;->setMethodName(Ljava/lang/String;)V

    .line 84
    invoke-virtual {v2, p1}, Lcom/rokid/security/sdk/base/common/SetARMixRequestExtra;->setOpen(Z)V

    .line 85
    nop

    .line 82
    .end local v2    # "$this$setARMixEnabled_u24lambda_u240":Lcom/rokid/security/sdk/base/common/SetARMixRequestExtra;
    .end local v3    # "$i$a$-apply-ARMixControl$setARMixEnabled$extra$1":I
    invoke-virtual {v0, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 86
    .local v0, "extra":Ljava/lang/String;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v2, "ARMixControl"

    const-string v3, "extra"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v7, 0x1c

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v3, v0

    invoke-static/range {v1 .. v8}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 87
    :catch_0
    move-exception v0

    .line 88
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendSetARMixMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 90
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method
