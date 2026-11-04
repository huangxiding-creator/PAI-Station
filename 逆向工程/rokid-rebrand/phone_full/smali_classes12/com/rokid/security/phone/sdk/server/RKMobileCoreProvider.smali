.class public final Lcom/rokid/security/phone/sdk/server/RKMobileCoreProvider;
.super Landroid/content/ContentProvider;
.source "RKMobileCoreProvider.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000:\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0011\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0006\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J1\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u00082\u0010\u0010\t\u001a\u000c\u0012\u0006\u0008\u0001\u0012\u00020\u0008\u0018\u00010\nH\u0016\u00a2\u0006\u0002\u0010\u000bJ\u0012\u0010\u000c\u001a\u0004\u0018\u00010\u00082\u0006\u0010\u0005\u001a\u00020\u0006H\u0016J\u001c\u0010\r\u001a\u0004\u0018\u00010\u00062\u0006\u0010\u0005\u001a\u00020\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u000eH\u0016J\u0008\u0010\u000f\u001a\u00020\u0010H\u0016JO\u0010\u0011\u001a\u0004\u0018\u00010\u00122\u0006\u0010\u0005\u001a\u00020\u00062\u0010\u0010\u0007\u001a\u000c\u0012\u0006\u0008\u0001\u0012\u00020\u0008\u0018\u00010\n2\u0008\u0010\t\u001a\u0004\u0018\u00010\u00082\u0010\u0010\u0013\u001a\u000c\u0012\u0006\u0008\u0001\u0012\u00020\u0008\u0018\u00010\n2\u0008\u0010\u0014\u001a\u0004\u0018\u00010\u0008H\u0016\u00a2\u0006\u0002\u0010\u0015J;\u0010\u0016\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u000e2\u0008\u0010\t\u001a\u0004\u0018\u00010\u00082\u0010\u0010\u0013\u001a\u000c\u0012\u0006\u0008\u0001\u0012\u00020\u0008\u0018\u00010\nH\u0016\u00a2\u0006\u0002\u0010\u0017\u00a8\u0006\u0018"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/RKMobileCoreProvider;",
        "Landroid/content/ContentProvider;",
        "()V",
        "delete",
        "",
        "p0",
        "Landroid/net/Uri;",
        "p1",
        "",
        "p2",
        "",
        "(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I",
        "getType",
        "insert",
        "Landroid/content/ContentValues;",
        "onCreate",
        "",
        "query",
        "Landroid/database/Cursor;",
        "p3",
        "p4",
        "(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;",
        "update",
        "(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I",
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


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 56
    invoke-direct {p0}, Landroid/content/ContentProvider;-><init>()V

    return-void
.end method


# virtual methods
.method public delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 1
    .param p1, "p0"    # Landroid/net/Uri;
    .param p2, "p1"    # Ljava/lang/String;
    .param p3, "p2"    # [Ljava/lang/String;

    const-string v0, "p0"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 104
    const/4 v0, 0x0

    return v0
.end method

.method public getType(Landroid/net/Uri;)Ljava/lang/String;
    .locals 1
    .param p1, "p0"    # Landroid/net/Uri;

    const-string v0, "p0"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 96
    const/4 v0, 0x0

    return-object v0
.end method

.method public insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 1
    .param p1, "p0"    # Landroid/net/Uri;
    .param p2, "p1"    # Landroid/content/ContentValues;

    const-string v0, "p0"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 100
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()Z
    .locals 2

    const-class v0, Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;

    .line 58
    sget-object v1, Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/wifip2p/api/AbsP2PClientService;

    .line 59
    sget-object v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;

    .line 60
    sget-object v1, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/track/api/AbsTrackService;

    .line 62
    sget-object v1, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/recog/online/api/AbsOnlineRecService;

    .line 63
    sget-object v1, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/recog/offline/api/AbsOfflineRecService;

    .line 64
    sget-object v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/collect/api/AbsCollectService;

    .line 65
    sget-object v1, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/translate/api/AbsTranslateService;

    .line 66
    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/aichat/api/AbsAIChatService;

    .line 67
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/auth/api/AbsAuthService;

    .line 68
    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/provision/api/AbsProvisionService;

    .line 69
    sget-object v1, Lcom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/camera/AbsMediaService;

    .line 70
    sget-object v1, Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/bluetooth/ble/api/AbsBleClientService;

    .line 71
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;

    .line 72
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/ota/AbsOtaEngineService;

    .line 73
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/AbsBluetoothRingService;

    .line 74
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/filesystem/api/AbsFileSystemService;

    .line 75
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/filedownload/AbsFileDownloadService;

    .line 76
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/notification/api/AbsNotificationService;

    .line 77
    sget-object v1, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/log/api/AbsSdkLogService;

    .line 78
    sget-object v1, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/device/AbsDeviceInfoService;

    .line 79
    sget-object v1, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    const-class v0, Lcom/rokid/security/phone/sdk/api/aichat/api/AbsIdentificationService;

    .line 80
    sget-object v1, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/SecurityServiceManager;->injectService(Ljava/lang/Class;Ljava/lang/Object;)V

    .line 82
    const/4 v0, 0x1

    return v0
.end method

.method public query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .locals 1
    .param p1, "p0"    # Landroid/net/Uri;
    .param p2, "p1"    # [Ljava/lang/String;
    .param p3, "p2"    # Ljava/lang/String;
    .param p4, "p3"    # [Ljava/lang/String;
    .param p5, "p4"    # Ljava/lang/String;

    const-string v0, "p0"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 92
    const/4 v0, 0x0

    return-object v0
.end method

.method public update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 1
    .param p1, "p0"    # Landroid/net/Uri;
    .param p2, "p1"    # Landroid/content/ContentValues;
    .param p3, "p2"    # Ljava/lang/String;
    .param p4, "p3"    # [Ljava/lang/String;

    const-string v0, "p0"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 108
    const/4 v0, 0x0

    return v0
.end method
