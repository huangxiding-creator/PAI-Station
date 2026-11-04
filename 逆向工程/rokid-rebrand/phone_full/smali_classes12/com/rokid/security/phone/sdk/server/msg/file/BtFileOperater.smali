.class public final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;
.super Ljava/lang/Object;
.source "BtFileOperater.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBtFileOperater.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BtFileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/BtFileOperater\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,362:1\n93#2:363\n93#2:364\n93#2:365\n93#2:366\n93#2:367\n1#3:368\n*S KotlinDebug\n*F\n+ 1 BtFileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/BtFileOperater\n*L\n236#1:363\n242#1:364\n248#1:365\n254#1:366\n260#1:367\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000s\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010#\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0008\u0003\n\u0002\u0008\u0003\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0010\n\u0002\u0010\u0007\n\u0002\u0008\u0006*\u0003\u001c\u001f\"\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010+\u001a\u00020*2\u0006\u0010,\u001a\u00020\u000bH\u0017J\u0010\u0010-\u001a\u00020*2\u0006\u0010,\u001a\u00020\u000fH\u0016J\u0006\u0010.\u001a\u00020*J\u0008\u0010/\u001a\u00020\u0006H\u0016J\u0008\u00100\u001a\u00020\u0006H\u0016J\u0010\u00101\u001a\u00020*2\u0006\u00102\u001a\u00020\u0004H\u0002J\u0006\u00103\u001a\u00020*J\u0010\u00104\u001a\u00020*2\u0006\u0010,\u001a\u00020\u000bH\u0017J\u0010\u00105\u001a\u00020*2\u0006\u0010,\u001a\u00020\u000fH\u0016J?\u00106\u001a\u00020*2\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0008\u001a\u00020\t2\u0006\u0010,\u001a\u00020\u000b2\u0018\u00107\u001a\u0014\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00060&\u0012\u0004\u0012\u00020*0%H\u0016\u00f8\u0001\u0000J&\u00108\u001a\u00020*2\u0006\u00109\u001a\u00020\u00042\u0008\u0008\u0002\u0010:\u001a\u00020;2\n\u0008\u0002\u0010<\u001a\u0004\u0018\u00010\u0004H\u0002J\u0008\u0010=\u001a\u00020*H\u0002JF\u0010>\u001a\u00020*2\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0008\u001a\u00020\t2\'\u00107\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060&\u00a2\u0006\u000c\u0008\'\u0012\u0008\u0008(\u0012\u0004\u0008\u0008()\u0012\u0004\u0012\u00020*0%H\u0002\u00f8\u0001\u0000J\u0008\u0010?\u001a\u00020*H\u0002J\u0008\u0010@\u001a\u00020*H\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u00020\u000b0\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000e\u001a\u0008\u0012\u0004\u0012\u00020\u000f0\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0010\u001a\u00020\u00118BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0014\u0010\u0015\u001a\u0004\u0008\u0012\u0010\u0013R\u001b\u0010\u0016\u001a\u00020\u00178BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u001a\u0010\u0015\u001a\u0004\u0008\u0018\u0010\u0019R\u0010\u0010\u001b\u001a\u00020\u001cX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u001dR\u0010\u0010\u001e\u001a\u00020\u001fX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010 R\u0010\u0010!\u001a\u00020\"X\u0082\u000e\u00a2\u0006\u0004\n\u0002\u0010#R4\u0010$\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060&\u00a2\u0006\u000c\u0008\'\u0012\u0008\u0008(\u0012\u0004\u0008\u0008()\u0012\u0004\u0012\u00020*\u0018\u00010%X\u0082\u000e\u00f8\u0001\u0000\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006A"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;",
        "Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;",
        "()V",
        "TAG",
        "",
        "acceptSendCallbacks",
        "",
        "dir",
        "file",
        "Ljava/io/File;",
        "mFileReceiveListener",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
        "mFileReceiveListeners",
        "",
        "mFileReceiveV2Listeners",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;",
        "mFileReceiver",
        "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;",
        "getMFileReceiver",
        "()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;",
        "mFileReceiver$delegate",
        "Lkotlin/Lazy;",
        "mFileSender",
        "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;",
        "getMFileSender",
        "()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;",
        "mFileSender$delegate",
        "mIClassicBTClientListener",
        "com/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mInterMessageListener$1;",
        "mListener",
        "com/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;",
        "onResultFun",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "",
        "addFileReceiveListener",
        "listener",
        "addFileReceiveV2Listener",
        "init",
        "isReceivingFile",
        "isSendingFile",
        "parseMessage",
        "msg",
        "release",
        "removeFileReceiveListener",
        "removeFileReceiveV2Listener",
        "sendFile",
        "onResult",
        "sendMsg",
        "methodName",
        "progress",
        "",
        "filePath",
        "startReceiveFile",
        "startSendFile",
        "stopReceiveFile",
        "stopSendFile",
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

