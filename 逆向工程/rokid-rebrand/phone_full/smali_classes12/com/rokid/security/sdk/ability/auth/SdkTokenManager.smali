.class public final Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
.super Ljava/lang/Object;
.source "SdkTokenManager.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nSdkTokenManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 SdkTokenManager.kt\ncom/rokid/security/sdk/ability/auth/SdkTokenManager\n+ 2 CoroutineScope.kt\nkotlinx/coroutines/CoroutineScopeKt\n*L\n1#1,525:1\n329#2:526\n*S KotlinDebug\n*F\n+ 1 SdkTokenManager.kt\ncom/rokid/security/sdk/ability/auth/SdkTokenManager\n*L\n186#1:526\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0092\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\"\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0016\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0010\n\u0002\u0018\u0002\n\u0002\u0008\u0018\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0001^B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0016\u0010%\u001a\u00020\u001c2\u0006\u0010&\u001a\u00020\'2\u0006\u0010(\u001a\u00020)J\u0010\u0010*\u001a\u00020\u001c2\u0006\u0010\u001b\u001a\u00020\u0018H\u0002J\u0019\u0010+\u001a\u00020\u00182\u0006\u0010,\u001a\u00020\u0007H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010-J\u001a\u0010.\u001a\u0004\u0018\u00010/2\u0006\u00100\u001a\u0002012\u0006\u00102\u001a\u00020\u000bH\u0002J\u001a\u00103\u001a\u0004\u0018\u00010/2\u0006\u00100\u001a\u0002012\u0006\u00104\u001a\u00020\u000bH\u0002J \u00105\u001a\u00020\u00182\u0006\u00100\u001a\u0002012\u0006\u0010(\u001a\u0002062\u0006\u00107\u001a\u00020\u000bH\u0002J\u0008\u00108\u001a\u00020\u0018H\u0002J\u0018\u00109\u001a\u00020\u00182\u0006\u00104\u001a\u00020\u000b2\u0008\u0008\u0002\u0010:\u001a\u00020\u0018J\u0010\u0010;\u001a\u00020\u00182\u0006\u00100\u001a\u000201H\u0002J\u0010\u0010<\u001a\u00020\u001c2\u0006\u0010(\u001a\u00020)H\u0002J\u0018\u0010=\u001a\u00020\u00182\u0006\u00100\u001a\u0002012\u0006\u0010>\u001a\u00020\u0013H\u0002J)\u0010?\u001a\u00020\u001c2\u0006\u00100\u001a\u0002012\u0008\u0010@\u001a\u0004\u0018\u00010\u00052\u0008\u0010A\u001a\u0004\u0018\u00010\u000bH\u0002\u00a2\u0006\u0002\u0010BJ\u0006\u0010C\u001a\u00020\u001cJ\u0018\u0010D\u001a\u00020\u001c2\u0006\u00100\u001a\u0002012\u0006\u00104\u001a\u00020\u000bH\u0002J)\u0010E\u001a\u00020\u00182\u000c\u0010F\u001a\u0008\u0012\u0004\u0012\u00020\u00180G2\u000c\u0010H\u001a\u0008\u0012\u0004\u0012\u00020\u001c0GH\u0000\u00a2\u0006\u0002\u0008IJ\u001e\u0010J\u001a\u00020\u001c2\u0006\u0010K\u001a\u00020/2\u000c\u0010L\u001a\u0008\u0012\u0004\u0012\u00020\u001c0GH\u0002J\u0006\u0010M\u001a\u00020\u0018J\u000e\u0010N\u001a\u00020\u001c2\u0006\u0010(\u001a\u00020)J)\u0010O\u001a\u00020\u001c2\u0006\u0010(\u001a\u00020)2\u0006\u00100\u001a\u0002012\u0006\u00104\u001a\u00020\u000bH\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010PJ\u001b\u0010Q\u001a\u00020\u001c2\u000c\u0010R\u001a\u0008\u0012\u0004\u0012\u00020\u001c0GH\u0000\u00a2\u0006\u0002\u0008SJ\u0018\u0010T\u001a\u00020\u00182\u0006\u0010U\u001a\u00020\u000b2\u0006\u0010V\u001a\u00020\u000bH\u0002J+\u0010W\u001a\u00020\u001c2#\u0010X\u001a\u001f\u0012\u0013\u0012\u00110\u0018\u00a2\u0006\u000c\u0008\u0019\u0012\u0008\u0008\u001a\u0012\u0004\u0008\u0008(\u001b\u0012\u0004\u0012\u00020\u001c\u0018\u00010\u0017J\u0008\u0010Y\u001a\u00020\u001cH\u0002J\u0018\u0010Z\u001a\u00020\u001c2\u0006\u0010(\u001a\u00020)2\u0006\u0010[\u001a\u00020\u000bH\u0002J\u0010\u0010\\\u001a\u00020\u001c2\u0006\u00107\u001a\u00020\u000bH\u0002J\u0019\u0010]\u001a\u00020\u001c2\u0006\u0010,\u001a\u00020\u0007H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010-R\u0014\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u00020\u00050\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u0007X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0005X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000f\u001a\u00020\u0010X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0017\u0010\u0011\u001a\u0008\u0012\u0004\u0012\u00020\u00130\u0012\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0014\u0010\u0015R+\u0010\u0016\u001a\u001f\u0012\u0013\u0012\u00110\u0018\u00a2\u0006\u000c\u0008\u0019\u0012\u0008\u0008\u001a\u0012\u0004\u0008\u0008(\u001b\u0012\u0004\u0012\u00020\u001c\u0018\u00010\u0017X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001d\u001a\u00020\u001eX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u001f\u001a\u0008\u0012\u0004\u0012\u00020\u001c0 X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010!\u001a\u0004\u0018\u00010\"X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0017\u0010#\u001a\u0008\u0012\u0004\u0012\u00020\u000b0\u0012\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008$\u0010\u0015\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006_"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;",
        "",
        "()V",
        "APP_AUTH_INVALID_CODES",
        "",
        "",
        "AUTH_READY_POLL_INTERVAL_MS",
        "",
        "RETRY_DELAYS_MS",
        "",
        "TAG",
        "",
        "TOKEN_REFRESH_INTERVAL_MS",
        "USER_TOKEN_FAILURE_CODE",
        "activeRefreshKey",
        "authResultLinearizer",
        "Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;",
        "authState",
        "Lkotlinx/coroutines/flow/MutableStateFlow;",
        "Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;",
        "getAuthState",
        "()Lkotlinx/coroutines/flow/MutableStateFlow;",
        "mAuthResultFun",
        "Lkotlin/Function1;",
        "",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "",
        "refreshGuard",
        "Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;",
        "retrySignal",
        "Lkotlinx/coroutines/channels/Channel;",
        "sdkJob",
        "Lkotlinx/coroutines/Job;",
        "sdkToken",
        "getSdkToken",
        "applyUserCredentialAndRefresh",
        "userInfo",
        "Lcom/rokid/security/sdk/base/common/outside/UserInfo;",
        "deviceInfo",
        "Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;",
        "authResult",
        "awaitAuthReady",
        "timeoutMs",
        "(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "beginTerminalFailureIfCurrent",
        "Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;",
        "refreshLease",
        "Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;",
        "clearReason",
        "beginUserTokenFailureIfCurrent",
        "expectedUserToken",
        "commitSuccessIfCurrent",
        "Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;",
        "token",
        "hasUsableAuthHeaders",
        "invalidateUserCredentialIfCurrent",
        "publishFailure",
        "isCurrentRefresh",
        "makeSdkToken",
        "markAuthStateIfCurrent",
        "state",
        "notifyAppAuthExpired",
        "code",
        "message",
        "(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/Integer;Ljava/lang/String;)V",
        "notifyNetworkAvailable",
        "notifyUserTokenFailure",
        "publishAuthResultForTest",
        "isCurrent",
        "Lkotlin/Function0;",
        "callback",
        "publishAuthResultForTest$sdk_common_ability_release",
        "publishFailureIfCurrent",
        "failureLease",
        "publish",
        "publishUserCredentialFailureIfStillInvalid",
        "refreshToken",
        "refreshTokenLoop",
        "(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "runCredentialTransitionForTest",
        "block",
        "runCredentialTransitionForTest$sdk_common_ability_release",
        "sameCredential",
        "first",
        "second",
        "setAuthResultFun",
        "authResultFun",
        "stopRemoteRefresh",
        "updateRefreshRequestHeaders",
        "userToken",
        "updateSdkToken",
        "waitForRetrySignal",
        "AuthState",
        "sdk-common-ability_release"
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
.field private static final APP_AUTH_INVALID_CODES:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static final AUTH_READY_POLL_INTERVAL_MS:J = 0x64L

.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

.field private static final RETRY_DELAYS_MS:[J

.field private static final TAG:Ljava/lang/String; = "SdkTokenManager::"

.field private static final TOKEN_REFRESH_INTERVAL_MS:J = 0x36ee80L

.field private static final USER_TOKEN_FAILURE_CODE:I = 0xc389

.field private static activeRefreshKey:Ljava/lang/String;

.field private static final authResultLinearizer:Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;

.field private static final authState:Lkotlinx/coroutines/flow/MutableStateFlow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/flow/MutableStateFlow<",
            "Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;",
            ">;"
        }
    .end annotation
