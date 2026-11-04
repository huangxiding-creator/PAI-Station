.class public final Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;
.super Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;
.source "MobileEngineServerImpl.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nMobileEngineServerImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 MobileEngineServerImpl.kt\ncom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n+ 3 _Strings.kt\nkotlin/text/StringsKt___StringsKt\n*L\n1#1,246:1\n84#2:247\n93#2:248\n84#2:249\n1064#3,2:250\n*S KotlinDebug\n*F\n+ 1 MobileEngineServerImpl.kt\ncom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl\n*L\n58#1:247\n70#1:248\n104#1:249\n181#1:250,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000K\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000*\u0001\u0006\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\rH\u0002J\u0010\u0010\u000e\u001a\u00020\r2\u0006\u0010\u0008\u001a\u00020\tH\u0002J\u0008\u0010\u000f\u001a\u00020\u000bH\u0016J\u0008\u0010\u0010\u001a\u00020\u000bH\u0002J<\u0010\u0011\u001a\u00020\u000b2\u0006\u0010\u0008\u001a\u00020\t2\'\u0010\u0012\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\r0\u0014\u00a2\u0006\u000c\u0008\u0015\u0012\u0008\u0008\u0016\u0012\u0004\u0008\u0008(\u000c\u0012\u0004\u0012\u00020\u000b0\u0013H\u0016\u00f8\u0001\u0000J\u0008\u0010\u0003\u001a\u00020\rH\u0016J\u0012\u0010\u0017\u001a\u00020\r2\u0008\u0010\u0018\u001a\u0004\u0018\u00010\u0019H\u0002J\u0010\u0010\u001a\u001a\u00020\u000b2\u0006\u0010\u001b\u001a\u00020\u001cH\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0004\n\u0002\u0010\u0007R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u001d"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;",
        "Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;",
        "()V",
        "isInit",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "mISendTool",
        "com/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1",
        "Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1;",
        "params",
        "Lcom/rokid/security/phone/sdk/base/data/EngineParam;",
        "authResult",
        "",
        "result",
        "",
        "checkEnvHost",
        "destroy",
        "initRKLogger",
        "initSDK",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "Lkotlin/ParameterName;",
        "name",
        "isValidServerId",
        "appId",
        "",
        "setUserInfo",
        "user",
        "Lcom/rokid/security/sdk/base/common/outside/UserInfo;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;

.field private static isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static mISendTool:Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1;

.field private static params:Lcom/rokid/security/phone/sdk/base/data/EngineParam;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;

    .line 52
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 111
    new-instance v0, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->mISendTool:Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 50
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;-><init>()V

    return-void
.end method

