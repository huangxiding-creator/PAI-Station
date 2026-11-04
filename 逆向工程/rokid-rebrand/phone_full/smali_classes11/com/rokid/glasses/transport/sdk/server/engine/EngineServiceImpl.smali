.class public final Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;
.super Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;
.source "EngineServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nEngineServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 EngineServiceImpl.kt\ncom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl\n+ 2 IResult.kt\ncom/rokid/glasses/transport/sdk/api/callback/IResult$Companion\n*L\n1#1,153:1\n84#2:154\n84#2:155\n93#2:156\n*S KotlinDebug\n*F\n+ 1 EngineServiceImpl.kt\ncom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl\n*L\n38#1:154\n49#1:155\n139#1:156\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000n\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u0013\u001a\u00020\u0014H\u0016J\n\u0010\u0015\u001a\u0004\u0018\u00010\u0016H\u0016J\n\u0010\u0017\u001a\u0004\u0018\u00010\u0018H\u0016J\n\u0010\u0019\u001a\u0004\u0018\u00010\u001aH\u0016J\n\u0010\u001b\u001a\u0004\u0018\u00010\u001cH\u0016J\n\u0010\u001d\u001a\u0004\u0018\u00010\u001eH\u0016J\n\u0010\u001f\u001a\u0004\u0018\u00010 H\u0016J6\u0010!\u001a\u0008\u0012\u0004\u0012\u0002H#0\"\"\u0004\u0008\u0000\u0010#2\u0006\u0010$\u001a\u00020\u00082\u0008\u0010%\u001a\u0004\u0018\u00010&H\u0002\u00f8\u0001\u0000\u00f8\u0001\u0001\u00f8\u0001\u0002\u00a2\u0006\u0004\u0008\'\u0010(J\u0010\u0010)\u001a\u00020\u00142\u0006\u0010\u0003\u001a\u00020\u0004H\u0002JL\u0010*\u001a\u00020\u00142\u0006\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\r\u001a\u00020\u000e2\'\u0010+\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00040\"\u00a2\u0006\u000c\u0008-\u0012\u0008\u0008.\u0012\u0004\u0008\u0008(/\u0012\u0004\u0012\u00020\u00140,H\u0016\u00f8\u0001\u0002J\u0008\u0010\u0005\u001a\u00020\u0004H\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0007\u001a\u00020\u0008X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\t\u0010\n\"\u0004\u0008\u000b\u0010\u000cR\u001a\u0010\r\u001a\u00020\u000eX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000f\u0010\u0010\"\u0004\u0008\u0011\u0010\u0012\u0082\u0002\u000f\n\u0002\u0008!\n\u0005\u0008\u00a1\u001e0\u0001\n\u0002\u0008\u0019\u00a8\u00060"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;",
        "Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;",
        "()V",
        "isGroupOwner",
        "",
        "isInit",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "ownerId",
        "",
        "getOwnerId",
        "()Ljava/lang/String;",
        "setOwnerId",
        "(Ljava/lang/String;)V",
        "port",
        "",
        "getPort",
        "()I",
        "setPort",
        "(I)V",
        "destroy",
        "",
        "getAbsBleClientService",
        "Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;",
        "getAbsBleService",
        "Lcom/rokid/glasses/transport/sdk/api/ble/server/api/AbsBleService;",
        "getAbsClassicBlueClientService",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;",
        "getAbsClassicBlueService",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/AbsClassicBlueToothServer;",
        "getAbsWifiP2PClientService",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;",
        "getAbsWifiP2PGoService",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/AbsWifiP2PGoService;",
        "getIFailResult",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult;",
        "T",
        "msg",
        "e",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
        "getIFailResult-Guu2Vc4",
        "(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;",
        "initRKLogger",
        "initSDK",
        "onResult",
        "Lkotlin/Function1;",
        "Lkotlin/ParameterName;",
        "name",
        "result",
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
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;

.field private static isGroupOwner:Z

.field private static isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static ownerId:Ljava/lang/String;

.field private static port:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;

    .line 26
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 29
    const-string v0, ""

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->ownerId:Ljava/lang/String;

    .line 30
    const/16 v0, 0x2ee1

    sput v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->port:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;-><init>()V

    return-void
.end method

