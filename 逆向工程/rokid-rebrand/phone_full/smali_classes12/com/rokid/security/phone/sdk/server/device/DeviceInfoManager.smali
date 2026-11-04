.class public final Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;
.super Lcom/rokid/security/phone/sdk/api/device/AbsDeviceInfoService;
.source "DeviceInfoManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nDeviceInfoManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 DeviceInfoManager.kt\ncom/rokid/security/phone/sdk/server/device/DeviceInfoManager\n+ 2 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,262:1\n215#2,2:263\n215#2,2:265\n1855#3,2:267\n1855#3,2:269\n*S KotlinDebug\n*F\n+ 1 DeviceInfoManager.kt\ncom/rokid/security/phone/sdk/server/device/DeviceInfoManager\n*L\n125#1:263,2\n130#1:265,2\n220#1:267,2\n230#1:269,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000I\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010%\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0010\u0002\n\u0002\u0008\u000e\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0005*\u0001\t\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u0013\u001a\u00020\u000eH\u0002J\n\u0010\u0014\u001a\u0004\u0018\u00010\u0007H\u0016J\u0006\u0010\u0015\u001a\u00020\u000fJ\u0010\u0010\u0016\u001a\u00020\u000f2\u0006\u0010\u0017\u001a\u00020\u0004H\u0002J\u0006\u0010\u0018\u001a\u00020\u000fJ$\u0010\u0019\u001a\u00020\u000f2\u0006\u0010\u001a\u001a\u00020\u00042\u0012\u0010\u001b\u001a\u000e\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u000f0\rH\u0016J,\u0010\u001c\u001a\u00020\u000f2\u0006\u0010\u001a\u001a\u00020\u00042\u0006\u0010\u001d\u001a\u00020\u001e2\u0012\u0010\u001b\u001a\u000e\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u000f0\rH\u0016J\u0010\u0010\u001f\u001a\u00020\u000f2\u0006\u0010\u0017\u001a\u00020\u0004H\u0002J2\u0010 \u001a\u00020\u000f2\u000e\u0010!\u001a\n\u0012\u0004\u0012\u00020#\u0018\u00010\"2\u000e\u0010$\u001a\n\u0012\u0004\u0012\u00020\u0004\u0018\u00010\"2\u0008\u0010%\u001a\u0004\u0018\u00010\u0004H\u0016J$\u0010&\u001a\u00020\u000f2\u0006\u0010\u001a\u001a\u00020\u00042\u0012\u0010\u001b\u001a\u000e\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u000f0\rH\u0016J$\u0010\'\u001a\u00020\u000f2\u0006\u0010\u001a\u001a\u00020\u00042\u0012\u0010\u001b\u001a\u000e\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u000f0\rH\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0006\u001a\u0004\u0018\u00010\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0008\u001a\u00020\tX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\nR&\u0010\u000b\u001a\u001a\u0012\u0004\u0012\u00020\u0004\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u000f0\r0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R&\u0010\u0010\u001a\u001a\u0012\u0004\u0012\u00020\u0004\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u000f0\r0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R&\u0010\u0011\u001a\u001a\u0012\u0004\u0012\u00020\u0004\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u000f0\r0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R&\u0010\u0012\u001a\u001a\u0012\u0004\u0012\u00020\u0004\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u000f0\r0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006("
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;",
        "Lcom/rokid/security/phone/sdk/api/device/AbsDeviceInfoService;",
        "()V",
        "TAG",
        "",
        "UPDATE_SCOPE_BOOT_APP_ONLY",
        "mDeviceInfo",
        "Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/device/DeviceInfoManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager$mInterMessageListener$1;",
        "mRequestAudioCallbackMap",
        "",
        "Lkotlin/Function1;",
        "",
        "",
        "mRequestVideoCallbackMap",
        "mStopAudioCallbackMap",
        "mStopVideoCallbackMap",
        "checkSetConfigPermission",
        "getGlassDeviceInfo",
        "init",
        "onMessage",
        "msg",
        "release",
        "requestAudioStream",
        "tag",
        "callback",
        "requestVideoStream",
        "videoStreamParam",
        "Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;",
        "setConfig",
        "setDeviceApp",
        "defaultAppsConfig",
        "",
        "Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;",
        "app3rd",
        "bootApp",
        "stopAudioStream",
        "stopVideoStream",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

.field private static final TAG:Ljava/lang/String; = "DeviceInfoManager::"

.field private static final UPDATE_SCOPE_BOOT_APP_ONLY:Ljava/lang/String; = "BOOT_APP_ONLY"