.method public static final synthetic access$authResult(Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;
    .param p1, "result"    # Z

    .line 50
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->authResult(Z)V

    return-void
.end method

.method private final authResult(Z)V
    .locals 5
    .param p1, "result"    # Z

    .line 129
    const/4 v0, 0x0

    if-eqz p1, :cond_11

    .line 130
    const-string v1, "Mobile SDK \u9274\u6743\u6210\u529f"

    new-array v2, v0, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 131
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->init()V

    .line 132
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getBanServiceList()Ljava/util/List;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    const/4 v3, 0x1

    if-eqz v1, :cond_3

    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getBanServiceList()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 133
    sget-object v4, Lcom/rokid/security/phone/sdk/base/data/NetServiceType;->ALL:Lcom/rokid/security/phone/sdk/base/data/NetServiceType;

    .line 132
    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    .line 133
    if-ne v1, v3, :cond_1

    move v1, v3

    goto :goto_1

    :cond_1
    move v1, v0

    goto :goto_1

    .line 132
    :cond_2
    move v1, v0

    :goto_1
    if-eqz v1, :cond_3

    .line 135
    const-string v1, "Mobile NetServiceType.ALL"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_6

    .line 138
    :cond_3
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getBanServiceList()Ljava/util/List;

    move-result-object v1

    goto :goto_2

    :cond_4
    move-object v1, v2

    :goto_2
    if-eqz v1, :cond_7

    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v1

    if-eqz v1, :cond_6

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getBanServiceList()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_6

    .line 139
    sget-object v4, Lcom/rokid/security/phone/sdk/base/data/NetServiceType;->AsrService:Lcom/rokid/security/phone/sdk/base/data/NetServiceType;

    .line 138
    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    .line 139
    if-ne v1, v3, :cond_5

    move v1, v3

    goto :goto_3

    :cond_5
    move v1, v0

    goto :goto_3

    .line 138
    :cond_6
    move v1, v0

    :goto_3
    if-nez v1, :cond_8

    .line 140
    :cond_7
    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->initAsr()V

    .line 143
    :cond_8
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v1

    if-eqz v1, :cond_9

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getBanServiceList()Ljava/util/List;

    move-result-object v1

    goto :goto_4

    :cond_9
    move-object v1, v2

    :goto_4
    if-eqz v1, :cond_c

    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v1

    if-eqz v1, :cond_b

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getBanServiceList()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_b

    .line 144
    sget-object v4, Lcom/rokid/security/phone/sdk/base/data/NetServiceType;->TtsService:Lcom/rokid/security/phone/sdk/base/data/NetServiceType;

    .line 143
    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    .line 144
    if-ne v1, v3, :cond_a

    move v1, v3

    goto :goto_5

    :cond_a
    move v1, v0

    goto :goto_5

    .line 143
    :cond_b
    move v1, v0

    :goto_5
    if-nez v1, :cond_d

    .line 145
    :cond_c
    sget-object v1, Lcom/rokid/security/sdk/ability/tts/TtsManager;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsManager;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->initTts()V

    .line 148
    :cond_d
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v1

    if-eqz v1, :cond_e

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getBanServiceList()Ljava/util/List;

    move-result-object v2

    :cond_e
    if-eqz v2, :cond_10

    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v1

    if-eqz v1, :cond_f

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getBanServiceList()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_f

    .line 149
    sget-object v2, Lcom/rokid/security/phone/sdk/base/data/NetServiceType;->TranslateService:Lcom/rokid/security/phone/sdk/base/data/NetServiceType;

    .line 148
    invoke-interface {v1, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    .line 149
    if-ne v1, v3, :cond_f

    move v0, v3

    .line 148
    :cond_f
    if-nez v0, :cond_12

    .line 150
    :cond_10
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->initTranslate()V

    goto :goto_6

    .line 156
    :cond_11
    const-string v1, "Mobile SDK \u9274\u6743\u5931\u8d25"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 158
    :cond_12
    :goto_6
    return-void
.end method

.method private final checkEnvHost(Lcom/rokid/security/phone/sdk/base/data/EngineParam;)Z
    .locals 2
    .param p1, "params"    # Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    .line 164
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getEnvType()Ljava/lang/String;

    move-result-object v0

    const-string v1, "custom"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_2

    .line 165
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getCustomHost()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    move v0, v1

    :goto_1
    xor-int/2addr v0, v1

    return v0

    .line 167
    :cond_2
    return v1
.end method

.method private final initRKLogger()V
    .locals 9

    .line 193
    const-string v0, "MobileSdkLog.txt"

    .line 194
    .local v0, "fileName":Ljava/lang/String;
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    sget-object v2, Landroid/os/Environment;->DIRECTORY_DOCUMENTS:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 195
    .local v1, "externalDocDir":Ljava/io/File;
    const-string v2, "Mobile-SDK"

    if-nez v1, :cond_0

    .line 196
    const-string v3, "initRKLogger failed: documents directory unavailable"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 197
    return-void

    .line 199
    :cond_0
    new-instance v3, Ljava/io/File;

    const-string v4, "mobileLog"

    invoke-direct {v3, v1, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 200
    .local v3, "logDir":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_1

    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    move-result v4

    if-nez v4, :cond_1

    .line 201
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "initRKLogger failed: cannot create "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 202
    return-void

    .line 204
    :cond_1
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v3, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    .line 206
    .local v4, "filePath":Ljava/lang/String;
    new-instance v5, Lcom/rokid/logger/manager/LogcatConfig;

    invoke-direct {v5}, Lcom/rokid/logger/manager/LogcatConfig;-><init>()V

    move-object v6, v5

    .local v6, "$this$initRKLogger_u24lambda_u241":Lcom/rokid/logger/manager/LogcatConfig;
    const/4 v7, 0x0

    .line 210
    .local v7, "$i$a$-apply-MobileEngineServerImpl$initRKLogger$config$1":I
    invoke-virtual {v6, v0}, Lcom/rokid/logger/manager/LogcatConfig;->setFileName(Ljava/lang/String;)V

    .line 211
    invoke-virtual {v6, v4}, Lcom/rokid/logger/manager/LogcatConfig;->setFilePath(Ljava/lang/String;)V

    .line 212
    const/4 v8, 0x2

    invoke-virtual {v6, v8}, Lcom/rokid/logger/manager/LogcatConfig;->setFilterLevel(I)V

    .line 213
    invoke-virtual {v6, v2}, Lcom/rokid/logger/manager/LogcatConfig;->setModule(Ljava/lang/String;)V

    .line 214
    const/4 v2, 0x1

    invoke-virtual {v6, v2}, Lcom/rokid/logger/manager/LogcatConfig;->setSaveLogInfo(Z)V

    .line 215
    nop

    .line 206
    .end local v6    # "$this$initRKLogger_u24lambda_u241":Lcom/rokid/logger/manager/LogcatConfig;
    .end local v7    # "$i$a$-apply-MobileEngineServerImpl$initRKLogger$config$1":I
    move-object v2, v5

    .line 216
    .local v2, "config":Lcom/rokid/logger/manager/LogcatConfig;
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v5

    check-cast v5, Landroid/content/Context;

    invoke-static {v5, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->setLogcatConfig(Landroid/content/Context;Lcom/rokid/logger/manager/LogcatConfig;)V

    .line 217
    return-void
.end method

.method private final isValidServerId(Ljava/lang/String;)Z
    .locals 9
    .param p1, "appId"    # Ljava/lang/String;

    .line 172
    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    .line 175
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x4

    if-ge v1, v2, :cond_1

    return v0

    .line 178
    :cond_1
    new-instance v1, Lkotlin/ranges/CharRange;

    const/16 v2, 0x30

    const/16 v3, 0x39

    invoke-direct {v1, v2, v3}, Lkotlin/ranges/CharRange;-><init>(CC)V

    check-cast v1, Ljava/lang/Iterable;

    new-instance v2, Lkotlin/ranges/CharRange;

    const/16 v3, 0x61

    const/16 v4, 0x66

    invoke-direct {v2, v3, v4}, Lkotlin/ranges/CharRange;-><init>(CC)V

    check-cast v2, Ljava/lang/Iterable;

    invoke-static {v1, v2}, Lkotlin/collections/CollectionsKt;->plus(Ljava/lang/Iterable;Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v1

    check-cast v1, Ljava/util/Collection;

    new-instance v2, Lkotlin/ranges/CharRange;

    const/16 v3, 0x41

    const/16 v4, 0x46

    invoke-direct {v2, v3, v4}, Lkotlin/ranges/CharRange;-><init>(CC)V

    check-cast v2, Ljava/lang/Iterable;

    invoke-static {v1, v2}, Lkotlin/collections/CollectionsKt;->plus(Ljava/util/Collection;Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v1

    .line 181
    .local v1, "validChars":Ljava/util/List;
    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    .local v2, "$this$all$iv":Ljava/lang/CharSequence;
    const/4 v3, 0x0

    .line 250
    .local v3, "$i$f$all":I
    move v4, v0

    :goto_0
    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-ge v4, v5, :cond_3

    invoke-interface {v2, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    .local v5, "element$iv":C
    move v6, v5

    .local v6, "it":C
    const/4 v7, 0x0

    .line 181
    .local v7, "$i$a$-all-MobileEngineServerImpl$isValidServerId$1":I
    invoke-static {v6}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v8

    invoke-interface {v1, v8}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v6

    .line 250
    .end local v6    # "it":C
    .end local v7    # "$i$a$-all-MobileEngineServerImpl$isValidServerId$1":I
    if-nez v6, :cond_2

    goto :goto_1

    .end local v5    # "element$iv":C
    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 251
    :cond_3
    const/4 v0, 0x1

    .line 181
    .end local v2    # "$this$all$iv":Ljava/lang/CharSequence;
    .end local v3    # "$i$f$all":I
    :goto_1
    return v0
.end method


# virtual methods
.method public destroy()V
    .locals 2

    .line 224
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->mISendTool:Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1;

    check-cast v1, Lcom/rokid/security/sdk/ability/message/ISendTool;

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->unRegisterMessageSendTool(Lcom/rokid/security/sdk/ability/message/ISendTool;)V

    .line 225
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->release()V

    .line 226
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->release()V

    .line 227
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->setAuthResultFun(Lkotlin/jvm/functions/Function1;)V

    .line 228
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->release()V

    .line 229
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->release()V

    .line 230
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->destroy()V

    .line 231
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsManager;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->destroy()V

    .line 232
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->destroy()V

    .line 233
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->release()V

    .line 234
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->release()V

    .line 235
    sget-object v0, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;->release()V

    .line 236
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->release()V

    .line 237
    sget-object v0, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->release()V

    .line 238
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->release()V

    .line 239
    sget-object v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->release()V

    .line 240
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->release()V

    .line 241
    sget-object v0, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 242
    const-string v0, "Mobile SDK destroy"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 243
    return-void
.end method

.method public initSDK(Lcom/rokid/security/phone/sdk/base/data/EngineParam;Lkotlin/jvm/functions/Function1;)V
    .locals 8
    .param p1, "params"    # Lcom/rokid/security/phone/sdk/base/data/EngineParam;
    .param p2, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/base/data/EngineParam;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "params"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onResult"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 56
    sget-object v0, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    .line 57
    const-string v0, "Mobile SDK \u5df2\u521d\u59cb\u5316, \u4e0d\u8981\u91cd\u590d\u521d\u59cb\u5316"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 58
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .local v0, "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    .local v1, "value$iv":Ljava/lang/Object;
    const/4 v2, 0x0

    .line 247
    .local v2, "$i$f$success":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v1    # "value$iv":Ljava/lang/Object;
    .end local v2    # "$i$f$success":I
    invoke-static {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v0

    .line 58
    invoke-interface {p2, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 59
    return-void

    .line 68
    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->checkEnvHost(Lcom/rokid/security/phone/sdk/base/data/EngineParam;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 69
    const-string v0, "Glass SDK params customHost cannot be empty"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 70
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .restart local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v7, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v2, -0x1

    const-string v3, "customHost invalid"

    const/4 v4, 0x0

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v1, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v2, 0x0

    .line 248
    .local v2, "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v2    # "$i$f$failure":I
    invoke-static {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v0

    .line 70
    invoke-interface {p2, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 71
    return-void

    .line 73
    :cond_1
    sput-object p1, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->params:Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    .line 74
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->initRKLogger()V

    .line 76
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->setEnv(Lcom/rokid/security/phone/sdk/base/data/EngineParam;)V

    .line 77
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "initSDK: EngineParam = "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    sget-object v3, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$initSDK$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$initSDK$1;

    check-cast v3, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->init(Lkotlin/jvm/functions/Function1;)V

    .line 85
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->init()V

    .line 87
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->init()V

    .line 89
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->init()V

    .line 90
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->init()V

    .line 91
    sget-object v0, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->init()V

    .line 92
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->initFileSystem()V

    .line 94
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    new-instance v3, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$initSDK$2;

    invoke-direct {v3, p0}, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$initSDK$2;-><init>(Ljava/lang/Object;)V

    check-cast v3, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->setAuthResultFun(Lkotlin/jvm/functions/Function1;)V

    .line 95
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->init()V

    .line 96
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->initAIChat()V

    .line 97
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->initIdentification()V

    .line 98
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->init()V

    .line 99
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->initBTRingService()V

    .line 100
    sget-object v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->init()V

    .line 101
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->init()V

    .line 102
    sget-object v0, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 103
    const-string v0, "Mobile SDK \u521d\u59cb\u5316\u6210\u529f"

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 104
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .restart local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    .local v1, "value$iv":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 249
    .local v3, "$i$f$success":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v1    # "value$iv":Ljava/lang/Object;
    .end local v3    # "$i$f$success":I
    invoke-static {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v0

    .line 104
    invoke-interface {p2, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 107
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->mISendTool:Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1;

    check-cast v1, Lcom/rokid/security/sdk/ability/message/ISendTool;

    invoke-interface {v0, v1, v2}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->registerMessageSendTool(Lcom/rokid/security/sdk/ability/message/ISendTool;I)V

    .line 108
    return-void
.end method

.method public isInit()Z
    .locals 1

    .line 220
    sget-object v0, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method public setUserInfo(Lcom/rokid/security/sdk/base/common/outside/UserInfo;)V
    .locals 2
    .param p1, "user"    # Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    const-string/jumbo v0, "user"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 186
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "setUserInfo->"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getUserToken()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "UserUtils"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 187
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/auth/UserManager;->setUserInfo(Lcom/rokid/security/sdk/base/common/outside/UserInfo;)V

    .line 188
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getUserToken()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->addUserInfoHeader(Ljava/lang/String;)V

    .line 189
    return-void
.end method