.method private final getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;
    .locals 9
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "e"    # Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 137
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->getCode()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_0

    :cond_0
    move-object v2, v1

    :goto_0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ", "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    if-eqz p2, :cond_1

    invoke-virtual {p2}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->getMessage()Ljava/lang/String;

    move-result-object v1

    :cond_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 136
    nop

    .line 138
    .local v0, "erroeMsg":Ljava/lang/String;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 139
    sget-object v7, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    new-instance v8, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    if-eqz p2, :cond_2

    invoke-virtual {p2}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->getCode()I

    move-result v1

    goto :goto_1

    :cond_2
    const/4 v1, -0x1

    :goto_1
    move v2, v1

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v4, 0x0

    move-object v1, v8

    move-object v3, v0

    invoke-direct/range {v1 .. v6}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v1, "exception$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    move-object v2, v7

    .local v2, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    const/4 v3, 0x0

    .line 156
    .local v3, "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->createFailure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 139
    .end local v1    # "exception$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v2    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v3    # "$i$f$failure":I
    return-object v1
.end method

.method private final initRKLogger(Z)V
    .locals 6
    .param p1, "isGroupOwner"    # Z

    .line 55
    const-string v0, "TransportSdkLog.txt"

    .line 57
    .local v0, "fileName":Ljava/lang/String;
    const/4 v1, 0x0

    if-eqz p1, :cond_1

    .line 59
    sget-object v2, Landroid/os/Environment;->DIRECTORY_DOWNLOADS:Ljava/lang/String;

    invoke-static {v2}, Landroid/os/Environment;->getExternalStoragePublicDirectory(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    .line 60
    .local v1, "downloadDirectory":Ljava/lang/String;
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "glass3Log"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .end local v1    # "downloadDirectory":Ljava/lang/String;
    goto :goto_0

    .line 62
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v3

    sget-object v4, Landroid/os/Environment;->DIRECTORY_DOCUMENTS:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    :cond_2
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mobileLog"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 57
    :goto_0
    nop

    .line 66
    .local v1, "filePath":Ljava/lang/String;
    new-instance v2, Lcom/rokid/logger/manager/LogcatConfig;

    invoke-direct {v2}, Lcom/rokid/logger/manager/LogcatConfig;-><init>()V

    move-object v3, v2

    .local v3, "$this$initRKLogger_u24lambda_u240":Lcom/rokid/logger/manager/LogcatConfig;
    const/4 v4, 0x0

    .line 70
    .local v4, "$i$a$-apply-EngineServiceImpl$initRKLogger$config$1":I
    invoke-virtual {v3, v0}, Lcom/rokid/logger/manager/LogcatConfig;->setFileName(Ljava/lang/String;)V

    .line 71
    invoke-virtual {v3, v1}, Lcom/rokid/logger/manager/LogcatConfig;->setFilePath(Ljava/lang/String;)V

    .line 72
    const/4 v5, 0x2

    invoke-virtual {v3, v5}, Lcom/rokid/logger/manager/LogcatConfig;->setFilterLevel(I)V

    .line 73
    const-string v5, "Transport-sdk"

    invoke-virtual {v3, v5}, Lcom/rokid/logger/manager/LogcatConfig;->setModule(Ljava/lang/String;)V

    .line 74
    const/4 v5, 0x1

    invoke-virtual {v3, v5}, Lcom/rokid/logger/manager/LogcatConfig;->setSaveLogInfo(Z)V

    .line 75
    nop

    .line 66
    .end local v3    # "$this$initRKLogger_u24lambda_u240":Lcom/rokid/logger/manager/LogcatConfig;
    .end local v4    # "$i$a$-apply-EngineServiceImpl$initRKLogger$config$1":I
    nop

    .line 76
    .local v2, "config":Lcom/rokid/logger/manager/LogcatConfig;
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v3

    check-cast v3, Landroid/content/Context;

    invoke-static {v3, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->setLogcatConfig(Landroid/content/Context;Lcom/rokid/logger/manager/LogcatConfig;)V

    .line 77
    return-void
.end method


# virtual methods
.method public destroy()V
    .locals 2

    .line 143
    sget-boolean v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isGroupOwner:Z

    if-eqz v0, :cond_0

    .line 144
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->release()V

    goto :goto_0

    .line 147
    :cond_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->release()V

    .line 148
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->release()V

    .line 151
    :goto_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 152
    return-void
.end method

.method public getAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;
    .locals 2

    .line 101
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    .line 102
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " SDK\u672a\u521d\u59cb\u5316,\u8bf7\u5148\u521d\u59cb\u5316"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 103
    const/4 v0, 0x0

    return-object v0

    .line 105
    :cond_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    return-object v0
.end method

.method public getAbsBleService()Lcom/rokid/glasses/transport/sdk/api/ble/server/api/AbsBleService;
    .locals 2

    .line 109
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    .line 110
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " SDK\u672a\u521d\u59cb\u5316,\u8bf7\u5148\u521d\u59cb\u5316"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 111
    const/4 v0, 0x0

    return-object v0

    .line 113
    :cond_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/ble/server/api/AbsBleService;

    return-object v0
.end method

.method public getAbsClassicBlueClientService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;
    .locals 2

    .line 117
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    .line 118
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " SDK\u672a\u521d\u59cb\u5316,\u8bf7\u5148\u521d\u59cb\u5316"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 119
    const/4 v0, 0x0

    return-object v0

    .line 121
    :cond_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    return-object v0
.end method

.method public getAbsClassicBlueService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/AbsClassicBlueToothServer;
    .locals 2

    .line 127
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    .line 128
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " SDK\u672a\u521d\u59cb\u5316,\u8bf7\u5148\u521d\u59cb\u5316"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 129
    const/4 v0, 0x0

    return-object v0

    .line 131
    :cond_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/AbsClassicBlueToothServer;

    return-object v0
.end method

.method public getAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;
    .locals 2

    .line 84
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    .line 85
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " SDK\u672a\u521d\u59cb\u5316,\u8bf7\u5148\u521d\u59cb\u5316"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 86
    const/4 v0, 0x0

    return-object v0

    .line 88
    :cond_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    return-object v0
.end method

.method public getAbsWifiP2PGoService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/AbsWifiP2PGoService;
    .locals 2

    .line 93
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    .line 94
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " SDK\u672a\u521d\u59cb\u5316,\u8bf7\u5148\u521d\u59cb\u5316"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 95
    const/4 v0, 0x0

    return-object v0

    .line 97
    :cond_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/AbsWifiP2PGoService;

    return-object v0
.end method

.method public final getOwnerId()Ljava/lang/String;
    .locals 1

    .line 29
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->ownerId:Ljava/lang/String;

    return-object v0
.end method

.method public final getPort()I
    .locals 1

    .line 30
    sget v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->port:I

    return v0
.end method

.method public initSDK(ZLjava/lang/String;ILkotlin/jvm/functions/Function1;)V
    .locals 3
    .param p1, "isGroupOwner"    # Z
    .param p2, "ownerId"    # Ljava/lang/String;
    .param p3, "port"    # I
    .param p4, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/lang/String;",
            "I",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "ownerId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onResult"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 33
    sput-boolean p1, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isGroupOwner:Z

    .line 34
    sput-object p2, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->ownerId:Ljava/lang/String;

    .line 35
    sput p3, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->port:I

    .line 36
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 37
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v2, "Transport SDK \u5df2\u521d\u59cb\u5316"

    invoke-static {v2, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 38
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .local v0, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    .local v1, "value$iv":Ljava/lang/Object;
    const/4 v2, 0x0

    .line 154
    .local v2, "$i$f$success":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v1    # "value$iv":Ljava/lang/Object;
    .end local v2    # "$i$f$success":I
    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v0

    .line 38
    invoke-interface {p4, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 39
    return-void

    .line 41
    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->initRKLogger(Z)V

    .line 42
    if-eqz p1, :cond_1

    .line 43
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->init()V

    goto :goto_0

    .line 45
    :cond_1
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->init()V

    .line 46
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->init()V

    .line 48
    :goto_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 49
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .restart local v0    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    .restart local v1    # "value$iv":Ljava/lang/Object;
    const/4 v2, 0x0

    .line 155
    .restart local v2    # "$i$f$success":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v1    # "value$iv":Ljava/lang/Object;
    .end local v2    # "$i$f$success":I
    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v0

    .line 49
    invoke-interface {p4, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 50
    return-void
.end method

.method public isInit()Z
    .locals 1

    .line 80
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method public final setOwnerId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    sput-object p1, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->ownerId:Ljava/lang/String;

    return-void
.end method

.method public final setPort(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 30
    sput p1, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->port:I

    return-void
.end method
