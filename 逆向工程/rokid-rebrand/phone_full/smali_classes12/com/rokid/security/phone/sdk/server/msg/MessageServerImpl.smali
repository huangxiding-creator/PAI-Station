.class public final Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;
.super Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;
.source "MessageServerImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000t\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0002\u0008\u0007\n\u0002\u0010\u0012\n\u0002\u0008\t\n\u0002\u0018\u0002\n\u0002\u0008\u0004*\u0002\u000c\u0016\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0018\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u0012J\u0010\u0010\u001b\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u0014H\u0016J\u0008\u0010\u001c\u001a\u00020\u001dH\u0016J\u0008\u0010\u001e\u001a\u00020\u001fH\u0016J\u0008\u0010 \u001a\u00020\u001fH\u0016J\u0006\u0010!\u001a\u00020\u0019J\u0010\u0010\"\u001a\u00020#2\u0006\u0010$\u001a\u00020\u0004H\u0002J\u0006\u0010%\u001a\u00020\u0019J\u000e\u0010&\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u0012J\u0010\u0010\'\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u0014H\u0016J\u0010\u0010(\u001a\u00020\u00042\u0006\u0010$\u001a\u00020\u0004H\u0002J\u0010\u0010)\u001a\u00020\u00192\u0006\u0010*\u001a\u00020+H\u0016J\u0010\u0010,\u001a\u00020\u00192\u0006\u0010*\u001a\u00020+H\u0016J\u000e\u0010-\u001a\u00020\u00192\u0006\u0010.\u001a\u00020\u0004J\u000e\u0010/\u001a\u00020\u00192\u0006\u0010.\u001a\u00020\u0004J0\u00100\u001a\u00020\u00192\u0006\u00101\u001a\u00020\u00042\u0006\u00102\u001a\u00020+2\u0006\u00103\u001a\u00020\u00042\u000e\u00104\u001a\n\u0012\u0004\u0012\u00020#\u0018\u000105H\u0016J\u0010\u00106\u001a\u00020\u00192\u0006\u0010.\u001a\u00020\u0004H\u0016J\u0018\u00107\u001a\u00020\u00192\u0006\u0010.\u001a\u00020\u00042\u0006\u00103\u001a\u00020\u0004H\u0016J\u0018\u00108\u001a\u00020\u00192\u0006\u0010.\u001a\u00020\u00042\u0006\u00103\u001a\u00020\u0004H\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000b\u001a\u00020\u000cX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\rR\u000e\u0010\u000e\u001a\u00020\u000fX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0010\u001a\u0008\u0012\u0004\u0012\u00020\u00120\u0011X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0013\u001a\u0008\u0012\u0004\u0012\u00020\u00140\u0011X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0015\u001a\u00020\u0016X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0017\u00a8\u00069"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;",
        "Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;",
        "()V",
        "TAG",
        "",
        "mApkFileOperator",
        "Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;",
        "mBTBinaryOperater",
        "Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;",
        "mBtFileOperater",
        "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;",
        "mClassicBTMessageListener",
        "com/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1;",
        "mFileOperater",
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;",
        "mInterMessageListeners",
        "Ljava/util/concurrent/CopyOnWriteArraySet;",
        "Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;",
        "mMessageListeners",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;",
        "mWifiP2PMessageListener",
        "com/rokid/security/phone/sdk/server/msg/MessageServerImpl$mWifiP2PMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mWifiP2PMessageListener$1;",
        "addInterMessageListener",
        "",
        "listener",
        "addMessageListener",
        "getApkFileOperator",
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/IApkFileOperate;",
        "getBtFileOperater",
        "Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;",
        "getFileOperater",
        "init",
        "isInterMessage",
        "",
        "msg",
        "release",
        "removeInterMessageListener",
        "removeMessageListener",
        "sanitizeRelayLog",
        "sendAudioStreamDataByClassicBT",
        "streamData",
        "",
        "sendAudioStreamDataByP2P",
        "sendInterTextMsgByClassicBt",
        "message",
        "sendInterTextMsgByP2P",
        "sendStreamData",
        "tag",
        "data",
        "clientId",
        "callback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "sendTextMessageByBle",
        "sendTextMessageByClassicBT",
        "sendTextMessageByP2P",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

.field private static final TAG:Ljava/lang/String; = "MessageServerImpl "

.field private static final mApkFileOperator:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

