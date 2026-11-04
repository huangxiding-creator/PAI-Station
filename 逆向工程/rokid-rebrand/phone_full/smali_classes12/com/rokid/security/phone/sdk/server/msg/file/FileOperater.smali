.class public final Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;
.super Ljava/lang/Object;
.source "FileOperater.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nFileOperater.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/FileOperater\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,322:1\n93#2:323\n93#2:324\n1#3:325\n*S KotlinDebug\n*F\n+ 1 FileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/FileOperater\n*L\n166#1:323\n172#1:324\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000l\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010#\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0008\u0003\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0010\n\u0002\u0010\u0007\n\u0002\u0008\u0006*\u0002\u001a\u001d\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\'\u001a\u00020&2\u0006\u0010(\u001a\u00020\tH\u0017J\u0010\u0010)\u001a\u00020&2\u0006\u0010(\u001a\u00020\rH\u0016J\u0006\u0010*\u001a\u00020&J\u0008\u0010+\u001a\u00020\"H\u0016J\u0008\u0010,\u001a\u00020\"H\u0016J\u0010\u0010-\u001a\u00020&2\u0006\u0010.\u001a\u00020\u0004H\u0002J\u0006\u0010/\u001a\u00020&J\u0010\u00100\u001a\u00020&2\u0006\u0010(\u001a\u00020\tH\u0017J\u0010\u00101\u001a\u00020&2\u0006\u0010(\u001a\u00020\rH\u0016JN\u00102\u001a\u00020&2\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010(\u001a\u00020\t2\'\u00103\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\"0!\u00a2\u0006\u000c\u0008#\u0012\u0008\u0008$\u0012\u0004\u0008\u0008(%\u0012\u0004\u0012\u00020&0 H\u0016\u00f8\u0001\u0000J&\u00104\u001a\u00020&2\u0006\u00105\u001a\u00020\u00042\u0008\u0008\u0002\u00106\u001a\u0002072\n\u0008\u0002\u00108\u001a\u0004\u0018\u00010\u0004H\u0002J\u0008\u00109\u001a\u00020&H\u0002JF\u0010:\u001a\u00020&2\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0006\u001a\u00020\u00072\'\u00103\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\"0!\u00a2\u0006\u000c\u0008#\u0012\u0008\u0008$\u0012\u0004\u0008\u0008(%\u0012\u0004\u0012\u00020&0 H\u0002\u00f8\u0001\u0000J\u0008\u0010;\u001a\u00020&H\u0002J\u0008\u0010<\u001a\u00020&H\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0006\u001a\u0004\u0018\u00010\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\n\u001a\u0008\u0012\u0004\u0012\u00020\t0\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u00020\r0\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u000e\u001a\u00020\u000f8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0012\u0010\u0013\u001a\u0004\u0008\u0010\u0010\u0011R\u001b\u0010\u0014\u001a\u00020\u00158BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0018\u0010\u0013\u001a\u0004\u0008\u0016\u0010\u0017R\u0010\u0010\u0019\u001a\u00020\u001aX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u001bR\u0010\u0010\u001c\u001a\u00020\u001dX\u0082\u000e\u00a2\u0006\u0004\n\u0002\u0010\u001eR4\u0010\u001f\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\"0!\u00a2\u0006\u000c\u0008#\u0012\u0008\u0008$\u0012\u0004\u0008\u0008(%\u0012\u0004\u0012\u00020&\u0018\u00010 X\u0082\u000e\u00f8\u0001\u0000\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006="
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;",
        "Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;",
        "()V",
        "TAG",
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
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;",
        "getMFileReceiver",
        "()Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;",
        "mFileReceiver$delegate",
        "Lkotlin/Lazy;",
        "mFileSender",
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;",
        "getMFileSender",
        "()Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;",
        "mFileSender$delegate",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/msg/file/FileOperater$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mInterMessageListener$1;",
        "mListener",
        "com/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;",
        "onResultFun",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "",
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

.field private final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mInterMessageListener$1;

.field private mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;

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

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const-string v0, "FileOperater"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->TAG:Ljava/lang/String;

    .line 37
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mFileSender$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mFileSender$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileSender$delegate:Lkotlin/Lazy;

    .line 40
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mFileReceiver$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mFileReceiver$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiver$delegate:Lkotlin/Lazy;

    .line 46
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListeners:Ljava/util/Set;

    .line 47
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    .line 52
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mInterMessageListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mInterMessageListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mInterMessageListener$1;

    .line 123
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;

    .line 35
    return-void