.end field

.field private static mAuthResultFun:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private static final refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

.field private static final retrySignal:Lkotlinx/coroutines/channels/Channel;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/channels/Channel<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private static sdkJob:Lkotlinx/coroutines/Job;

.field private static final sdkToken:Lkotlinx/coroutines/flow/MutableStateFlow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/flow/MutableStateFlow<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    .line 40
    const/4 v0, 0x4

    new-array v1, v0, [J

    fill-array-data v1, :array_0

    sput-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->RETRY_DELAYS_MS:[J

    .line 41
    new-array v0, v0, [Ljava/lang/Integer;

    const/16 v1, 0x191

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const/16 v1, 0x193

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    const v1, 0xc354

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x2

    aput-object v1, v0, v2

    const/16 v1, 0x2712

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x3

    aput-object v1, v0, v2

    invoke-static {v0}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->APP_AUTH_INVALID_CODES:Ljava/util/Set;

    .line 45
    const-string v0, ""

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->activeRefreshKey:Ljava/lang/String;

    .line 46
    new-instance v1, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;-><init>()V

    sput-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    .line 47
    new-instance v1, Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;-><init>()V

    sput-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResultLinearizer:Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;

    .line 48
    const/4 v1, 0x0

    const/4 v2, 0x6

    const/4 v3, -0x1

    invoke-static {v3, v1, v1, v2, v1}, Lkotlinx/coroutines/channels/ChannelKt;->Channel$default(ILkotlinx/coroutines/channels/BufferOverflow;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Lkotlinx/coroutines/channels/Channel;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->retrySignal:Lkotlinx/coroutines/channels/Channel;

    .line 58
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->IDLE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-static {v1}, Lkotlinx/coroutines/flow/StateFlowKt;->MutableStateFlow(Ljava/lang/Object;)Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    .line 64
    invoke-static {v0}, Lkotlinx/coroutines/flow/StateFlowKt;->MutableStateFlow(Ljava/lang/Object;)Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkToken:Lkotlinx/coroutines/flow/MutableStateFlow;

    return-void

    :array_0
    .array-data 8
        0x3e8
        0xbb8
        0x2710
        0x7530
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$authResult(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .param p1, "result"    # Z

    .line 34
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResult(Z)V

    return-void
.end method

.method public static final synthetic access$getMAuthResultFun$p()Lkotlin/jvm/functions/Function1;
    .locals 1

    .line 34
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->mAuthResultFun:Lkotlin/jvm/functions/Function1;

    return-object v0
.end method

.method public static final synthetic access$getRefreshGuard$p()Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;
    .locals 1

    .line 34
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    return-object v0
.end method

.method public static final synthetic access$getRetrySignal$p()Lkotlinx/coroutines/channels/Channel;
    .locals 1

    .line 34
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->retrySignal:Lkotlinx/coroutines/channels/Channel;

    return-object v0
.end method

.method public static final synthetic access$getSdkJob$p()Lkotlinx/coroutines/Job;
    .locals 1

    .line 34
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    return-object v0
.end method

.method public static final synthetic access$hasUsableAuthHeaders(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    .line 34
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->hasUsableAuthHeaders()Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$refreshTokenLoop(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .param p1, "deviceInfo"    # Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .param p2, "refreshLease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .param p3, "expectedUserToken"    # Ljava/lang/String;
    .param p4, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 34
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshTokenLoop(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$setActiveRefreshKey$p(Ljava/lang/String;)V
    .locals 0
    .param p0, "<set-?>"    # Ljava/lang/String;

    .line 34
    sput-object p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->activeRefreshKey:Ljava/lang/String;

    return-void
.end method

.method public static final synthetic access$setSdkJob$p(Lkotlinx/coroutines/Job;)V
    .locals 0
    .param p0, "<set-?>"    # Lkotlinx/coroutines/Job;

    .line 34
    sput-object p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    return-void
.end method

.method public static final synthetic access$waitForRetrySignal(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .param p1, "timeoutMs"    # J
    .param p3, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 34
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->waitForRetrySignal(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method private final authResult(Z)V
    .locals 2
    .param p1, "result"    # Z

    .line 394
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->mAuthResultFun:Lkotlin/jvm/functions/Function1;

    if-eqz v0, :cond_0

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 396
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;->getMessage()Landroidx/lifecycle/MutableLiveData;

    move-result-object v0

    .line 397
    if-eqz p1, :cond_1

    const-string v1, "TokenRefreshDoneSuccess"

    goto :goto_0

    .line 398
    :cond_1
    const-string v1, "TokenRefreshDoneFailed"

    .line 396
    :goto_0
    invoke-virtual {v0, v1}, Landroidx/lifecycle/MutableLiveData;->postValue(Ljava/lang/Object;)V

    .line 400
    return-void
.end method

.method private final beginTerminalFailureIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;)Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    .locals 5
    .param p1, "refreshLease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .param p2, "clearReason"    # Ljava/lang/String;

    .line 448
    monitor-enter p0

    const/4 v0, 0x0

    .line 449
    .local v0, "$i$a$-synchronized-SdkTokenManager$beginTerminalFailureIfCurrent$1":I
    :try_start_0
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->tryBeginFailure(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;

    move-result-object v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    goto :goto_0

    .line 450
    .local v1, "failureLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    :cond_0
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    if-eqz v3, :cond_1

    const/4 v4, 0x1

    invoke-static {v3, v2, v4, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 451
    :cond_1
    sput-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    .line 452
    const-string v2, ""

    sput-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->activeRefreshKey:Ljava/lang/String;

    .line 453
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    const-string v3, ""

    invoke-direct {v2, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->updateSdkToken(Ljava/lang/String;)V

    .line 454
    sget-object v2, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v2, p2}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->clearUserAuthorization(Ljava/lang/String;)V

    .line 455
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->INVALID:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-interface {v2, v3}, Lkotlinx/coroutines/flow/MutableStateFlow;->setValue(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 456
    move-object v2, v1

    .line 448
    .end local v0    # "$i$a$-synchronized-SdkTokenManager$beginTerminalFailureIfCurrent$1":I
    .end local v1    # "failureLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    :goto_0
    monitor-exit p0

    .line 457
    return-object v2

    .line 448
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private final beginUserTokenFailureIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;)Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    .locals 6
    .param p1, "refreshLease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .param p2, "expectedUserToken"    # Ljava/lang/String;

    .line 462
    monitor-enter p0

    const/4 v0, 0x0

    .line 463
    .local v0, "$i$a$-synchronized-SdkTokenManager$beginUserTokenFailureIfCurrent$1":I
    :try_start_0
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getUserToken()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    if-nez v1, :cond_1

    const-string v1, ""

    .line 464
    .local v1, "currentToken":Ljava/lang/String;
    :cond_1
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-direct {v3, v1, p2}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sameCredential(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    goto :goto_1

    .line 465
    :cond_2
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    invoke-virtual {v3, p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->tryBeginFailure(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_1

    .line 466
    .local v3, "failureLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    :cond_3
    sget-object v4, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    if-eqz v4, :cond_4

    const/4 v5, 0x1

    invoke-static {v4, v2, v5, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 467
    :cond_4
    sput-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    .line 468
    const-string v2, ""

    sput-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->activeRefreshKey:Ljava/lang/String;

    .line 469
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    const-string v4, ""

    invoke-direct {v2, v4}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->updateSdkToken(Ljava/lang/String;)V

    .line 470
    sget-object v2, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    const-string/jumbo v4, "user_token_failure_50057"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->clearUserAuthorization(Ljava/lang/String;)V

    .line 471
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/auth/UserManager;->clearUserInfo()V

    .line 472
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    sget-object v4, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->INVALID:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-interface {v2, v4}, Lkotlinx/coroutines/flow/MutableStateFlow;->setValue(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 473
    move-object v2, v3

    .line 462
    .end local v0    # "$i$a$-synchronized-SdkTokenManager$beginUserTokenFailureIfCurrent$1":I
    .end local v1    # "currentToken":Ljava/lang/String;
    .end local v3    # "failureLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    :goto_1
    monitor-exit p0

    .line 474
    return-object v2

    .line 462
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private final commitSuccessIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;Ljava/lang/String;)Z
    .locals 5
    .param p1, "refreshLease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .param p2, "deviceInfo"    # Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;
    .param p3, "token"    # Ljava/lang/String;

    .line 304
    monitor-enter p0

    const/4 v0, 0x0

    .line 305
    .local v0, "$i$a$-synchronized-SdkTokenManager$commitSuccessIfCurrent$committed$1":I
    :try_start_0
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->isCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez v1, :cond_0

    move v0, v3

    goto :goto_0

    .line 306
    :cond_0
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->updateHeaders(Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;)V

    .line 307
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-direct {v1, p3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->updateSdkToken(Ljava/lang/String;)V

    .line 308
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    sget-object v4, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->READY:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-interface {v1, v4}, Lkotlinx/coroutines/flow/MutableStateFlow;->setValue(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 309
    move v0, v2

    .line 304
    .end local v0    # "$i$a$-synchronized-SdkTokenManager$commitSuccessIfCurrent$committed$1":I
    :goto_0
    monitor-exit p0

    .line 311
    .local v0, "committed":Z
    if-nez v0, :cond_1

    return v3

    .line 312
    :cond_1
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResultLinearizer:Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;

    new-instance v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$commitSuccessIfCurrent$1;

    invoke-direct {v3, p0, p1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$commitSuccessIfCurrent$1;-><init>(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)V

    check-cast v3, Lkotlin/jvm/functions/Function0;

    sget-object v4, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$commitSuccessIfCurrent$2;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$commitSuccessIfCurrent$2;

    check-cast v4, Lkotlin/jvm/functions/Function0;

    invoke-virtual {v1, v3, v4}, Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;->publishIf(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;)Z

    .line 316
    return v2

    .line 304
    .end local v0    # "committed":Z
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private final hasUsableAuthHeaders()Z
    .locals 6

    .line 343
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->ensureBusinessHeaders()V

    .line 344
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    const-string/jumbo v1, "x-app-authorization"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeader(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_1

    :cond_1
    :goto_0
    move v0, v2

    :goto_1
    xor-int/2addr v0, v2

    .line 345
    .local v0, "appTokenReady":Z
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getUserToken()Ljava/lang/String;

    move-result-object v3

    goto :goto_2

    :cond_2
    const/4 v3, 0x0

    :goto_2
    if-nez v3, :cond_3

    const-string v3, ""

    .line 346
    .local v3, "currentUserToken":Ljava/lang/String;
    :cond_3
    move-object v4, v3

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_7

    .line 347
    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    const-string/jumbo v5, "x-user-authorization"

    invoke-virtual {v4, v5}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeader(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    if-eqz v4, :cond_5

    invoke-static {v4}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_4

    goto :goto_3

    :cond_4
    move v4, v1

    goto :goto_4

    :cond_5
    :goto_3
    move v4, v2

    :goto_4
    if-nez v4, :cond_6

    goto :goto_5

    :cond_6
    move v4, v1

    goto :goto_6

    :cond_7
    :goto_5
    move v4, v2

    .line 346
    :goto_6
    nop

    .line 348
    .local v4, "userTokenReady":Z
    if-eqz v0, :cond_8

    if-eqz v4, :cond_8

    move v1, v2

    :cond_8
    return v1
.end method

.method public static synthetic invalidateUserCredentialIfCurrent$default(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Ljava/lang/String;ZILjava/lang/Object;)Z
    .locals 0

    .line 88
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    .line 90
    const/4 p2, 0x1

    .line 88
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->invalidateUserCredentialIfCurrent(Ljava/lang/String;Z)Z

    move-result p0

    return p0
.end method

.method private final isCurrentRefresh(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z
    .locals 1
    .param p1, "refreshLease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    .line 288
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->isCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z

    move-result v0

    return v0
.end method

.method private final makeSdkToken(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;)V
    .locals 20
    .param p1, "deviceInfo"    # Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    .line 352
    move-object/from16 v0, p0

    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getUserAuthInfo()Lcom/rokid/security/phone/sdk/base/data/UserAuthInfo;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v2

    .line 353
    .local v1, "authInfo":Lcom/rokid/security/phone/sdk/base/data/UserAuthInfo;
    :goto_0
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/UserAuthInfo;->getAppId()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_1
    move-object v3, v2

    :goto_1
    const-string v4, ""

    if-nez v3, :cond_2

    move-object v3, v4

    .line 354
    .local v3, "appId":Ljava/lang/String;
    :cond_2
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/UserAuthInfo;->getSecret()Ljava/lang/String;

    move-result-object v2

    :cond_3
    if-nez v2, :cond_4

    move-object v2, v4

    .line 355
    .local v2, "secret":Ljava/lang/String;
    :cond_4
    move-object v5, v3

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    const/4 v6, 0x0

    const-string v7, "SdkTokenManager::"

    if-nez v5, :cond_9

    move-object v5, v2

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_5

    goto/16 :goto_2

    .line 363
    :cond_5
    new-instance v5, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;

    .line 364
    sget-object v8, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v8}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v8

    if-eqz v8, :cond_6

    invoke-virtual {v8}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getId()Ljava/lang/String;

    move-result-object v8

    if-nez v8, :cond_7

    :cond_6
    move-object v8, v4

    .line 365
    :cond_7
    nop

    .line 366
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceId()Ljava/lang/String;

    move-result-object v9

    .line 367
    nop

    .line 363
    const-string v10, "Glass"

    invoke-direct {v5, v8, v10, v9, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 369
    .local v5, "mAppTokenDTO":Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;
    const-string v8, "makeSdkToken updateHeaders: envType "

    new-array v9, v6, [Ljava/lang/Object;

    invoke-static {v8, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 370
    sget-object v8, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;

    .line 371
    nop

    .line 372
    nop

    .line 373
    const-wide/16 v9, 0x7

    invoke-static {v9, v10}, Ljava/time/Duration;->ofDays(J)Ljava/time/Duration;

    move-result-object v9

    const-string v10, "ofDays(7)"

    invoke-static {v9, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 370
    invoke-virtual {v8, v5, v2, v9}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;->generateSignedToken(Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;Ljava/lang/String;Ljava/time/Duration;)Ljava/lang/String;

    move-result-object v8

    .line 375
    .local v8, "sdkToken":Ljava/lang/String;
    move-object v9, v8

    check-cast v9, Ljava/lang/CharSequence;

    invoke-static {v9}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_8

    .line 376
    const-string v9, "makeSdkToken failed: generated sdk token is blank"

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v7, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 377
    invoke-direct {v0, v4}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->updateSdkToken(Ljava/lang/String;)V

    .line 378
    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    const-string v7, "blank_generated_sdk_token"

    invoke-virtual {v4, v7}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->clearUserAuthorization(Ljava/lang/String;)V

    .line 379
    invoke-direct {v0, v6}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResult(Z)V

    .line 380
    sget-object v4, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    sget-object v6, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->INVALID:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-interface {v4, v6}, Lkotlinx/coroutines/flow/MutableStateFlow;->setValue(Ljava/lang/Object;)V

    .line 381
    return-void

    .line 383
    :cond_8
    invoke-direct {v0, v8}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->updateSdkToken(Ljava/lang/String;)V

    .line 384
    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    const-string/jumbo v6, "use_local_signed_sdk_token"

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->clearUserAuthorization(Ljava/lang/String;)V

    .line 386
    new-instance v4, Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceId()Ljava/lang/String;

    move-result-object v12

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceType()Ljava/lang/String;

    move-result-object v13

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getBtMac()Ljava/lang/String;

    move-result-object v14

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getWifiMac()Ljava/lang/String;

    move-result-object v15

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getP2pMac()Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceSubType()Ljava/lang/String;

    move-result-object v18

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getOsVersion()Ljava/lang/String;

    move-result-object v19

    move-object v11, v4

    move-object/from16 v17, v8

    invoke-direct/range {v11 .. v19}, Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 387
    .local v4, "deviceInfo_":Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;
    sget-object v6, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v6, v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->updateHeaders(Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;)V

    .line 388
    sget-object v6, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    sget-object v9, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->READY:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-interface {v6, v9}, Lkotlinx/coroutines/flow/MutableStateFlow;->setValue(Ljava/lang/Object;)V

    .line 389
    const-string v6, "makeSdkToken generated=true"

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v7, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 390
    const/4 v6, 0x1

    invoke-direct {v0, v6}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResult(Z)V

    .line 391
    return-void

    .line 356
    .end local v4    # "deviceInfo_":Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;
    .end local v5    # "mAppTokenDTO":Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;
    .end local v8    # "sdkToken":Ljava/lang/String;
    :cond_9
    :goto_2
    const-string v5, "makeSdkToken failed: userAuthInfo appId/secret is missing"

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v7, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 357
    invoke-direct {v0, v4}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->updateSdkToken(Ljava/lang/String;)V

    .line 358
    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    const-string v5, "missing_user_auth_info"

    invoke-virtual {v4, v5}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->clearUserAuthorization(Ljava/lang/String;)V

    .line 359
    invoke-direct {v0, v6}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResult(Z)V

    .line 360
    sget-object v4, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    sget-object v5, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->INVALID:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-interface {v4, v5}, Lkotlinx/coroutines/flow/MutableStateFlow;->setValue(Ljava/lang/Object;)V

    .line 361
    return-void
.end method

.method private final markAuthStateIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;)Z
    .locals 2
    .param p1, "refreshLease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .param p2, "state"    # Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    .line 293
    monitor-enter p0

    const/4 v0, 0x0

    .line 294
    .local v0, "$i$a$-synchronized-SdkTokenManager$markAuthStateIfCurrent$1":I
    :try_start_0
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->isCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    .line 295
    :cond_0
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    invoke-interface {v1, p2}, Lkotlinx/coroutines/flow/MutableStateFlow;->setValue(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 296
    const/4 v1, 0x1

    .line 293
    .end local v0    # "$i$a$-synchronized-SdkTokenManager$markAuthStateIfCurrent$1":I
    :goto_0
    monitor-exit p0

    .line 297
    return v1

    .line 293
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private final notifyAppAuthExpired(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 4
    .param p1, "refreshLease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .param p2, "code"    # Ljava/lang/Integer;
    .param p3, "message"    # Ljava/lang/String;

    .line 407
    nop

    .line 408
    nop

    .line 409
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "app_auth_expired_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 407
    invoke-direct {p0, p1, v0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->beginTerminalFailureIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;)Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;

    move-result-object v0

    if-nez v0, :cond_0

    .line 410
    return-void

    .line 411
    .local v0, "failureLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "app authorization expired code="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " messagePresent="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object v2, p3

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x1

    if-eqz v2, :cond_2

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    move v2, v3

    :goto_1
    xor-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "SdkTokenManager::"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 412
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$notifyAppAuthExpired$1;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$notifyAppAuthExpired$1;

    check-cast v1, Lkotlin/jvm/functions/Function0;

    invoke-direct {p0, v0, v1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->publishFailureIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;Lkotlin/jvm/functions/Function0;)V

    .line 416
    return-void
.end method

.method private final notifyUserTokenFailure(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;)V
    .locals 7
    .param p1, "refreshLease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .param p2, "expectedUserToken"    # Ljava/lang/String;

    .line 422
    nop

    .line 423
    nop

    .line 424
    nop

    .line 422
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->beginUserTokenFailureIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;)Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;

    move-result-object v0

    if-nez v0, :cond_0

    .line 425
    return-void

    .line 427
    .local v0, "failureLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    :cond_0
    nop

    .line 428
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "user authorization invalid code=50057 tokenPresent="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 429
    move-object v2, p2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    .line 428
    const/4 v3, 0x1

    xor-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 426
    const-string v2, "SdkTokenManager::"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 431
    :try_start_0
    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    .local v1, "$this$notifyUserTokenFailure_u24lambda_u248":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    const/4 v4, 0x0

    .line 432
    .local v4, "$i$a$-runCatching-SdkTokenManager$notifyUserTokenFailure$1":I
    sget-object v5, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;

    .line 433
    nop

    .line 434
    const-string/jumbo v6, "sdk_token_refresh"

    .line 435
    nop

    .line 432
    invoke-virtual {v5, p2, v6, v3}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->notify(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 437
    nop

    .end local v1    # "$this$notifyUserTokenFailure_u24lambda_u248":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .end local v4    # "$i$a$-runCatching-SdkTokenManager$notifyUserTokenFailure$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 431
    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    sget-object v3, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 437
    :goto_0
    invoke-static {v1}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v1

    if-eqz v1, :cond_1

    .local v1, "it":Ljava/lang/Throwable;
    const/4 v3, 0x0

    .line 438
    .local v3, "$i$a$-onFailure-SdkTokenManager$notifyUserTokenFailure$2":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "user token failure handler failed type="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 439
    nop

    .line 437
    .end local v1    # "it":Ljava/lang/Throwable;
    .end local v3    # "$i$a$-onFailure-SdkTokenManager$notifyUserTokenFailure$2":I
    nop

    .line 440
    :cond_1
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$notifyUserTokenFailure$3;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$notifyUserTokenFailure$3;

    check-cast v1, Lkotlin/jvm/functions/Function0;

    invoke-direct {p0, v0, v1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->publishFailureIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;Lkotlin/jvm/functions/Function0;)V

    .line 443
    return-void
.end method

.method private final publishFailureIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;Lkotlin/jvm/functions/Function0;)V
    .locals 3
    .param p1, "failureLease"    # Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
    .param p2, "publish"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 486
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResultLinearizer:Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;

    new-instance v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$1;

    invoke-direct {v1, p0, p1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$1;-><init>(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;)V

    check-cast v1, Lkotlin/jvm/functions/Function0;

    new-instance v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$2;

    invoke-direct {v2, p2}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$2;-><init>(Lkotlin/jvm/functions/Function0;)V

    check-cast v2, Lkotlin/jvm/functions/Function0;

    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;->publishIf(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;)Z

    .line 496
    return-void
.end method

.method private final refreshTokenLoop(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 30
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;",
            "Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    move-object/from16 v0, p4

    instance-of v1, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;

    if-eqz v1, :cond_0

    move-object v1, v0

    check-cast v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;

    iget v2, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->label:I

    const/high16 v3, -0x80000000

    and-int/2addr v2, v3

    if-eqz v2, :cond_0

    iget v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->label:I

    sub-int/2addr v0, v3

    iput v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->label:I

    move-object v0, v1

    move-object/from16 v2, p0

    goto :goto_0

    :cond_0
    new-instance v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;

    move-object/from16 v2, p0

    invoke-direct {v1, v2, v0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;-><init>(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Lkotlin/coroutines/Continuation;)V

    move-object v0, v1

    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    :goto_0
    iget-object v3, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->result:Ljava/lang/Object;

    .local v3, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v4

    .line 180
    iget v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->label:I

    const-string v6, " messagePresent="

    const-string v7, "ms, attempt="

    const-string v10, "SdkTokenManager::"

    const/4 v11, 0x1

    packed-switch v0, :pswitch_data_0

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v3    # "$result":Ljava/lang/Object;
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v3    # "$result":Ljava/lang/Object;
    :pswitch_0
    iget v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    .local v0, "retryIndex":I
    iget-object v12, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    check-cast v12, Ljava/lang/String;

    .local v12, "expectedUserToken":Ljava/lang/String;
    iget-object v13, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    check-cast v13, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    .local v13, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    iget-object v14, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    check-cast v14, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    .local v14, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    iget-object v15, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    check-cast v15, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    .local v15, "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v5, v6

    move-object/from16 v28, v15

    move v15, v0

    move-object/from16 v0, v28

    move-object/from16 v29, v14

    move-object v14, v12

    move-object v12, v13

    move-object/from16 v13, v29

    goto/16 :goto_15

    .end local v0    # "retryIndex":I
    .end local v12    # "expectedUserToken":Ljava/lang/String;
    .end local v13    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .end local v14    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .end local v15    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    :pswitch_1
    iget v12, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    .local v12, "retryIndex":I
    iget-object v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    move-object v13, v0

    check-cast v13, Ljava/lang/String;

    .local v13, "expectedUserToken":Ljava/lang/String;
    iget-object v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    move-object v14, v0

    check-cast v14, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    .local v14, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    iget-object v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    move-object v15, v0

    check-cast v15, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    .local v15, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    iget-object v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    move-object/from16 v16, v0

    check-cast v16, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    .local v16, "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    :try_start_0
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object/from16 v18, v6

    move-object/from16 v0, v16

    move-object/from16 v28, v15

    move v15, v12

    move-object v12, v14

    move-object v14, v13

    move-object/from16 v13, v28

    goto/16 :goto_7

    .end local v12    # "retryIndex":I
    .end local v13    # "expectedUserToken":Ljava/lang/String;
    .end local v14    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .end local v15    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .end local v16    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    :pswitch_2
    iget v12, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    .restart local v12    # "retryIndex":I
    iget-object v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    move-object v13, v0

    check-cast v13, Ljava/lang/String;

    .restart local v13    # "expectedUserToken":Ljava/lang/String;
    iget-object v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    move-object v14, v0

    check-cast v14, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    .restart local v14    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    iget-object v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    move-object v15, v0

    check-cast v15, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    .restart local v15    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    iget-object v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    move-object/from16 v16, v0

    check-cast v16, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    .restart local v16    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    :try_start_1
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v8, v4

    move-object/from16 v18, v6

    move-object/from16 v9, v16

    move-object v4, v3

    goto/16 :goto_5

    .line 244
    :catchall_0
    move-exception v0

    move-object v5, v6

    move-object/from16 v9, v16

    goto/16 :goto_e

    .line 180
    .end local v12    # "retryIndex":I
    .end local v13    # "expectedUserToken":Ljava/lang/String;
    .end local v14    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .end local v15    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .end local v16    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    :pswitch_3
    iget v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    .restart local v0    # "retryIndex":I
    iget-object v12, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    check-cast v12, Ljava/lang/String;

    .local v12, "expectedUserToken":Ljava/lang/String;
    iget-object v13, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    check-cast v13, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    .local v13, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    iget-object v14, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    check-cast v14, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    .local v14, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    iget-object v15, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    check-cast v15, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    .local v15, "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v18, v6

    move-object/from16 v28, v15

    move v15, v0

    move-object/from16 v0, v28

    move-object/from16 v29, v14

    move-object v14, v12

    move-object v12, v13

    move-object/from16 v13, v29

    goto/16 :goto_3

    .end local v0    # "retryIndex":I
    .end local v12    # "expectedUserToken":Ljava/lang/String;
    .end local v13    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .end local v14    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .end local v15    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    :pswitch_4
    iget v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    .restart local v0    # "retryIndex":I
    iget-object v12, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    check-cast v12, Ljava/lang/String;

    .restart local v12    # "expectedUserToken":Ljava/lang/String;
    iget-object v13, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    check-cast v13, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    .restart local v13    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    iget-object v14, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    check-cast v14, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    .restart local v14    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    iget-object v15, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    check-cast v15, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    .restart local v15    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v8, v4

    move-object v9, v15

    move-object v4, v3

    move-object v15, v14

    move-object v14, v13

    move-object v13, v12

    move v12, v0

    goto :goto_2

    .end local v0    # "retryIndex":I
    .end local v12    # "expectedUserToken":Ljava/lang/String;
    .end local v13    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .end local v14    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .end local v15    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    :pswitch_5
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v0, p0

    .local v0, "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    move-object/from16 v12, p2

    .local v12, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    move-object/from16 v13, p1

    .local v13, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    move-object/from16 v14, p3

    .line 185
    .local v14, "expectedUserToken":Ljava/lang/String;
    const/4 v15, 0x0

    .line 186
    .local v15, "retryIndex":I
    :goto_1
    const/16 v16, 0x0

    .line 526
    .local v16, "$i$f$currentCoroutineContext":I
    invoke-interface {v1}, Lkotlin/coroutines/Continuation;->getContext()Lkotlin/coroutines/CoroutineContext;

    move-result-object v17

    .line 186
    .end local v16    # "$i$f$currentCoroutineContext":I
    invoke-static/range {v17 .. v17}, Lkotlinx/coroutines/JobKt;->isActive(Lkotlin/coroutines/CoroutineContext;)Z

    move-result v16

    if-eqz v16, :cond_24

    invoke-direct {v0, v12}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->isCurrentRefresh(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z

    move-result v16

    if-eqz v16, :cond_24

    .line 187
    sget-object v8, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->REFRESHING:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-direct {v0, v12, v8}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->markAuthStateIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;)Z

    move-result v8

    if-nez v8, :cond_1

    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v4

    .line 188
    :cond_1
    sget-object v8, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->INSTANCE:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;

    iput-object v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    iput-object v13, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    iput-object v12, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    iput-object v14, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    iput v15, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    iput v11, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->label:I

    invoke-virtual {v8, v1}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->check(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v8

    if-ne v8, v4, :cond_2

    .line 180
    return-object v4

    .line 188
    :cond_2
    move-object v9, v0

    move-object/from16 v28, v4

    move-object v4, v3

    move-object v3, v8

    move-object/from16 v8, v28

    move-object/from16 v29, v14

    move-object v14, v12

    move v12, v15

    move-object v15, v13

    move-object/from16 v13, v29

    .line 180
    .end local v0    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .end local v3    # "$result":Ljava/lang/Object;
    .local v4, "$result":Ljava/lang/Object;
    .local v9, "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v12, "retryIndex":I
    .local v13, "expectedUserToken":Ljava/lang/String;
    .local v14, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .local v15, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    :goto_2
    move-object v0, v3

    check-cast v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    .line 189
    .local v0, "endpointResult":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;
    invoke-direct {v9, v14}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->isCurrentRefresh(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z

    move-result v3

    if-nez v3, :cond_3

    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v3

    .line 190
    :cond_3
    sget-object v3, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->REACHABLE:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    if-eq v0, v3, :cond_7

    .line 191
    sget-object v3, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->SKIPPED:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    if-eq v0, v3, :cond_6

    .line 192
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "refreshToken endpoint not ready result="

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .end local v0    # "endpointResult":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;
    invoke-static {v10, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 193
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->WAITING_NETWORK:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-direct {v9, v14, v0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->markAuthStateIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;)Z

    move-result v0

    if-nez v0, :cond_4

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 194
    :cond_4
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->RETRY_DELAYS_MS:[J

    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->RETRY_DELAYS_MS:[J

    invoke-static {v3}, Lkotlin/collections/ArraysKt;->getLastIndex([J)I

    move-result v3

    invoke-static {v12, v3}, Lkotlin/ranges/RangesKt;->coerceAtMost(II)I

    move-result v3

    move-object/from16 v18, v6

    aget-wide v5, v0, v3

    .line 195
    .local v5, "retryDelay":J
    add-int/lit8 v0, v12, 0x1

    .line 196
    .local v0, "attempt":I
    add-int/lit8 v3, v12, 0x1

    sget-object v19, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->RETRY_DELAYS_MS:[J

    invoke-static/range {v19 .. v19}, Lkotlin/collections/ArraysKt;->getLastIndex([J)I

    move-result v11

    invoke-static {v3, v11}, Lkotlin/ranges/RangesKt;->coerceAtMost(II)I

    move-result v3

    .line 197
    .end local v12    # "retryIndex":I
    .local v3, "retryIndex":I
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "refreshToken endpoint retry in "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    .end local v0    # "attempt":I
    invoke-static {v10, v11}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 198
    iput-object v9, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    iput-object v14, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    iput-object v13, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    iput v3, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    const/4 v0, 0x2

    iput v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->label:I

    invoke-direct {v9, v5, v6, v1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->waitForRetrySignal(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    .end local v5    # "retryDelay":J
    if-ne v0, v8, :cond_5

    .line 180
    return-object v8

    .line 198
    :cond_5
    move-object v0, v9

    move-object v12, v14

    move-object v14, v13

    move-object v13, v15

    move v15, v3

    move-object v3, v4

    move-object v4, v8

    .line 199
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v0, "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v3, "$result":Ljava/lang/Object;
    .local v12, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .local v13, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .local v14, "expectedUserToken":Ljava/lang/String;
    .local v15, "retryIndex":I
    :goto_3
    move-object/from16 v6, v18

    const/4 v11, 0x1

    goto/16 :goto_1

    .line 191
    .end local v3    # "$result":Ljava/lang/Object;
    .local v0, "endpointResult":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v12, "retryIndex":I
    .local v13, "expectedUserToken":Ljava/lang/String;
    .local v14, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .local v15, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    :cond_6
    move-object/from16 v18, v6

    goto :goto_4

    .line 190
    :cond_7
    move-object/from16 v18, v6

    .line 201
    .end local v0    # "endpointResult":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;
    :goto_4
    new-instance v0, Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;-><init>()V

    move-object v3, v0

    .local v3, "$this$refreshTokenLoop_u24lambda_u244":Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;
    const/4 v5, 0x0

    .line 202
    .local v5, "$i$a$-apply-SdkTokenManager$refreshTokenLoop$request$1":I
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceId()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;->setDeviceId(Ljava/lang/String;)V

    .line 203
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceType()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;->setDeviceType(Ljava/lang/String;)V

    .line 204
    nop

    .line 201
    .end local v3    # "$this$refreshTokenLoop_u24lambda_u244":Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;
    .end local v5    # "$i$a$-apply-SdkTokenManager$refreshTokenLoop$request$1":I
    nop

    .line 205
    .local v0, "request":Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;
    nop

    .line 206
    :try_start_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "refreshToken request deviceId="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceId()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, " host="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v5, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHost()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v10, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 207
    sget-object v3, Lcom/rokid/security/sdk/ability/net/ApiProvider;->INSTANCE:Lcom/rokid/security/sdk/ability/net/ApiProvider;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/ApiProvider;->getApi()Lcom/rokid/security/sdk/ability/net/ApiService;

    move-result-object v3

    invoke-interface {v3, v0}, Lcom/rokid/security/sdk/ability/net/ApiService;->refreshToken(Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v3

    iput-object v9, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    iput-object v14, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    iput-object v13, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    iput v12, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    const/4 v5, 0x3

    iput v5, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->label:I

    invoke-static {v3, v1}, Lkotlinx/coroutines/flow/FlowKt;->first(Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3

    .end local v0    # "request":Lcom/rokid/security/sdk/base/common/auth/SdkTokenRequest;
    if-ne v3, v8, :cond_8

    .line 180
    return-object v8

    :cond_8
    :goto_5
    check-cast v3, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    move-object v0, v3

    .line 208
    .local v0, "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    invoke-direct {v9, v14}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->isCurrentRefresh(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z

    move-result v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    if-nez v3, :cond_9

    :try_start_3
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    return-object v3

    .line 244
    .end local v0    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    :catchall_1
    move-exception v0

    move-object v3, v4

    move-object v4, v8

    move-object/from16 v5, v18

    goto/16 :goto_e

    .line 209
    .restart local v0    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    :cond_9
    :try_start_4
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "refreshToken response code="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v10, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 210
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_b

    :cond_a
    goto/16 :goto_8

    :cond_b
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    if-nez v3, :cond_a

    .line 211
    :try_start_5
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/auth/SdkToken;

    if-eqz v3, :cond_c

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/auth/SdkToken;->getToken()Ljava/lang/String;

    move-result-object v3

    goto :goto_6

    :cond_c
    const/4 v3, 0x0

    :goto_6
    if-nez v3, :cond_d

    const-string v3, ""

    .line 212
    .local v3, "token":Ljava/lang/String;
    :cond_d
    move-object v5, v3

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_e

    .line 213
    .end local v3    # "token":Ljava/lang/String;
    const-string v3, "refreshToken returned blank token, retry as service failure"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v10, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_8

    .line 215
    .end local v0    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    .restart local v3    # "token":Ljava/lang/String;
    :cond_e
    new-instance v0, Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;

    .line 216
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceId()Ljava/lang/String;

    move-result-object v20

    .line 217
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceType()Ljava/lang/String;

    move-result-object v21

    .line 218
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getBtMac()Ljava/lang/String;

    move-result-object v22

    .line 219
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getWifiMac()Ljava/lang/String;

    move-result-object v23

    .line 220
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getP2pMac()Ljava/lang/String;

    move-result-object v24

    .line 221
    nop

    .line 222
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceSubType()Ljava/lang/String;

    move-result-object v26

    .line 223
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getOsVersion()Ljava/lang/String;

    move-result-object v27

    .line 215
    move-object/from16 v19, v0

    move-object/from16 v25, v3

    invoke-direct/range {v19 .. v27}, Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 225
    .local v0, "sdkDeviceInfo":Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;
    invoke-direct {v9, v14, v0, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->commitSuccessIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_f

    sget-object v5, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v5

    .line 226
    .end local v0    # "sdkDeviceInfo":Lcom/rokid/security/phone/sdk/base/data/DeviceInfo;
    .end local v3    # "token":Ljava/lang/String;
    :cond_f
    const/4 v12, 0x0

    .line 227
    iput-object v9, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    iput-object v14, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    iput-object v13, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    iput v12, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    const/4 v0, 0x4

    iput v0, v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->label:I

    const-wide/32 v5, 0x36ee80

    invoke-direct {v9, v5, v6, v1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->waitForRetrySignal(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    if-ne v0, v8, :cond_10

    .line 180
    return-object v8

    .line 227
    :cond_10
    move-object v3, v4

    move-object v4, v8

    move-object v0, v9

    move-object/from16 v28, v15

    move v15, v12

    move-object v12, v14

    move-object v14, v13

    move-object/from16 v13, v28

    .line 228
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v0, "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v3, "$result":Ljava/lang/Object;
    .local v12, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .local v13, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .local v14, "expectedUserToken":Ljava/lang/String;
    .local v15, "retryIndex":I
    :goto_7
    move-object/from16 v6, v18

    const/4 v11, 0x1

    goto/16 :goto_1

    .line 231
    .end local v3    # "$result":Ljava/lang/Object;
    .local v0, "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v12, "retryIndex":I
    .local v13, "expectedUserToken":Ljava/lang/String;
    .local v14, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .local v15, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    :goto_8
    :try_start_6
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_12

    :cond_11
    goto :goto_9

    :cond_12
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    const v5, 0xc389

    if-ne v3, v5, :cond_11

    .line 232
    .end local v0    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    :try_start_7
    invoke-direct {v9, v14, v13}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->notifyUserTokenFailure(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;)V

    .line 233
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    return-object v0

    .line 235
    .restart local v0    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    :goto_9
    :try_start_8
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->APP_AUTH_INVALID_CODES:Ljava/util/Set;

    check-cast v3, Ljava/lang/Iterable;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v3, v5}, Lkotlin/collections/CollectionsKt;->contains(Ljava/lang/Iterable;Ljava/lang/Object;)Z

    move-result v3
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    if-eqz v3, :cond_13

    .line 236
    :try_start_9
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v9, v14, v3, v5}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->notifyAppAuthExpired(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/Integer;Ljava/lang/String;)V

    .line 237
    .end local v0    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    return-object v0

    .line 240
    .restart local v0    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    :cond_13
    nop

    .line 241
    :try_start_a
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "refreshToken retryable response code="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    move-object/from16 v5, v18

    :try_start_b
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 242
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getMessage()Ljava/lang/String;

    move-result-object v6

    check-cast v6, Ljava/lang/CharSequence;

    .end local v0    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    if-eqz v6, :cond_15

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_14

    goto :goto_a

    :cond_14
    const/4 v0, 0x0

    goto :goto_b

    :cond_15
    :goto_a
    const/4 v0, 0x1

    :goto_b
    if-nez v0, :cond_16

    const/4 v0, 0x1

    goto :goto_c

    :cond_16
    const/4 v0, 0x0

    .line 241
    :goto_c
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    .line 239
    invoke-static {v10, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    move-object v0, v1

    const v1, 0xc389

    const/4 v11, 0x1

    goto/16 :goto_14

    .line 244
    :catchall_2
    move-exception v0

    goto :goto_d

    :catchall_3
    move-exception v0

    move-object/from16 v5, v18

    :goto_d
    move-object v3, v4

    move-object v4, v8

    .line 245
    .end local v4    # "$result":Ljava/lang/Object;
    .local v0, "e":Ljava/lang/Throwable;
    .restart local v3    # "$result":Ljava/lang/Object;
    :goto_e
    instance-of v6, v0, Ljava/util/concurrent/CancellationException;

    if-nez v6, :cond_23

    .line 246
    invoke-direct {v9, v14}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->isCurrentRefresh(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;)Z

    move-result v6

    if-nez v6, :cond_17

    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v4

    .line 247
    :cond_17
    instance-of v6, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;

    if-eqz v6, :cond_18

    move-object v6, v0

    check-cast v6, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;

    goto :goto_f

    :cond_18
    const/4 v6, 0x0

    .line 248
    .local v6, "responseException":Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;
    :goto_f
    if-eqz v6, :cond_19

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;->getCode()Ljava/lang/Integer;

    move-result-object v8

    goto :goto_10

    :cond_19
    const/4 v8, 0x0

    .line 249
    .local v8, "errorCode":Ljava/lang/Integer;
    :goto_10
    if-eqz v6, :cond_1a

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;->getMsg()Ljava/lang/String;

    move-result-object v6

    .end local v6    # "responseException":Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;
    if-nez v6, :cond_1b

    :cond_1a
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v6

    .line 251
    .local v6, "errorMessage":Ljava/lang/String;
    :cond_1b
    nop

    .line 252
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 p2, v1

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .local p2, "$continuation":Lkotlin/coroutines/Continuation;
    const-string v1, "refreshToken failed code="

    invoke-virtual {v11, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v11, " type="

    invoke-virtual {v1, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v1, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 253
    .end local v0    # "e":Ljava/lang/Throwable;
    move-object v1, v6

    check-cast v1, Ljava/lang/CharSequence;

    if-eqz v1, :cond_1d

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1c

    goto :goto_11

    :cond_1c
    const/4 v1, 0x0

    goto :goto_12

    :cond_1d
    :goto_11
    const/4 v1, 0x1

    :goto_12
    const/4 v11, 0x1

    .line 252
    xor-int/2addr v1, v11

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    .line 250
    invoke-static {v10, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 255
    if-nez v8, :cond_1e

    const v1, 0xc389

    goto :goto_13

    :cond_1e
    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const v1, 0xc389

    if-ne v0, v1, :cond_1f

    .line 256
    .end local v6    # "errorMessage":Ljava/lang/String;
    .end local v8    # "errorCode":Ljava/lang/Integer;
    .end local v12    # "retryIndex":I
    .end local v15    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    invoke-direct {v9, v14, v13}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->notifyUserTokenFailure(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;)V

    .line 257
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .end local v13    # "expectedUserToken":Ljava/lang/String;
    .end local v14    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 259
    .restart local v6    # "errorMessage":Ljava/lang/String;
    .restart local v8    # "errorCode":Ljava/lang/Integer;
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .restart local v12    # "retryIndex":I
    .restart local v13    # "expectedUserToken":Ljava/lang/String;
    .restart local v14    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .restart local v15    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    :cond_1f
    :goto_13
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->APP_AUTH_INVALID_CODES:Ljava/util/Set;

    check-cast v0, Ljava/lang/Iterable;

    invoke-static {v0, v8}, Lkotlin/collections/CollectionsKt;->contains(Ljava/lang/Iterable;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_20

    .line 260
    .end local v12    # "retryIndex":I
    .end local v13    # "expectedUserToken":Ljava/lang/String;
    .end local v15    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    invoke-direct {v9, v14, v8, v6}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->notifyAppAuthExpired(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/Integer;Ljava/lang/String;)V

    .line 261
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .end local v14    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 259
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .restart local v12    # "retryIndex":I
    .restart local v13    # "expectedUserToken":Ljava/lang/String;
    .restart local v14    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .restart local v15    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    :cond_20
    move-object/from16 v0, p2

    move-object v8, v4

    move-object v4, v3

    .line 265
    .end local v3    # "$result":Ljava/lang/Object;
    .end local v6    # "errorMessage":Ljava/lang/String;
    .end local v8    # "errorCode":Ljava/lang/Integer;
    .end local p2    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v0, "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v4    # "$result":Ljava/lang/Object;
    :goto_14
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->WAITING_NETWORK:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-direct {v9, v14, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->markAuthStateIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;)Z

    move-result v3

    if-nez v3, :cond_21

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    .line 266
    :cond_21
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->RETRY_DELAYS_MS:[J

    sget-object v6, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->RETRY_DELAYS_MS:[J

    invoke-static {v6}, Lkotlin/collections/ArraysKt;->getLastIndex([J)I

    move-result v6

    invoke-static {v12, v6}, Lkotlin/ranges/RangesKt;->coerceAtMost(II)I

    move-result v6

    aget-wide v1, v3, v6

    .line 267
    .local v1, "retryDelay":J
    add-int/lit8 v3, v12, 0x1

    .line 268
    .local v3, "attempt":I
    add-int/lit8 v6, v12, 0x1

    sget-object v17, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->RETRY_DELAYS_MS:[J

    invoke-static/range {v17 .. v17}, Lkotlin/collections/ArraysKt;->getLastIndex([J)I

    move-result v11

    invoke-static {v6, v11}, Lkotlin/ranges/RangesKt;->coerceAtMost(II)I

    move-result v6

    .line 269
    .end local v12    # "retryIndex":I
    .local v6, "retryIndex":I
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "refreshToken retry in "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    .end local v3    # "attempt":I
    invoke-static {v10, v11}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 270
    iput-object v9, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$0:Ljava/lang/Object;

    iput-object v15, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$1:Ljava/lang/Object;

    iput-object v14, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$2:Ljava/lang/Object;

    iput-object v13, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->L$3:Ljava/lang/Object;

    iput v6, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->I$0:I

    const/4 v3, 0x5

    iput v3, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshTokenLoop$1;->label:I

    invoke-direct {v9, v1, v2, v0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->waitForRetrySignal(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "retryDelay":J
    if-ne v1, v8, :cond_22

    .line 180
    return-object v8

    .line 270
    :cond_22
    move-object v1, v0

    move-object v3, v4

    move-object v4, v8

    move-object v0, v9

    move-object v12, v14

    move-object v14, v13

    move-object v13, v15

    move v15, v6

    .end local v4    # "$result":Ljava/lang/Object;
    .end local v6    # "retryIndex":I
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v0, "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .local v3, "$result":Ljava/lang/Object;
    .local v12, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .local v13, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .local v14, "expectedUserToken":Ljava/lang/String;
    .local v15, "retryIndex":I
    :goto_15
    move-object/from16 v2, p0

    move-object v6, v5

    const/4 v11, 0x1

    goto/16 :goto_1

    .line 245
    .local v0, "e":Ljava/lang/Throwable;
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local v12, "retryIndex":I
    .local v13, "expectedUserToken":Ljava/lang/String;
    .local v14, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .local v15, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    :cond_23
    throw v0

    .line 272
    .end local v0    # "e":Ljava/lang/Throwable;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .end local v12    # "retryIndex":I
    .end local v13    # "expectedUserToken":Ljava/lang/String;
    .end local v14    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .end local v15    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    :cond_24
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final sameCredential(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "first"    # Ljava/lang/String;
    .param p2, "second"    # Ljava/lang/String;

    .line 477
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->fingerprint(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 478
    .local v0, "firstFingerprint":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x1

    xor-int/2addr v1, v2

    if-eqz v1, :cond_0

    .line 479
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;

    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->fingerprint(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    .line 478
    :goto_0
    return v2
.end method

.method private final stopRemoteRefresh()V
    .locals 4

    .line 279
    monitor-enter p0

    const/4 v0, 0x0

    .line 280
    .local v0, "$i$a$-synchronized-SdkTokenManager$stopRemoteRefresh$1":I
    :try_start_0
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->stop()V

    .line 281
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    const/4 v3, 0x1

    invoke-static {v1, v2, v3, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 282
    :cond_0
    sput-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    .line 283
    const-string v1, ""

    sput-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->activeRefreshKey:Ljava/lang/String;

    .line 284
    nop

    .end local v0    # "$i$a$-synchronized-SdkTokenManager$stopRemoteRefresh$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 279
    monitor-exit p0

    .line 285
    return-void

    .line 279
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private final updateRefreshRequestHeaders(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;Ljava/lang/String;)V
    .locals 10
    .param p1, "deviceInfo"    # Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .param p2, "userToken"    # Ljava/lang/String;

    .line 163
    move-object v0, p2

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    if-eqz v0, :cond_0

    .line 164
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->addUserInfoHeader(Ljava/lang/String;)V

    .line 168
    :cond_0
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    .line 169
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceId()Ljava/lang/String;

    move-result-object v2

    .line 170
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceType()Ljava/lang/String;

    move-result-object v3

    .line 171
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getBtMac()Ljava/lang/String;

    move-result-object v4

    .line 172
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getWifiMac()Ljava/lang/String;

    move-result-object v5

    .line 173
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getP2pMac()Ljava/lang/String;

    move-result-object v6

    .line 174
    nop

    .line 175
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceSubType()Ljava/lang/String;

    move-result-object v8

    .line 176
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getOsVersion()Ljava/lang/String;

    move-result-object v9

    .line 168
    const-string v7, ""

    invoke-virtual/range {v1 .. v9}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->updateDeviceHeaders(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 178
    return-void
.end method

.method private final updateSdkToken(Ljava/lang/String;)V
    .locals 1
    .param p1, "token"    # Ljava/lang/String;

    .line 67
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkToken:Lkotlinx/coroutines/flow/MutableStateFlow;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/base/utils/other/ktx/Kt_ext_flowKt;->call(Lkotlinx/coroutines/flow/MutableStateFlow;Ljava/lang/Object;)V

    .line 68
    return-void
.end method

.method private final waitForRetrySignal(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .param p1, "timeoutMs"    # J
    .param p3, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 275
    new-instance v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$waitForRetrySignal$2;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$waitForRetrySignal$2;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/jvm/functions/Function2;

    invoke-static {p1, p2, v0, p3}, Lkotlinx/coroutines/TimeoutKt;->withTimeoutOrNull(JLkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    .line 276
    return-object v0
.end method


# virtual methods
.method public final applyUserCredentialAndRefresh(Lcom/rokid/security/sdk/base/common/outside/UserInfo;Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;)V
    .locals 2
    .param p1, "userInfo"    # Lcom/rokid/security/sdk/base/common/outside/UserInfo;
    .param p2, "deviceInfo"    # Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    const-string/jumbo v0, "userInfo"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "deviceInfo"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 72
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResultLinearizer:Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;

    new-instance v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;

    invoke-direct {v1, p0, p1, p2}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;-><init>(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Lcom/rokid/security/sdk/base/common/outside/UserInfo;Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;)V

    check-cast v1, Lkotlin/jvm/functions/Function0;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;->transition(Lkotlin/jvm/functions/Function0;)Ljava/lang/Object;

    .line 82
    return-void
.end method

.method public final awaitAuthReady(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/Boolean;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;

    if-eqz v0, :cond_0

    move-object v0, p3

    check-cast v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;

    iget v1, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p3, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;->label:I

    sub-int/2addr p3, v2

    iput p3, v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;

    invoke-direct {v0, p0, p3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;-><init>(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p3, v0

    .local p3, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 330
    iget v2, p3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;->label:I

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p3    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p3    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object p1, v0

    goto :goto_1

    :pswitch_1
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v2, p0

    .line 331
    .local v2, "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    .local p1, "timeoutMs":J
    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->hasUsableAuthHeaders()Z

    move-result v3

    const/4 v4, 0x1

    if-eqz v3, :cond_1

    invoke-static {v4}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v1

    return-object v1

    .line 332
    .end local v2    # "this":Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;
    :cond_1
    new-instance v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$2;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$2;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function2;

    iput v4, p3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$awaitAuthReady$1;->label:I

    invoke-static {p1, p2, v2, p3}, Lkotlinx/coroutines/TimeoutKt;->withTimeoutOrNull(JLkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    .end local p1    # "timeoutMs":J
    if-ne p1, v1, :cond_2

    .line 330
    return-object v1

    .line 332
    :cond_2
    :goto_1
    check-cast p1, Ljava/lang/Boolean;

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    goto :goto_2

    .line 339
    :cond_3
    const/4 p1, 0x0

    :goto_2
    invoke-static {p1}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object p1

    .line 332
    return-object p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final getAuthState()Lkotlinx/coroutines/flow/MutableStateFlow;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/MutableStateFlow<",
            "Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;",
            ">;"
        }
    .end annotation

    .line 58
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    return-object v0
.end method

.method public final getSdkToken()Lkotlinx/coroutines/flow/MutableStateFlow;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/MutableStateFlow<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 64
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkToken:Lkotlinx/coroutines/flow/MutableStateFlow;

    return-object v0
.end method

.method public final invalidateUserCredentialIfCurrent(Ljava/lang/String;Z)Z
    .locals 5
    .param p1, "expectedUserToken"    # Ljava/lang/String;
    .param p2, "publishFailure"    # Z

    const-string v0, "expectedUserToken"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 92
    monitor-enter p0

    const/4 v0, 0x0

    .line 93
    .local v0, "$i$a$-synchronized-SdkTokenManager$invalidateUserCredentialIfCurrent$invalidated$1":I
    :try_start_0
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getUserToken()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    if-nez v1, :cond_1

    const-string v1, ""

    :cond_1
    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    const/4 v1, 0x0

    .line 94
    .local v1, "$i$a$-ifBlank-SdkTokenManager$invalidateUserCredentialIfCurrent$invalidated$1$currentToken$1":I
    sget-object v3, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    const-string/jumbo v4, "x-user-authorization"

    invoke-virtual {v3, v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeader(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    const-string v3, ""

    .line 93
    .end local v1    # "$i$a$-ifBlank-SdkTokenManager$invalidateUserCredentialIfCurrent$invalidated$1$currentToken$1":I
    :cond_2
    move-object v1, v3

    :cond_3
    check-cast v1, Ljava/lang/String;

    .line 96
    .local v1, "currentToken":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-direct {v3, v1, p1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sameCredential(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_4

    const/4 v2, 0x0

    goto :goto_1

    .line 97
    :cond_4
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->stop()V

    .line 98
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    const/4 v4, 0x1

    if-eqz v3, :cond_5

    invoke-static {v3, v2, v4, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 99
    :cond_5
    sput-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    .line 100
    const-string v2, ""

    sput-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->activeRefreshKey:Ljava/lang/String;

    .line 101
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    const-string v3, ""

    invoke-direct {v2, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->updateSdkToken(Ljava/lang/String;)V

    .line 102
    sget-object v2, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    const-string/jumbo v3, "user_token_failure_50057"

    invoke-virtual {v2, v3}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->clearUserAuthorization(Ljava/lang/String;)V

    .line 103
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/auth/UserManager;->clearUserInfo()V

    .line 104
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->INVALID:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    invoke-interface {v2, v3}, Lkotlinx/coroutines/flow/MutableStateFlow;->setValue(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 105
    move v2, v4

    .line 92
    .end local v0    # "$i$a$-synchronized-SdkTokenManager$invalidateUserCredentialIfCurrent$invalidated$1":I
    .end local v1    # "currentToken":Ljava/lang/String;
    :goto_1
    monitor-exit p0

    move v0, v2

    .line 107
    .local v0, "invalidated":Z
    if-eqz v0, :cond_6

    if-eqz p2, :cond_6

    .line 108
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->publishUserCredentialFailureIfStillInvalid()Z

    .line 110
    :cond_6
    return v0

    .line 92
    .end local v0    # "invalidated":Z
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final notifyNetworkAvailable()V
    .locals 2

    .line 321
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->WAITING_NETWORK:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    if-ne v0, v1, :cond_0

    .line 322
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->retrySignal:Lkotlinx/coroutines/channels/Channel;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-interface {v0, v1}, Lkotlinx/coroutines/channels/Channel;->trySend-JP2dKIU(Ljava/lang/Object;)Ljava/lang/Object;

    .line 324
    :cond_0
    return-void
.end method

.method public final publishAuthResultForTest$sdk_common_ability_release(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;)Z
    .locals 1
    .param p1, "isCurrent"    # Lkotlin/jvm/functions/Function0;
    .param p2, "callback"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function0<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)Z"
        }
    .end annotation

    const-string v0, "isCurrent"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "callback"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 501
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResultLinearizer:Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;

    invoke-virtual {v0, p1, p2}, Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;->publishIf(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;)Z

    move-result v0

    return v0
.end method

.method public final publishUserCredentialFailureIfStillInvalid()Z
    .locals 3

    .line 115
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResultLinearizer:Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;

    new-instance v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishUserCredentialFailureIfStillInvalid$1;

    invoke-direct {v1, p0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishUserCredentialFailureIfStillInvalid$1;-><init>(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;)V

    check-cast v1, Lkotlin/jvm/functions/Function0;

    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishUserCredentialFailureIfStillInvalid$2;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishUserCredentialFailureIfStillInvalid$2;

    check-cast v2, Lkotlin/jvm/functions/Function0;

    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;->publishIf(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;)Z

    move-result v0

    .line 122
    return v0
.end method

.method public final refreshToken(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;)V
    .locals 11
    .param p1, "deviceInfo"    # Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    const-string v0, "deviceInfo"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 127
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getUserToken()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    :goto_0
    if-nez v0, :cond_1

    const-string v0, ""

    .line 128
    .local v0, "currentUserToken":Ljava/lang/String;
    :cond_1
    const-string v2, "SdkTokenManager::"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "refreshToken userTokenPresent="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object v4, v0

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v4

    const/4 v5, 0x1

    xor-int/2addr v4, v5

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 129
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_2

    move v2, v5

    goto :goto_1

    :cond_2
    move v2, v3

    :goto_1
    if-eqz v2, :cond_3

    .line 130
    const-string v1, "SdkTokenManager::"

    const-string v2, "refreshToken->1"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 131
    monitor-enter p0

    const/4 v1, 0x0

    .line 132
    .local v1, "$i$a$-synchronized-SdkTokenManager$refreshToken$1":I
    :try_start_0
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->stopRemoteRefresh()V

    .line 133
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    const-string v3, ""

    invoke-direct {v2, p1, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->updateRefreshRequestHeaders(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;Ljava/lang/String;)V

    .line 134
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-direct {v2, p1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->makeSdkToken(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;)V

    .line 135
    nop

    .end local v1    # "$i$a$-synchronized-SdkTokenManager$refreshToken$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 131
    monitor-exit p0

    .line 136
    return-void

    .line 131
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1

    .line 139
    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v4, 0x7c

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v6, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;

    invoke-virtual {v6, v0}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->fingerprint(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v6, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getEnvType()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHost()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 140
    .local v2, "refreshKey":Ljava/lang/String;
    monitor-enter p0

    const/4 v4, 0x0

    .line 144
    .local v4, "$i$a$-synchronized-SdkTokenManager$refreshToken$2":I
    :try_start_1
    sget-object v6, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v6

    if-eqz v6, :cond_4

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getUserToken()Ljava/lang/String;

    move-result-object v6

    goto :goto_2

    :cond_4
    move-object v6, v1

    :goto_2
    if-nez v6, :cond_5

    const-string v6, ""

    :cond_5
    invoke-static {v6, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    if-nez v6, :cond_6

    .end local v4    # "$i$a$-synchronized-SdkTokenManager$refreshToken$2":I
    monitor-exit p0

    return-void

    .line 145
    .restart local v4    # "$i$a$-synchronized-SdkTokenManager$refreshToken$2":I
    :cond_6
    :try_start_2
    sget-object v6, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-direct {v6, p1, v0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->updateRefreshRequestHeaders(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;Ljava/lang/String;)V

    .line 146
    sget-object v6, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    if-eqz v6, :cond_7

    invoke-interface {v6}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v6

    if-ne v6, v5, :cond_7

    move v3, v5

    :cond_7
    if-eqz v3, :cond_9

    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->activeRefreshKey:Ljava/lang/String;

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    .line 147
    const-string v1, "SdkTokenManager::"

    const-string v3, "refreshToken coalesced, wake active task"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 148
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authState:Lkotlinx/coroutines/flow/MutableStateFlow;

    invoke-interface {v1}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v1

    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->REFRESHING:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    if-eq v1, v3, :cond_8

    .line 149
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->retrySignal:Lkotlinx/coroutines/channels/Channel;

    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-interface {v1, v3}, Lkotlinx/coroutines/channels/Channel;->trySend-JP2dKIU(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 151
    :cond_8
    nop

    .end local v4    # "$i$a$-synchronized-SdkTokenManager$refreshToken$2":I
    monitor-exit p0

    return-void

    .line 153
    .restart local v4    # "$i$a$-synchronized-SdkTokenManager$refreshToken$2":I
    :cond_9
    :try_start_3
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    if-eqz v3, :cond_a

    invoke-static {v3, v1, v5, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 154
    :cond_a
    sput-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->activeRefreshKey:Ljava/lang/String;

    .line 155
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshGuard:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    invoke-virtual {v3, v2}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->begin(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;

    move-result-object v3

    .line 156
    .local v3, "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v5

    new-instance v6, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshToken$2$1;

    invoke-direct {v6, p1, v3, v0, v1}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$refreshToken$2$1;-><init>(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v8, v6

    check-cast v8, Lkotlin/jvm/functions/Function2;

    const/4 v9, 0x3

    const/4 v10, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v5 .. v10}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->sdkJob:Lkotlinx/coroutines/Job;

    .line 159
    nop

    .end local v3    # "refreshLease":Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$RefreshLease;
    .end local v4    # "$i$a$-synchronized-SdkTokenManager$refreshToken$2":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 140
    monitor-exit p0

    .line 160
    return-void

    .line 140
    :catchall_1
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public final runCredentialTransitionForTest$sdk_common_ability_release(Lkotlin/jvm/functions/Function0;)V
    .locals 1
    .param p1, "block"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "block"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 504
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->authResultLinearizer:Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/auth/AuthResultLinearizer;->transition(Lkotlin/jvm/functions/Function0;)Ljava/lang/Object;

    .line 505
    return-void
.end method

.method public final setAuthResultFun(Lkotlin/jvm/functions/Function1;)V
    .locals 0
    .param p1, "authResultFun"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 61
    sput-object p1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->mAuthResultFun:Lkotlin/jvm/functions/Function1;

    .line 62
    return-void
.end method