.field private static final mBTBinaryOperater:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

.field private static final mBtFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

.field private static final mClassicBTMessageListener:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1;

.field private static final mFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

.field private static final mInterMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArraySet<",
            "Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;",
            ">;"
        }
    .end annotation
.end field

.field private static final mMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArraySet<",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;",
            ">;"
        }
    .end annotation
.end field

.field private static final mWifiP2PMessageListener:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mWifiP2PMessageListener$1;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    .line 37
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArraySet;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    .line 38
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArraySet;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mInterMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    .line 40
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    .line 41
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mBtFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    .line 42
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mApkFileOperator:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    .line 43
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mBTBinaryOperater:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    .line 45
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mWifiP2PMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mWifiP2PMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mWifiP2PMessageListener:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mWifiP2PMessageListener$1;

    .line 106
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mClassicBTMessageListener:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;-><init>()V

    return-void
.end method

.method public static final synthetic access$getMInterMessageListeners$p()Ljava/util/concurrent/CopyOnWriteArraySet;
    .locals 1

    .line 35
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mInterMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    return-object v0
.end method

.method public static final synthetic access$getMMessageListeners$p()Ljava/util/concurrent/CopyOnWriteArraySet;
    .locals 1

    .line 35
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    return-object v0
.end method

.method public static final synthetic access$isInterMessage(Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;Ljava/lang/String;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;
    .param p1, "msg"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->isInterMessage(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$sanitizeRelayLog(Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;
    .param p1, "msg"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->sanitizeRelayLog(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private final isInterMessage(Ljava/lang/String;)Z
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;

    .line 339
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "custom_business_action"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method private final sanitizeRelayLog(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;

    .line 152
    nop

    .line 153
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "OTA_RELAY_COMMAND_V3"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "type=OTA_RELAY_COMMAND_V3 bytes="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 154
    :cond_0
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "OTA_RELAY_EVENT_V3"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "type=OTA_RELAY_EVENT_V3 bytes="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 155
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "msg:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 156
    :goto_0
    return-object v0
.end method


# virtual methods
.method public final addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 181
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mInterMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArraySet;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 182
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mInterMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArraySet;->add(Ljava/lang/Object;)Z

    .line 184
    :cond_0
    return-void
.end method

.method public addMessageListener(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;)V
    .locals 2
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 170
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArraySet;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 171
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArraySet;->add(Ljava/lang/Object;)Z

    .line 173
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "addMessageListener size:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArraySet;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "MessageServerImpl "

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 174
    return-void
.end method

.method public getApkFileOperator()Lcom/rokid/security/phone/sdk/api/filesystem/api/IApkFileOperate;
    .locals 1

    .line 335
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mApkFileOperator:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    check-cast v0, Lcom/rokid/security/phone/sdk/api/filesystem/api/IApkFileOperate;

    return-object v0
.end method

.method public getBtFileOperater()Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;
    .locals 1

    .line 331
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mBtFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    check-cast v0, Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;

    return-object v0
.end method

.method public getFileOperater()Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;
    .locals 1

    .line 327
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    check-cast v0, Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;

    return-object v0
.end method

.method public final init()V
    .locals 2

    .line 162
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->init()V

    .line 163
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mBtFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->init()V

    .line 164
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mBTBinaryOperater:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->init()V

    .line 165
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mWifiP2PMessageListener:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mWifiP2PMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->setWifiP2PMessageListener(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;)V

    .line 166
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mClassicBTMessageListener:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->setClassicBTMessageListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;)V

    .line 167
    return-void
.end method

.method public final release()V
    .locals 2

    .line 343
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->release()V

    .line 344
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mBtFileOperater:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->release()V

    .line 345
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mBTBinaryOperater:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->release()V

    .line 346
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArraySet;->clear()V

    .line 347
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mInterMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArraySet;->clear()V

    .line 348
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->setWifiP2PMessageListener(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;)V

    .line 349
    return-void
.end method

.method public final removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 187
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mInterMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArraySet;->remove(Ljava/lang/Object;)Z

    .line 188
    return-void
.end method

.method public removeMessageListener(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 177
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mMessageListeners:Ljava/util/concurrent/CopyOnWriteArraySet;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArraySet;->remove(Ljava/lang/Object;)Z

    .line 178
    return-void
.end method

.method public sendAudioStreamDataByClassicBT([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 297
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-nez v0, :cond_0

    .line 298
    return-void

    .line 300
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->sendClassBTAudioData([B)V

    .line 301
    return-void
.end method

.method public sendAudioStreamDataByP2P([B)V
    .locals 2
    .param p1, "streamData"    # [B

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 278
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-nez v0, :cond_0

    .line 279
    return-void

    .line 281
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 282
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->sendAudioStreamData([B)V

    goto :goto_0

    .line 291
    :cond_1
    const-string/jumbo v0, "sendAudioStreamDataByP2P:  connectP2p Fail"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "MessageServerImpl "

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 294
    :goto_0
    return-void
.end method

.method public final sendInterTextMsgByClassicBt(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 271
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->sendClassBTTextMessage(Ljava/lang/String;)V

    .line 275
    return-void
.end method

.method public final sendInterTextMsgByP2P(Ljava/lang/String;)V
    .locals 2
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 247
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-nez v0, :cond_0

    .line 248
    return-void

    .line 250
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 251
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->sendTextMessage(Ljava/lang/String;)V

    goto :goto_0

    .line 260
    :cond_1
    const-string/jumbo v0, "sendTextMessage:  p2p has disconnect sendInterTextMsgByP2P Fail"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "MessageServerImpl "

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 266
    :goto_0
    return-void
.end method

.method public sendStreamData(Ljava/lang/String;[BLjava/lang/String;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;
    .param p4, "callback"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "[B",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 319
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-nez v0, :cond_0

    .line 320
    return-void

    .line 322
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->mBTBinaryOperater:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->sendStreamData(Ljava/lang/String;[BLjava/lang/String;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    return-void
.end method

.method public sendTextMessageByBle(Ljava/lang/String;)V
    .locals 5
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 305
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-nez v0, :cond_0

    .line 306
    return-void

    .line 308
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    .line 309
    .local v0, "requestId":Ljava/lang/String;
    new-instance v1, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;-><init>()V

    const-string v2, "custom_business_action"

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setType(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setExtra(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    .line 310
    invoke-virtual {v1, v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setRequestId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->build()Lcom/rokid/security/sdk/base/common/RkBaseData;

    move-result-object v1

    .line 309
    nop

    .line 311
    .local v1, "request":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 312
    .local v2, "requestStr":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;

    const-string v4, "requestStr"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->sendTextMessage(Ljava/lang/String;)V

    .line 316
    return-void
.end method

.method public sendTextMessageByClassicBT(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "clientId"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 226
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-nez v0, :cond_0

    .line 227
    return-void

    .line 229
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    .line 230
    .local v0, "requestId":Ljava/lang/String;
    new-instance v1, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;-><init>()V

    .line 231
    const-string v2, "custom_business_action"

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setType(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    .line 232
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setExtra(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    .line 233
    invoke-virtual {v1, v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setRequestId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    .line 234
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setClientId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    .line 235
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->build()Lcom/rokid/security/sdk/base/common/RkBaseData;

    move-result-object v1

    .line 230
    nop

    .line 236
    .local v1, "request":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 237
    .local v2, "requestStr":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    const-string v4, "requestStr"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->sendClassBTTextMessage(Ljava/lang/String;)V

    .line 241
    return-void
.end method

.method public sendTextMessageByP2P(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "clientId"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 194
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-nez v0, :cond_0

    .line 195
    return-void

    .line 197
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    .line 198
    .local v0, "requestId":Ljava/lang/String;
    new-instance v1, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;-><init>()V

    .line 199
    const-string v2, "custom_business_action"

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setType(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    .line 200
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setExtra(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    .line 201
    invoke-virtual {v1, v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setRequestId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    .line 202
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setClientId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v1

    .line 203
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->build()Lcom/rokid/security/sdk/base/common/RkBaseData;

    move-result-object v1

    .line 198
    nop

    .line 204
    .local v1, "request":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 206
    .local v2, "requestStr":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 207
    sget-object v3, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    const-string v4, "requestStr"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->sendTextMessage(Ljava/lang/String;)V

    goto :goto_0

    .line 216
    :cond_1
    const-string/jumbo v3, "sendTextMessageByP2P:  p2p has disconnected  sendTextMessageByP2P failed"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "MessageServerImpl "

    invoke-static {v4, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 223
    :goto_0
    return-void
.end method