.field private volatile acceptSendCallbacks:Z

.field private dir:Ljava/lang/String;

.field private file:Ljava/io/File;

.field private mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

.field private final mFileReceiveListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            ">;"
        }
    .end annotation
.end field

.field private final mFileReceiveV2Listeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;",
            ">;"
        }
    .end annotation
.end field

.field private final mFileReceiver$delegate:Lkotlin/Lazy;

.field private final mFileSender$delegate:Lkotlin/Lazy;

.field private final mIClassicBTClientListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;

.field private final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mInterMessageListener$1;

.field private mListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;

.field private onResultFun:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    const-string v0, "BtFileOperater"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    .line 40
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mFileSender$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mFileSender$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileSender$delegate:Lkotlin/Lazy;

    .line 43
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mFileReceiver$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mFileReceiver$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiver$delegate:Lkotlin/Lazy;

    .line 50
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListeners:Ljava/util/Set;

    .line 51
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    .line 64
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mIClassicBTClientListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;

    .line 89
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mInterMessageListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mInterMessageListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mInterMessageListener$1;

    .line 183
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;

    .line 37
    return-void
.end method

.method public static final synthetic access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMFileReceiver(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    .line 37
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getMFileSender(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    .line 37
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;
    .param p1, "msg"    # Ljava/lang/String;

    .line 37
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$setAcceptSendCallbacks$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;
    .param p1, "<set-?>"    # Z

    .line 37
    iput-boolean p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    return-void
.end method

.method private final getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;
    .locals 1

    .line 43
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiver$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    return-object v0
.end method

.method private final getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;
    .locals 1

    .line 40
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileSender$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    return-object v0
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 6
    .param p1, "msg"    # Ljava/lang/String;

    .line 103
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "BT_FILE_API_ACTION"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 104
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 105
    .local v0, "jsonObject":Lorg/json/JSONObject;
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "parseMessage:  jsonObject--\u300b"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 106
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_b

    .line 107
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    const-string v2, "extra"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/FileExtra;

    invoke-virtual {v1, v2, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/FileExtra;

    .line 108
    .local v1, "mFileExtra":Lcom/rokid/security/sdk/base/common/FileExtra;
    if-eqz v1, :cond_b

    .line 109
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/FileExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v3

    sparse-switch v3, :sswitch_data_0

    :cond_0
    :goto_0
    goto/16 :goto_1

    :sswitch_0
    const-string v3, "ready_receive_file_ok"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    goto :goto_0

    .line 122
    :cond_1
    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->file:Ljava/io/File;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->onResultFun:Lkotlin/jvm/functions/Function1;

    if-eqz v2, :cond_2

    .line 123
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->dir:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->file:Ljava/io/File;

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->onResultFun:Lkotlin/jvm/functions/Function1;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-direct {p0, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->startSendFile(Ljava/lang/String;Ljava/io/File;Lkotlin/jvm/functions/Function1;)V

    goto/16 :goto_1

    .line 125
    :cond_2
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    const-string v3, "drop stale ready response after send stopped"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_1

    .line 109
    :sswitch_1
    const-string v3, "receive_file_fail"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_3

    goto :goto_0

    .line 147
    :cond_3
    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    if-eqz v2, :cond_b

    .line 148
    iput-boolean v5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    .line 149
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v2, :cond_b

    invoke-interface {v2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onFail()V

    goto/16 :goto_1

    .line 109
    :sswitch_2
    const-string v3, "connect_server_receive_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 113
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->startReceiveFile()V

    goto/16 :goto_1

    .line 109
    :sswitch_3
    const-string/jumbo v3, "start_receive_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_4

    goto :goto_0

    .line 132
    :cond_4
    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    if-eqz v2, :cond_b

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v2, :cond_b

    invoke-interface {v2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onStart()V

    goto/16 :goto_1

    .line 109
    :sswitch_4
    const-string v3, "cancel_receive_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_5

    goto :goto_0

    .line 154
    :cond_5
    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    if-eqz v2, :cond_b

    .line 155
    iput-boolean v5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    .line 156
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v2, :cond_b

    invoke-interface {v2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onCancel()V

    goto :goto_1

    .line 109
    :sswitch_5
    const-string/jumbo v3, "stop_send_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_6

    goto/16 :goto_0

    .line 117
    :cond_6
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->stopReceiveFile()V

    goto :goto_1

    .line 109
    :sswitch_6
    const-string v3, "receive_file_complete"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_7

    goto/16 :goto_0

    .line 140
    :cond_7
    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    if-eqz v2, :cond_b

    .line 141
    iput-boolean v5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    .line 142
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v2, :cond_b

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/FileExtra;->getFilePath()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_8

    const-string v3, ""

    :cond_8
    invoke-interface {v2, v3}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onComplete(Ljava/lang/String;)V

    goto :goto_1

    .line 109
    :sswitch_7
    const-string/jumbo v3, "sendFileMetadata"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_9

    goto/16 :goto_0

    .line 161
    :cond_9
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    move-result-object v2

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/FileExtra;->getFileName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/FileExtra;->getFileSize()J

    move-result-wide v4

    invoke-virtual {v2, v3, v4, v5}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->onReceivingMateData(Ljava/lang/String;J)V

    goto :goto_1

    .line 109
    :sswitch_8
    const-string v3, "receive_progress_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_a

    goto/16 :goto_0

    .line 136
    :cond_a
    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    if-eqz v2, :cond_b

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v2, :cond_b

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/FileExtra;->getProgress()F

    move-result v3

    invoke-interface {v2, v3}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onProgressChanged(F)V

    .line 168
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "mFileExtra":Lcom/rokid/security/sdk/base/common/FileExtra;
    :cond_b
    :goto_1
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x6846c40e -> :sswitch_8
        -0x5c094f8d -> :sswitch_7
        -0x539f2bc0 -> :sswitch_6
        -0x5318442a -> :sswitch_5
        -0x5b25d03 -> :sswitch_4
        0x395e615 -> :sswitch_3
        0x35905dff -> :sswitch_2
        0x3d2c15a5 -> :sswitch_1
        0x7525cb87 -> :sswitch_0
    .end sparse-switch
.end method

.method private final sendMsg(Ljava/lang/String;FLjava/lang/String;)V
    .locals 10
    .param p1, "methodName"    # Ljava/lang/String;
    .param p2, "progress"    # F
    .param p3, "filePath"    # Ljava/lang/String;

    .line 334
    new-instance v0, Lcom/rokid/security/sdk/base/common/FileExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/FileExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendMsg_u24lambda_u241":Lcom/rokid/security/sdk/base/common/FileExtra;
    const/4 v2, 0x0

    .line 335
    .local v2, "$i$a$-apply-BtFileOperater$sendMsg$extra$1":I
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/FileExtra;->setMethodName(Ljava/lang/String;)V

    .line 336
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/FileExtra;->setProgress(F)V

    .line 337
    if-eqz p3, :cond_0

    move-object v3, p3

    .line 368
    .local v3, "it":Ljava/lang/String;
    const/4 v4, 0x0

    .line 337
    .local v4, "$i$a$-let-BtFileOperater$sendMsg$extra$1$1":I
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/FileExtra;->setFilePath(Ljava/lang/String;)V

    .line 338
    .end local v3    # "it":Ljava/lang/String;
    .end local v4    # "$i$a$-let-BtFileOperater$sendMsg$extra$1$1":I
    :cond_0
    nop

    .line 334
    .end local v1    # "$this$sendMsg_u24lambda_u241":Lcom/rokid/security/sdk/base/common/FileExtra;
    .end local v2    # "$i$a$-apply-BtFileOperater$sendMsg$extra$1":I
    nop

    .line 339
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/FileExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 340
    .local v1, "extraJson":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraJson"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "BT_FILE_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 341
    return-void
.end method

.method static synthetic sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V
    .locals 0

    .line 329
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_0

    .line 331
    const/4 p2, 0x0

    .line 329
    :cond_0
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_1

    .line 332
    const/4 p3, 0x0

    .line 329
    :cond_1
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->sendMsg(Ljava/lang/String;FLjava/lang/String;)V

    return-void
.end method

.method private final startReceiveFile()V
    .locals 2

    .line 175
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    const-string v1, " startReceiveFile"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 177
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 178
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->startReceiving(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;)V

    .line 180
    :cond_0
    return-void
.end method

.method private final startSendFile(Ljava/lang/String;Ljava/io/File;Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .param p1, "dir"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/io/File;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 278
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    invoke-virtual {v0, p1, p2, v1, p3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->sendFile(Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V

    .line 279
    return-void
.end method

.method private final stopReceiveFile()V
    .locals 1

    .line 221
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->stopReceiving()V

    .line 222
    return-void
.end method


# virtual methods
.method public addFileReceiveListener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .annotation runtime Lkotlin/Deprecated;
        level = .enum Lkotlin/DeprecationLevel;->WARNING:Lkotlin/DeprecationLevel;
        message = "V2.1.4\u7248\u672c\u5e9f\u5f03,addFileReceiveV2Listener\u65b9\u6cd5"
        replaceWith = .subannotation Lkotlin/ReplaceWith;
            expression = "addFileReceiveV2Listener(listener)"
            imports = {}
        .end subannotation
    .end annotation

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 304
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 305
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 307
    :cond_0
    return-void
.end method

.method public addFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 319
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 320
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 322
    :cond_0
    return-void
.end method

.method public final init()V
    .locals 2

    .line 60
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 61
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mIClassicBTClientListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V

    .line 62
    return-void
.end method

.method public isReceivingFile()Z
    .locals 1

    .line 295
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->isReceivingFile()Z

    move-result v0

    return v0
.end method

.method public isSendingFile()Z
    .locals 1

    .line 273
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->isSendingFile()Z

    move-result v0

    return v0
.end method

.method public final release()V
    .locals 2

    .line 346
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 347
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mIClassicBTClientListener:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V

    .line 348
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->file:Ljava/io/File;

    .line 349
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .line 350
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    .line 351
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->onResultFun:Lkotlin/jvm/functions/Function1;

    .line 352
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->dir:Ljava/lang/String;

    .line 353
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->close()V

    .line 354
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->close()V

    .line 355
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 356
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 358
    return-void
.end method

.method public removeFileReceiveListener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .annotation runtime Lkotlin/Deprecated;
        level = .enum Lkotlin/DeprecationLevel;->WARNING:Lkotlin/DeprecationLevel;
        message = "V2.1.4\u7248\u672c\u5e9f\u5f03,removeFileReceiveV2Listener\u65b9\u6cd5"
        replaceWith = .subannotation Lkotlin/ReplaceWith;
            expression = "removeFileReceiveV2Listener(listener)"
            imports = {}
        .end subannotation
    .end annotation

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 315
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 316
    return-void
.end method

.method public removeFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 325
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 326
    return-void
.end method

.method public sendFile(Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V
    .locals 8
    .param p1, "dir"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .param p4, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/io/File;",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "file"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onResult"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 232
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " sendFile: file = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 234
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-nez v0, :cond_0

    .line 235
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendFile: \u8bbe\u5907\u672a\u5b8c\u6210\u53cc\u5411\u8ba4\u8bc1"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 236
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .local v0, "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v7, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v2, -0x3

    const-string/jumbo v3, "\u8bbe\u5907\u672a\u5b8c\u6210\u53cc\u5411\u8ba4\u8bc1"

    const/4 v4, 0x0

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v1, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v2, 0x0

    .line 363
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

    .line 236
    invoke-interface {p4, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 237
    return-void

    .line 240
    :cond_0
    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {p2}, Ljava/io/File;->isFile()Z

    move-result v0

    if-nez v0, :cond_1

    goto/16 :goto_0

    .line 246
    :cond_1
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isMessageChanelConnect()Z

    move-result v0

    if-nez v0, :cond_2

    .line 247
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    const-string v1, " sendFile: isMessageChanelConnect = false, BT not connect"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 248
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .restart local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v7, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v2, -0x5

    const-string v3, "BT not connect"

    const/4 v4, 0x0

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .restart local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v2, 0x0

    .line 365
    .restart local v2    # "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v2    # "$i$f$failure":I
    invoke-static {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v0

    .line 248
    invoke-interface {p4, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 249
    return-void

    .line 252
    :cond_2
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isFileChanelConnect()Z

    move-result v0

    if-nez v0, :cond_3

    .line 253
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendFile: isFileChanelConnect = false ,BT File chanel not connect"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 254
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .restart local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v7, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v2, -0x6

    const-string v3, "BT File chanel not connect"

    const/4 v4, 0x0

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .restart local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v2, 0x0

    .line 366
    .restart local v2    # "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v2    # "$i$f$failure":I
    invoke-static {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v0

    .line 254
    invoke-interface {p4, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 255
    return-void

    .line 258
    :cond_3
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->isSendingFile()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 259
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendFile: There is a file being sent. Please try again later."

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 260
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .restart local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v7, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v2, -0x4

    const-string v3, "There is a file being sent. Please try again later"

    const/4 v4, 0x0

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .restart local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v2, 0x0

    .line 367
    .restart local v2    # "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v2    # "$i$f$failure":I
    invoke-static {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v0

    .line 260
    invoke-interface {p4, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 261
    return-void

    .line 264
    :cond_4
    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->file:Ljava/io/File;

    .line 265
    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->onResultFun:Lkotlin/jvm/functions/Function1;

    .line 266
    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .line 267
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->dir:Ljava/lang/String;

    .line 268
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    .line 269
    const/4 v5, 0x6

    const/4 v6, 0x0

    const-string v2, "ready_receive_file"

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 270
    return-void

    .line 241
    :cond_5
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    const-string v1, " sendFile:  sendFile: isMessageChanelConnect = false, BT not connect"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 242
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .restart local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v7, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v2, -0x1

    const-string v3, "BT not connect"

    const/4 v4, 0x0

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .restart local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v2, 0x0

    .line 364
    .restart local v2    # "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v2    # "$i$f$failure":I
    invoke-static {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v0

    .line 242
    invoke-interface {p4, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 243
    return-void
.end method

.method public stopSendFile()V
    .locals 7

    .line 284
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->TAG:Ljava/lang/String;

    const-string v1, " stopSendFile"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 285
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->acceptSendCallbacks:Z

    .line 286
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->file:Ljava/io/File;

    .line 287
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->onResultFun:Lkotlin/jvm/functions/Function1;

    .line 288
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->dir:Ljava/lang/String;

    .line 289
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->close()V

    .line 291
    const/4 v5, 0x6

    const/4 v6, 0x0

    const-string/jumbo v2, "stop_send_file"

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 292
    return-void
.end method