.field private static mDeviceInfo:Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager$mInterMessageListener$1;

.field private static final mRequestAudioCallbackMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final mRequestVideoCallbackMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final mStopAudioCallbackMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final mStopVideoCallbackMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    .line 40
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mRequestVideoCallbackMap:Ljava/util/Map;

    .line 43
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mRequestAudioCallbackMap:Ljava/util/Map;

    .line 46
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mStopVideoCallbackMap:Ljava/util/Map;

    .line 49
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mStopAudioCallbackMap:Ljava/util/Map;

    .line 52
    new-instance v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager$mInterMessageListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/device/AbsDeviceInfoService;-><init>()V

    return-void
.end method

.method public static final synthetic access$onMessage(Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;
    .param p1, "msg"    # Ljava/lang/String;

    .line 34
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->onMessage(Ljava/lang/String;)V

    return-void
.end method

.method private final checkSetConfigPermission()Z
    .locals 2

    .line 188
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v1, "com.r2d2.security.phone.sdk.template"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 189
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v1, "com.rokid.security.phone.sdk.template"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 192
    :cond_0
    const/4 v0, 0x0

    return v0

    .line 190
    :cond_1
    :goto_0
    const/4 v0, 0x1

    return v0
.end method

.method private final onMessage(Ljava/lang/String;)V
    .locals 11
    .param p1, "msg"    # Ljava/lang/String;

    .line 76
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "DEVICE_INFO"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    const-string v1, "DeviceInfoManager::"

    if-eqz v0, :cond_3

    .line 77
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onMessage->"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 79
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const/4 v1, 0x0

    .local v1, "version":Ljava/lang/Object;
    const-string/jumbo v3, "version"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 80
    move-object v4, v1

    check-cast v4, Ljava/lang/CharSequence;

    if-eqz v4, :cond_0

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    if-nez v4, :cond_1

    :cond_0
    const/4 v2, 0x1

    :cond_1
    if-eqz v2, :cond_2

    .line 81
    const-string v1, "1.0"

    .line 84
    :cond_2
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    const-class v4, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v2, p1, v4}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 85
    .local v2, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v4

    .line 86
    .local v4, "extra":Ljava/lang/String;
    const/4 v5, 0x0

    .local v5, "mDeviceExtra":Ljava/lang/Object;
    sget-object v6, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v6

    const-class v7, Lcom/rokid/security/sdk/base/common/DeviceExtra;

    invoke-virtual {v6, v4, v7}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v5

    .line 90
    sget-object v6, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    move-object v7, v5

    check-cast v7, Lcom/rokid/security/sdk/base/common/DeviceExtra;

    invoke-virtual {v7}, Lcom/rokid/security/sdk/base/common/DeviceExtra;->getCapabilities()Ljava/util/List;

    move-result-object v7

    check-cast v7, Ljava/util/Collection;

    invoke-virtual {v6, v7}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->onCapabilitiesReceived(Ljava/util/Collection;)V

    .line 92
    new-instance v6, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    invoke-direct {v6}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;-><init>()V

    move-object v7, v6

    .local v7, "$this$onMessage_u24lambda_u240":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    const/4 v8, 0x0

    .line 93
    .local v8, "$i$a$-apply-DeviceInfoManager$onMessage$deviceInfo$1":I
    move-object v9, v5

    check-cast v9, Lcom/rokid/security/sdk/base/common/DeviceExtra;

    invoke-virtual {v9}, Lcom/rokid/security/sdk/base/common/DeviceExtra;->getDeviceId()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->setDeviceId(Ljava/lang/String;)V

    .line 94
    move-object v9, v5

    check-cast v9, Lcom/rokid/security/sdk/base/common/DeviceExtra;

    invoke-virtual {v9}, Lcom/rokid/security/sdk/base/common/DeviceExtra;->getDeviceType()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->setDeviceType(Ljava/lang/String;)V

    .line 95
    move-object v9, v5

    check-cast v9, Lcom/rokid/security/sdk/base/common/DeviceExtra;

    invoke-virtual {v9}, Lcom/rokid/security/sdk/base/common/DeviceExtra;->getDeviceSubType()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->setDeviceSubType(Ljava/lang/String;)V

    .line 96
    move-object v9, v5

    check-cast v9, Lcom/rokid/security/sdk/base/common/DeviceExtra;

    invoke-virtual {v9}, Lcom/rokid/security/sdk/base/common/DeviceExtra;->getBtMac()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->setBtMac(Ljava/lang/String;)V

    .line 97
    move-object v9, v5

    check-cast v9, Lcom/rokid/security/sdk/base/common/DeviceExtra;

    invoke-virtual {v9}, Lcom/rokid/security/sdk/base/common/DeviceExtra;->getWifiMac()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->setWifiMac(Ljava/lang/String;)V

    .line 98
    move-object v9, v5

    check-cast v9, Lcom/rokid/security/sdk/base/common/DeviceExtra;

    invoke-virtual {v9}, Lcom/rokid/security/sdk/base/common/DeviceExtra;->getP2pMac()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->setP2pMac(Ljava/lang/String;)V

    .line 99
    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v7, v1}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->setVersion(Ljava/lang/String;)V

    .line 100
    move-object v3, v5

    check-cast v3, Lcom/rokid/security/sdk/base/common/DeviceExtra;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/DeviceExtra;->getOsVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v7, v3}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->setOsVersion(Ljava/lang/String;)V

    .line 101
    nop

    .line 92
    .end local v7    # "$this$onMessage_u24lambda_u240":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .end local v8    # "$i$a$-apply-DeviceInfoManager$onMessage$deviceInfo$1":I
    move-object v3, v6

    .line 103
    .local v3, "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    sput-object v3, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mDeviceInfo:Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    .line 105
    sget-object v6, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-virtual {v6, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshToken(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;)V

    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "version":Ljava/lang/Object;
    .end local v2    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v3    # "deviceInfo":Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .end local v4    # "extra":Ljava/lang/String;
    .end local v5    # "mDeviceExtra":Ljava/lang/Object;
    goto/16 :goto_2

    .line 106
    :cond_3
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v5, "VIDEO_STREAM_RESP"

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v0, v5, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    const-string/jumbo v5, "stop"

    const-string/jumbo v6, "start"

    if-eqz v0, :cond_5

    .line 107
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v2, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 108
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v2

    .line 109
    .local v2, "extra":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    const-class v4, Lcom/rokid/security/sdk/base/common/VideoStreamResp;

    invoke-virtual {v3, v2, v4}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/sdk/base/common/VideoStreamResp;

    .line 110
    .local v3, "videoStreamParamExtra":Lcom/rokid/security/sdk/base/common/VideoStreamResp;
    if-eqz v3, :cond_4

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/VideoStreamResp;->getAction()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 111
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " VIDEO_STREAM_RESP start --- isSuccess = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/VideoStreamResp;->isSuccess()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 113
    nop

    .line 112
    sget-object v1, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mRequestVideoCallbackMap:Ljava/util/Map;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/VideoStreamResp;->getTag()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lkotlin/jvm/functions/Function1;

    .line 113
    if-eqz v1, :cond_9

    .line 112
    nop

    .line 113
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/VideoStreamResp;->isSuccess()Z

    move-result v4

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-interface {v1, v4}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_2

    .line 114
    :cond_4
    if-eqz v3, :cond_9

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/VideoStreamResp;->getAction()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_9

    .line 115
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " VIDEO_STREAM_RESP stop --- isSuccess = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/VideoStreamResp;->isSuccess()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 117
    nop

    .line 116
    sget-object v1, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mStopVideoCallbackMap:Ljava/util/Map;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/VideoStreamResp;->getTag()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lkotlin/jvm/functions/Function1;

    .line 117
    if-eqz v1, :cond_9

    .line 116
    nop

    .line 117
    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/VideoStreamResp;->isSuccess()Z

    move-result v4

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-interface {v1, v4}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_2

    .line 119
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v2    # "extra":Ljava/lang/String;
    .end local v3    # "videoStreamParamExtra":Lcom/rokid/security/sdk/base/common/VideoStreamResp;
    :cond_5
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v7, "AUDIO_STREAM_RESP"

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v0, v7, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 120
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v2, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 121
    .restart local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v2

    .line 122
    .restart local v2    # "extra":Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "audioStreamResp":Ljava/lang/Object;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    const-class v7, Lcom/rokid/security/sdk/base/common/AudioStreamResp;

    invoke-virtual {v4, v2, v7}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    .line 123
    if-eqz v3, :cond_7

    move-object v4, v3

    check-cast v4, Lcom/rokid/security/sdk/base/common/AudioStreamResp;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/AudioStreamResp;->getAction()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 124
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " AUDIO_STREAM_RESP start --- isSuccess = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object v5, v3

    check-cast v5, Lcom/rokid/security/sdk/base/common/AudioStreamResp;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/AudioStreamResp;->isSuccess()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 125
    sget-object v1, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mRequestAudioCallbackMap:Ljava/util/Map;

    .local v1, "$this$forEach$iv":Ljava/util/Map;
    const/4 v4, 0x0

    .line 263
    .local v4, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_6

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Map$Entry;

    .local v6, "element$iv":Ljava/util/Map$Entry;
    move-object v7, v6

    .local v7, "it":Ljava/util/Map$Entry;
    const/4 v8, 0x0

    .line 126
    .local v8, "$i$a$-forEach-DeviceInfoManager$onMessage$1":I
    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lkotlin/jvm/functions/Function1;

    move-object v10, v3

    check-cast v10, Lcom/rokid/security/sdk/base/common/AudioStreamResp;

    invoke-virtual {v10}, Lcom/rokid/security/sdk/base/common/AudioStreamResp;->isSuccess()Z

    move-result v10

    invoke-static {v10}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    invoke-interface {v9, v10}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 127
    nop

    .line 263
    .end local v7    # "it":Ljava/util/Map$Entry;
    .end local v8    # "$i$a$-forEach-DeviceInfoManager$onMessage$1":I
    nop

    .end local v6    # "element$iv":Ljava/util/Map$Entry;
    goto :goto_0

    .line 264
    :cond_6
    nop

    .end local v1    # "$this$forEach$iv":Ljava/util/Map;
    .end local v4    # "$i$f$forEach":I
    goto :goto_2

    .line 128
    :cond_7
    if-eqz v3, :cond_9

    move-object v4, v3

    check-cast v4, Lcom/rokid/security/sdk/base/common/AudioStreamResp;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/AudioStreamResp;->getAction()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_9

    .line 129
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " AUDIO_STREAM_RESP stop --- isSuccess = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object v5, v3

    check-cast v5, Lcom/rokid/security/sdk/base/common/AudioStreamResp;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/AudioStreamResp;->isSuccess()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 130
    sget-object v1, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mStopAudioCallbackMap:Ljava/util/Map;

    .restart local v1    # "$this$forEach$iv":Ljava/util/Map;
    const/4 v4, 0x0

    .line 265
    .restart local v4    # "$i$f$forEach":I
    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_8

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Map$Entry;

    .restart local v6    # "element$iv":Ljava/util/Map$Entry;
    move-object v7, v6

    .restart local v7    # "it":Ljava/util/Map$Entry;
    const/4 v8, 0x0

    .line 131
    .local v8, "$i$a$-forEach-DeviceInfoManager$onMessage$2":I
    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lkotlin/jvm/functions/Function1;

    move-object v10, v3

    check-cast v10, Lcom/rokid/security/sdk/base/common/AudioStreamResp;

    invoke-virtual {v10}, Lcom/rokid/security/sdk/base/common/AudioStreamResp;->isSuccess()Z

    move-result v10

    invoke-static {v10}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    invoke-interface {v9, v10}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 132
    nop

    .line 265
    .end local v7    # "it":Ljava/util/Map$Entry;
    .end local v8    # "$i$a$-forEach-DeviceInfoManager$onMessage$2":I
    nop

    .end local v6    # "element$iv":Ljava/util/Map$Entry;
    goto :goto_1

    .line 266
    :cond_8
    nop

    .line 135
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "$this$forEach$iv":Ljava/util/Map;
    .end local v2    # "extra":Ljava/lang/String;
    .end local v3    # "audioStreamResp":Ljava/lang/Object;
    .end local v4    # "$i$f$forEach":I
    :cond_9
    :goto_2
    return-void
.end method

.method private final setConfig(Ljava/lang/String;)V
    .locals 12
    .param p1, "msg"    # Ljava/lang/String;

    .line 195
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->checkSetConfigPermission()Z

    move-result v0

    if-nez v0, :cond_0

    .line 196
    return-void

    .line 198
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;

    const-string v1, "5.0"

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->isGlassVersionLowerTarget(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 199
    new-instance v0, Lcom/rokid/security/sdk/base/common/InnerCustomMessage;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/InnerCustomMessage;-><init>()V

    move-object v1, v0

    .local v1, "$this$setConfig_u24lambda_u247":Lcom/rokid/security/sdk/base/common/InnerCustomMessage;
    const/4 v2, 0x0

    .line 200
    .local v2, "$i$a$-apply-DeviceInfoManager$setConfig$customMessage$1":I
    const-string v3, "SEND_CONFIG"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/InnerCustomMessage;->setType(Ljava/lang/String;)V

    .line 201
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/InnerCustomMessage;->setMessage(Ljava/lang/String;)V

    .line 202
    nop

    .line 199
    .end local v1    # "$this$setConfig_u24lambda_u247":Lcom/rokid/security/sdk/base/common/InnerCustomMessage;
    .end local v2    # "$i$a$-apply-DeviceInfoManager$setConfig$customMessage$1":I
    nop

    .line 203
    .local v0, "customMessage":Lcom/rokid/security/sdk/base/common/InnerCustomMessage;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "mGson.toJson(customMessage)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v3, "RokidESecurity"

    invoke-virtual {v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->sendTextMessageByClassicBT(Ljava/lang/String;Ljava/lang/String;)V

    .end local v0    # "customMessage":Lcom/rokid/security/sdk/base/common/InnerCustomMessage;
    goto :goto_0

    .line 205
    :cond_1
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const/16 v10, 0xc

    const/4 v11, 0x0

    const-string v5, "DEVICE_CONFIG"

    const/4 v7, 0x0

    const/4 v8, 0x0

    const-string v9, "RokidESecurity"

    move-object v6, p1

    invoke-static/range {v4 .. v11}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 207
    :goto_0
    return-void
.end method


# virtual methods
.method public getGlassDeviceInfo()Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;
    .locals 1

    .line 143
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mDeviceInfo:Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    return-object v0
.end method

.method public final init()V
    .locals 2

    .line 138
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 139
    return-void
.end method

.method public final release()V
    .locals 2

    .line 259
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 260
    return-void
.end method

.method public requestAudioStream(Ljava/lang/String;Lkotlin/jvm/functions/Function1;)V
    .locals 9
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "callback"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "callback"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 161
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mRequestAudioCallbackMap:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 162
    new-instance v0, Lcom/rokid/security/sdk/base/common/AudioStreamReq;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AudioStreamReq;-><init>()V

    move-object v1, v0

    .local v1, "$this$requestAudioStream_u24lambda_u244":Lcom/rokid/security/sdk/base/common/AudioStreamReq;
    const/4 v2, 0x0

    .line 163
    .local v2, "$i$a$-apply-DeviceInfoManager$requestAudioStream$audioStreamReq$1":I
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/AudioStreamReq;->setTag(Ljava/lang/String;)V

    .line 164
    const-string/jumbo v3, "start"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AudioStreamReq;->setAction(Ljava/lang/String;)V

    .line 165
    nop

    .line 162
    .end local v1    # "$this$requestAudioStream_u24lambda_u244":Lcom/rokid/security/sdk/base/common/AudioStreamReq;
    .end local v2    # "$i$a$-apply-DeviceInfoManager$requestAudioStream$audioStreamReq$1":I
    nop

    .line 166
    .local v0, "audioStreamReq":Lcom/rokid/security/sdk/base/common/AudioStreamReq;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v2, "mGson.toJson(audioStreamReq)"

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v7, 0x1c

    const/4 v8, 0x0

    const-string v2, "AUDIO_STREAM_REQ"

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v1 .. v8}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 167
    return-void
.end method

.method public requestVideoStream(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;Lkotlin/jvm/functions/Function1;)V
    .locals 9
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "videoStreamParam"    # Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;
    .param p3, "callback"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "videoStreamParam"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "callback"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 151
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mRequestVideoCallbackMap:Ljava/util/Map;

    invoke-interface {v0, p1, p3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 152
    new-instance v0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/VideoStreamReq;-><init>()V

    move-object v1, v0

    .local v1, "$this$requestVideoStream_u24lambda_u243":Lcom/rokid/security/sdk/base/common/VideoStreamReq;
    const/4 v2, 0x0

    .line 153
    .local v2, "$i$a$-apply-DeviceInfoManager$requestVideoStream$videoStreamReq$1":I
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->setTag(Ljava/lang/String;)V

    .line 154
    const-string/jumbo v3, "start"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->setAction(Ljava/lang/String;)V

    .line 155
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->setVideoStreamParam(Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;)V

    .line 156
    nop

    .line 152
    .end local v1    # "$this$requestVideoStream_u24lambda_u243":Lcom/rokid/security/sdk/base/common/VideoStreamReq;
    .end local v2    # "$i$a$-apply-DeviceInfoManager$requestVideoStream$videoStreamReq$1":I
    nop

    .line 157
    .local v0, "videoStreamReq":Lcom/rokid/security/sdk/base/common/VideoStreamReq;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v2, "mGson.toJson(videoStreamReq)"

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v7, 0x1c

    const/4 v8, 0x0

    const-string v2, "VIDEO_STREAM_REQ"

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v1 .. v8}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 158
    return-void
.end method

.method public setDeviceApp(Ljava/util/List;Ljava/util/List;Ljava/lang/String;)V
    .locals 23
    .param p1, "defaultAppsConfig"    # Ljava/util/List;
    .param p2, "app3rd"    # Ljava/util/List;
    .param p3, "bootApp"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;",
            ">;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 217
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object v15, v0

    .line 218
    .local v15, "showToHideApps":Ljava/util/ArrayList;
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object v14, v0

    .line 219
    .local v14, "showToHide":Ljava/util/ArrayList;
    const/4 v7, 0x0

    if-eqz p1, :cond_2

    move-object/from16 v0, p1

    .local v0, "it":Ljava/util/List;
    const/4 v1, 0x0

    .line 220
    .local v1, "$i$a$-let-DeviceInfoManager$setDeviceApp$1":I
    move-object/from16 v2, p1

    check-cast v2, Ljava/lang/Iterable;

    .local v2, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 267
    .local v3, "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;

    .local v6, "it":Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;
    const/4 v8, 0x0

    .line 221
    .local v8, "$i$a$-forEach-DeviceInfoManager$setDeviceApp$1$1":I
    new-instance v9, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->getKey()Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    move-result-object v10

    invoke-virtual {v10}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->getAppKey()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->getRename()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide()Z

    move-result v12

    invoke-direct {v9, v10, v11, v7, v12}, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;-><init>(Ljava/lang/String;Ljava/lang/String;IZ)V

    invoke-virtual {v15, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 222
    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide()Z

    move-result v9

    if-eqz v9, :cond_0

    .line 223
    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->getKey()Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    move-result-object v9

    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->getAppKey()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v14, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 225
    :cond_0
    nop

    .line 267
    .end local v6    # "it":Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;
    .end local v8    # "$i$a$-forEach-DeviceInfoManager$setDeviceApp$1$1":I
    nop

    .end local v5    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 268
    :cond_1
    nop

    .line 226
    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$forEach":I
    nop

    .line 219
    .end local v0    # "it":Ljava/util/List;
    .end local v1    # "$i$a$-let-DeviceInfoManager$setDeviceApp$1":I
    nop

    .line 228
    :cond_2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object v13, v0

    .line 229
    .local v13, "thirdApps":Ljava/util/ArrayList;
    if-eqz p2, :cond_4

    move-object/from16 v0, p2

    .local v0, "list":Ljava/util/List;
    const/4 v1, 0x0

    .line 230
    .local v1, "$i$a$-let-DeviceInfoManager$setDeviceApp$2":I
    move-object v2, v0

    check-cast v2, Ljava/lang/Iterable;

    .restart local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 269
    .restart local v3    # "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .restart local v5    # "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Ljava/lang/String;

    .local v6, "item":Ljava/lang/String;
    const/4 v8, 0x0

    .line 231
    .local v8, "$i$a$-forEach-DeviceInfoManager$setDeviceApp$2$1":I
    new-instance v9, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    const/16 v21, 0x8

    const/16 v22, 0x0

    const-string v18, ""

    const/16 v19, 0x0

    const/16 v20, 0x0

    move-object/from16 v16, v9

    move-object/from16 v17, v6

    invoke-direct/range {v16 .. v22}, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;-><init>(Ljava/lang/String;Ljava/lang/String;IZILkotlin/jvm/internal/DefaultConstructorMarker;)V

    invoke-virtual {v13, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 232
    nop

    .line 269
    .end local v6    # "item":Ljava/lang/String;
    .end local v8    # "$i$a$-forEach-DeviceInfoManager$setDeviceApp$2$1":I
    nop

    .end local v5    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 270
    :cond_3
    nop

    .line 233
    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$forEach":I
    nop

    .line 229
    .end local v0    # "list":Ljava/util/List;
    .end local v1    # "$i$a$-let-DeviceInfoManager$setDeviceApp$2":I
    nop

    .line 234
    :cond_4
    const/4 v0, 0x0

    .local v0, "bootupApp":Ljava/lang/Object;
    new-instance v1, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    const/16 v21, 0x8

    const/16 v22, 0x0

    const-string v17, ""

    const-string v18, ""

    const/16 v19, 0x0

    const/16 v20, 0x0

    move-object/from16 v16, v1

    invoke-direct/range {v16 .. v22}, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;-><init>(Ljava/lang/String;Ljava/lang/String;IZILkotlin/jvm/internal/DefaultConstructorMarker;)V

    move-object v8, v1

    .line 235
    .end local v0    # "bootupApp":Ljava/lang/Object;
    .local v8, "bootupApp":Ljava/lang/Object;
    if-eqz p3, :cond_5

    move-object/from16 v1, p3

    .local v1, "it":Ljava/lang/String;
    const/4 v9, 0x0

    .line 236
    .local v9, "$i$a$-let-DeviceInfoManager$setDeviceApp$3":I
    new-instance v10, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    const/16 v5, 0x8

    const/4 v6, 0x0

    const-string v2, ""

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, v10

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;-><init>(Ljava/lang/String;Ljava/lang/String;IZILkotlin/jvm/internal/DefaultConstructorMarker;)V

    move-object v8, v10

    .line 237
    nop

    .line 235
    .end local v1    # "it":Ljava/lang/String;
    .end local v9    # "$i$a$-let-DeviceInfoManager$setDeviceApp$3":I
    nop

    :cond_5
    move-object v0, v8

    .line 238
    .end local v8    # "bootupApp":Ljava/lang/Object;
    .restart local v0    # "bootupApp":Ljava/lang/Object;
    if-eqz p3, :cond_a

    .line 239
    move-object/from16 v1, p1

    check-cast v1, Ljava/util/Collection;

    const/4 v2, 0x1

    if-eqz v1, :cond_7

    invoke-interface {v1}, Ljava/util/Collection;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_6

    goto :goto_2

    :cond_6
    move v1, v7

    goto :goto_3

    :cond_7
    :goto_2
    move v1, v2

    :goto_3
    if-eqz v1, :cond_a

    .line 240
    move-object/from16 v1, p2

    check-cast v1, Ljava/util/Collection;

    if-eqz v1, :cond_9

    invoke-interface {v1}, Ljava/util/Collection;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_8

    goto :goto_4

    :cond_8
    move v1, v7

    goto :goto_5

    :cond_9
    :goto_4
    move v1, v2

    :goto_5
    if-eqz v1, :cond_a

    move v7, v2

    goto :goto_6

    :cond_a
    nop

    .line 238
    :goto_6
    move/from16 v16, v7

    .line 242
    .local v16, "bootAppOnly":Z
    nop

    .line 244
    if-eqz v16, :cond_b

    const-string v1, "BOOT_APP_ONLY"

    goto :goto_7

    :cond_b
    const-string v1, ""

    :goto_7
    move-object v3, v1

    .line 241
    new-instance v17, Lcom/rokid/security/sdk/base/common/outside/Config;

    .line 243
    nop

    .line 244
    nop

    .line 241
    nop

    .line 245
    nop

    .line 241
    nop

    .line 246
    nop

    .line 242
    nop

    .line 241
    nop

    .line 242
    nop

    .line 241
    const/16 v18, 0x26c

    const/16 v19, 0x0

    const/4 v2, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, -0x1

    const/4 v11, 0x0

    move-object/from16 v1, v17

    move-object v6, v14

    move-object v10, v15

    move-object v12, v13

    move-object/from16 v20, v13

    .end local v13    # "thirdApps":Ljava/util/ArrayList;
    .local v20, "thirdApps":Ljava/util/ArrayList;
    move-object v13, v0

    move-object/from16 v21, v14

    .end local v14    # "showToHide":Ljava/util/ArrayList;
    .local v21, "showToHide":Ljava/util/ArrayList;
    move/from16 v14, v18

    move-object/from16 v18, v15

    .end local v15    # "showToHideApps":Ljava/util/ArrayList;
    .local v18, "showToHideApps":Ljava/util/ArrayList;
    move-object/from16 v15, v19

    invoke-direct/range {v1 .. v15}, Lcom/rokid/security/sdk/base/common/outside/Config;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 248
    .local v1, "config":Lcom/rokid/security/sdk/base/common/outside/Config;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;

    const-string v3, "5.0"

    invoke-virtual {v2, v3}, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->isGlassVersionLowerTarget(Ljava/lang/String;)Z

    move-result v2

    const-string v3, "mGson.toJson(config)"

    if-eqz v2, :cond_c

    .line 249
    new-instance v2, Lcom/rokid/security/sdk/base/common/InnerCustomMessage;

    invoke-direct {v2}, Lcom/rokid/security/sdk/base/common/InnerCustomMessage;-><init>()V

    move-object v4, v2

    .local v4, "$this$setDeviceApp_u24lambda_u2413":Lcom/rokid/security/sdk/base/common/InnerCustomMessage;
    const/4 v5, 0x0

    .line 250
    .local v5, "$i$a$-apply-DeviceInfoManager$setDeviceApp$customMessage$1":I
    const-string v6, "SEND_CONFIG"

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/InnerCustomMessage;->setType(Ljava/lang/String;)V

    .line 251
    sget-object v6, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v6

    invoke-virtual {v6, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/InnerCustomMessage;->setMessage(Ljava/lang/String;)V

    .line 252
    nop

    .line 249
    .end local v4    # "$this$setDeviceApp_u24lambda_u2413":Lcom/rokid/security/sdk/base/common/InnerCustomMessage;
    .end local v5    # "$i$a$-apply-DeviceInfoManager$setDeviceApp$customMessage$1":I
    nop

    .line 253
    .local v2, "customMessage":Lcom/rokid/security/sdk/base/common/InnerCustomMessage;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    invoke-virtual {v4, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "mGson.toJson(customMessage)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v5, "RokidESecurity"

    invoke-virtual {v3, v4, v5}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->sendTextMessageByClassicBT(Ljava/lang/String;Ljava/lang/String;)V

    .end local v2    # "customMessage":Lcom/rokid/security/sdk/base/common/InnerCustomMessage;
    goto :goto_8

    .line 255
    :cond_c
    sget-object v6, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v12, 0xc

    const/4 v13, 0x0

    const-string v7, "DEVICE_CONFIG"

    const/4 v9, 0x0

    const/4 v10, 0x0

    const-string v11, "RokidESecurity"

    invoke-static/range {v6 .. v13}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 257
    :goto_8
    return-void
.end method

.method public stopAudioStream(Ljava/lang/String;Lkotlin/jvm/functions/Function1;)V
    .locals 9
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "callback"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "callback"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 179
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mStopAudioCallbackMap:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 180
    new-instance v0, Lcom/rokid/security/sdk/base/common/AudioStreamReq;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AudioStreamReq;-><init>()V

    move-object v1, v0

    .local v1, "$this$stopAudioStream_u24lambda_u246":Lcom/rokid/security/sdk/base/common/AudioStreamReq;
    const/4 v2, 0x0

    .line 181
    .local v2, "$i$a$-apply-DeviceInfoManager$stopAudioStream$audioStreamReq$1":I
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/AudioStreamReq;->setTag(Ljava/lang/String;)V

    .line 182
    const-string/jumbo v3, "stop"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AudioStreamReq;->setAction(Ljava/lang/String;)V

    .line 183
    nop

    .line 180
    .end local v1    # "$this$stopAudioStream_u24lambda_u246":Lcom/rokid/security/sdk/base/common/AudioStreamReq;
    .end local v2    # "$i$a$-apply-DeviceInfoManager$stopAudioStream$audioStreamReq$1":I
    nop

    .line 184
    .local v0, "audioStreamReq":Lcom/rokid/security/sdk/base/common/AudioStreamReq;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v2, "mGson.toJson(audioStreamReq)"

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v7, 0x1c

    const/4 v8, 0x0

    const-string v2, "AUDIO_STREAM_REQ"

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v1 .. v8}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 185
    return-void
.end method

.method public stopVideoStream(Ljava/lang/String;Lkotlin/jvm/functions/Function1;)V
    .locals 9
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "callback"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "callback"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 170
    sget-object v0, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->mStopVideoCallbackMap:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 171
    new-instance v0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/VideoStreamReq;-><init>()V

    move-object v1, v0

    .local v1, "$this$stopVideoStream_u24lambda_u245":Lcom/rokid/security/sdk/base/common/VideoStreamReq;
    const/4 v2, 0x0

    .line 172
    .local v2, "$i$a$-apply-DeviceInfoManager$stopVideoStream$videoStreamReq$1":I
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->setTag(Ljava/lang/String;)V

    .line 173
    const-string/jumbo v3, "stop"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->setAction(Ljava/lang/String;)V

    .line 174
    nop

    .line 171
    .end local v1    # "$this$stopVideoStream_u24lambda_u245":Lcom/rokid/security/sdk/base/common/VideoStreamReq;
    .end local v2    # "$i$a$-apply-DeviceInfoManager$stopVideoStream$videoStreamReq$1":I
    nop

    .line 175
    .local v0, "videoStreamReq":Lcom/rokid/security/sdk/base/common/VideoStreamReq;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v2, "mGson.toJson(videoStreamReq)"

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v7, 0x1c

    const/4 v8, 0x0

    const-string v2, "VIDEO_STREAM_REQ"

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v1 .. v8}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 176
    return-void
.end method