.end method

.method public static final synthetic access$getMFileReceiveListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    return-object v0
.end method

.method public static final synthetic access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMFileReceiver(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    .line 35
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getMFileSender(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    .line 35
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;
    .param p1, "msg"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$setDir$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 35
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->dir:Ljava/lang/String;

    return-void
.end method

.method public static final synthetic access$setFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/io/File;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;
    .param p1, "<set-?>"    # Ljava/io/File;

    .line 35
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->file:Ljava/io/File;

    return-void
.end method

.method public static final synthetic access$setMFileReceiveListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;
    .param p1, "<set-?>"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .line 35
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    return-void
.end method

.method public static final synthetic access$setOnResultFun$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Lkotlin/jvm/functions/Function1;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;
    .param p1, "<set-?>"    # Lkotlin/jvm/functions/Function1;

    .line 35
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->onResultFun:Lkotlin/jvm/functions/Function1;

    return-void
.end method

.method private final getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;
    .locals 1

    .line 40
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiver$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    return-object v0
.end method

.method private final getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileSender$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    return-object v0
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 9
    .param p1, "msg"    # Ljava/lang/String;

    .line 64
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "File_ACTION"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 65
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 66
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 67
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

    .line 68
    .local v1, "mFileExtra":Lcom/rokid/security/sdk/base/common/FileExtra;
    if-eqz v1, :cond_9

    .line 69
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

    .line 82
    :cond_1
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->file:Ljava/io/File;

    if-eqz v2, :cond_9

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->onResultFun:Lkotlin/jvm/functions/Function1;

    if-eqz v2, :cond_9

    .line 83
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->dir:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->file:Ljava/io/File;

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->onResultFun:Lkotlin/jvm/functions/Function1;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-direct {p0, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->startSendFile(Ljava/lang/String;Ljava/io/File;Lkotlin/jvm/functions/Function1;)V

    goto/16 :goto_1

    .line 69
    :sswitch_1
    const-string v3, "receive_file_fail"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    goto :goto_0

    .line 106
    :cond_2
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v2, :cond_9

    invoke-interface {v2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onFail()V

    goto/16 :goto_1

    .line 69
    :sswitch_2
    const-string v3, "connect_server_receive_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 73
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->startReceiveFile()V

    goto/16 :goto_1

    .line 69
    :sswitch_3
    const-string/jumbo v3, "start_receive_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_3

    goto :goto_0

    .line 90
    :cond_3
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v2, :cond_9

    invoke-interface {v2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onStart()V

    goto :goto_1

    .line 69
    :sswitch_4
    const-string v3, "cancel_receive_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_4

    goto :goto_0

    .line 110
    :cond_4
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v2, :cond_9

    invoke-interface {v2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onCancel()V

    goto :goto_1

    .line 69
    :sswitch_5
    const-string/jumbo v3, "stop_send_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_5

    goto :goto_0

    .line 77
    :cond_5
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->stopReceiveFile()V

    goto :goto_1

    .line 69
    :sswitch_6
    const-string v3, "receive_file_complete"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_6

    goto :goto_0

    .line 102
    :cond_6
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v2, :cond_9

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/FileExtra;->getFilePath()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    const-string v3, ""

    :cond_7
    invoke-interface {v2, v3}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onComplete(Ljava/lang/String;)V

    goto :goto_1

    .line 69
    :sswitch_7
    const-string v3, "receive_progress_file"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_8

    goto/16 :goto_0

    .line 94
    :cond_8
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v3, :cond_9

    .line 95
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/FileExtra;->getProgress()F

    move-result v4

    .line 96
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/FileExtra;->getTransferredBytes()J

    move-result-wide v5

    .line 97
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/FileExtra;->getTotalBytes()J

    move-result-wide v7

    .line 94
    invoke-interface/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onProgressChanged(FJJ)V

    .line 117
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "mFileExtra":Lcom/rokid/security/sdk/base/common/FileExtra;
    :cond_9
    :goto_1
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x6846c40e -> :sswitch_7
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

    .line 301
    new-instance v0, Lcom/rokid/security/sdk/base/common/FileExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/FileExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendMsg_u24lambda_u241":Lcom/rokid/security/sdk/base/common/FileExtra;
    const/4 v2, 0x0

    .line 302
    .local v2, "$i$a$-apply-FileOperater$sendMsg$extra$1":I
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/FileExtra;->setMethodName(Ljava/lang/String;)V

    .line 303
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/FileExtra;->setProgress(F)V

    .line 304
    if-eqz p3, :cond_0

    move-object v3, p3

    .line 325
    .local v3, "it":Ljava/lang/String;
    const/4 v4, 0x0

    .line 304
    .local v4, "$i$a$-let-FileOperater$sendMsg$extra$1$1":I
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/FileExtra;->setFilePath(Ljava/lang/String;)V

    .line 305
    .end local v3    # "it":Ljava/lang/String;
    .end local v4    # "$i$a$-let-FileOperater$sendMsg$extra$1$1":I
    :cond_0
    nop

    .line 301
    .end local v1    # "$this$sendMsg_u24lambda_u241":Lcom/rokid/security/sdk/base/common/FileExtra;
    .end local v2    # "$i$a$-apply-FileOperater$sendMsg$extra$1":I
    nop

    .line 306
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/FileExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 307
    .local v1, "extraJson":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraJson"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "File_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 308
    return-void
.end method

.method static synthetic sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V
    .locals 0

    .line 296
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_0

    .line 298
    const/4 p2, 0x0

    .line 296
    :cond_0
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_1

    .line 299
    const/4 p3, 0x0

    .line 296
    :cond_1
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg(Ljava/lang/String;FLjava/lang/String;)V

    return-void
.end method

.method private final startReceiveFile()V
    .locals 2

    .line 269
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->TAG:Ljava/lang/String;

    const-string v1, " startReceiveFile"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 270
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1;

    invoke-direct {v1, p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect(Lkotlin/jvm/functions/Function1;)V

    .line 289
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

    .line 206
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;

    invoke-direct {v1, p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;Ljava/io/File;Lkotlin/jvm/functions/Function1;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V

    .line 221
    return-void
.end method

.method private final stopReceiveFile()V
    .locals 1

    .line 293
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->stopReceiving()V

    .line 294
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

    .line 241
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 242
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 244
    :cond_0
    return-void
.end method

.method public addFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 256
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 257
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 259
    :cond_0
    return-void
.end method

.method public final init()V
    .locals 2

    .line 120
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 121
    return-void
.end method

.method public isReceivingFile()Z
    .locals 1

    .line 232
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->isReceivingFile()Z

    move-result v0

    return v0
.end method

.method public isSendingFile()Z
    .locals 1

    .line 202
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->isSendingFile()Z

    move-result v0

    return v0
.end method

.method public final release()V
    .locals 2

    .line 311
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 312
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->file:Ljava/io/File;

    .line 313
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .line 314
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->onResultFun:Lkotlin/jvm/functions/Function1;

    .line 315
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->dir:Ljava/lang/String;

    .line 316
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->getMFileReceiver()Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->close()V

    .line 317
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->close()V

    .line 318
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 319
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 320
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

    .line 252
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 253
    return-void
.end method

.method public removeFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 262
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->mFileReceiveV2Listeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 263
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

    .line 163
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->TAG:Ljava/lang/String;

    const-string v1, " sendFile"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 164
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-nez v0, :cond_0

    .line 165
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendFile: \u8bbe\u5907\u672a\u5b8c\u6210\u53cc\u5411\u8ba4\u8bc1"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 166
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

    .line 323
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

    .line 166
    invoke-interface {p4, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 167
    return-void

    .line 170
    :cond_0
    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    .line 171
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->TAG:Ljava/lang/String;

    const-string v1, " sendFile:  file not exist"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 172
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .restart local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v7, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v2, -0x1

    const-string v3, "file not exist"

    const/4 v4, 0x0

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .restart local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v2, 0x0

    .line 324
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

    .line 172
    invoke-interface {p4, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 173
    return-void

    .line 176
    :cond_1
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    new-instance v7, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1;

    move-object v1, v7

    move-object v2, p0

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p1

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Ljava/lang/String;)V

    check-cast v7, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect(Lkotlin/jvm/functions/Function1;)V

    .line 199
    return-void
.end method

.method public stopSendFile()V
    .locals 7

    .line 225
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->TAG:Ljava/lang/String;

    const-string v1, " stopSendFile"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 226
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->getMFileSender()Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->close()V

    .line 228
    const/4 v5, 0x6

    const/4 v6, 0x0

    const-string/jumbo v2, "stop_send_file"

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 229
    return-void
.end method
