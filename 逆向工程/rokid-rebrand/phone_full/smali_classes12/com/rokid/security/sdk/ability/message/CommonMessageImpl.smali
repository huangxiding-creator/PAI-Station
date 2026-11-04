.class public final Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;
.super Ljava/lang/Object;
.source "CommonMessageImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/message/ICommonMessage;
.implements Lcom/rokid/security/sdk/ability/message/IMessageAction;


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nCommonMessageImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 CommonMessageImpl.kt\ncom/rokid/security/sdk/ability/message/CommonMessageImpl\n+ 2 Maps.kt\nkotlin/collections/MapsKt__MapsKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,93:1\n483#2,7:94\n1855#3,2:101\n1855#3,2:103\n1855#3,2:105\n1855#3,2:107\n*S KotlinDebug\n*F\n+ 1 CommonMessageImpl.kt\ncom/rokid/security/sdk/ability/message/CommonMessageImpl\n*L\n42#1:94,7\n44#1:101,2\n53#1:103,2\n61#1:105,2\n67#1:107,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000:\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010%\n\u0002\u0010\u0008\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0012\n\u0002\u0008\u000e\u0008\u00c0\u0002\u0018\u00002\u00020\u00012\u00020\u0002B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0003J\u0010\u0010\u000c\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u0001H\u0016J\u0018\u0010\u000f\u001a\u00020\r2\u0006\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\nH\u0016J\u0018\u0010\u0013\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u00052\u0006\u0010\u0012\u001a\u00020\nH\u0016J\u0018\u0010\u0014\u001a\u00020\r2\u0006\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\nH\u0016J\u0018\u0010\u0015\u001a\u00020\r2\u0006\u0010\u0016\u001a\u00020\u000b2\u0006\u0010\u0012\u001a\u00020\nH\u0016J\u0016\u0010\u0017\u001a\u00020\r2\u0006\u0010\u0018\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\nJ\u0016\u0010\u0019\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u00052\u0006\u0010\u0012\u001a\u00020\nJ\u001e\u0010\u0019\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u00052\u0006\u0010\u0012\u001a\u00020\n2\u0006\u0010\u001a\u001a\u00020\nJ&\u0010\u001b\u001a\u00020\r2\u0006\u0010\u001c\u001a\u00020\u00052\u0006\u0010\u0018\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\n2\u0006\u0010\u001a\u001a\u00020\nJ\u0010\u0010\u001d\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u0001H\u0016J\u0010\u0010\u001e\u001a\u00020\r2\u0006\u0010\u0016\u001a\u00020\u000bH\u0016R\u000e\u0010\u0004\u001a\u00020\u0005X\u0082D\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0006\u001a\u0008\u0012\u0004\u0012\u00020\u00010\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0008\u001a\u000e\u0012\u0004\u0012\u00020\n\u0012\u0004\u0012\u00020\u000b0\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;",
        "Lcom/rokid/security/sdk/ability/message/ICommonMessage;",
        "Lcom/rokid/security/sdk/ability/message/IMessageAction;",
        "()V",
        "TAG",
        "",
        "mICommonMessageList",
        "Ljava/util/concurrent/CopyOnWriteArrayList;",
        "messageToolMap",
        "",
        "",
        "Lcom/rokid/security/sdk/ability/message/ISendTool;",
        "injectIMessage",
        "",
        "message",
        "onAudioStream",
        "buffer",
        "",
        "type",
        "onMessage",
        "onVideoStream",
        "registerMessageSendTool",
        "tool",
        "sendAudioStream",
        "streamData",
        "sendMessage",
        "networkMode",
        "sendStreamData",
        "tag",
        "unInjectIMessage",
        "unRegisterMessageSendTool",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;

.field private static final TAG:Ljava/lang/String;

.field private static mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Lcom/rokid/security/sdk/ability/message/ICommonMessage;",
            ">;"
        }
    .end annotation
.end field

.field private static messageToolMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Lcom/rokid/security/sdk/ability/message/ISendTool;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;

    .line 13
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 15
    const-string v0, "CommonMessageImpl::"

    sput-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->TAG:Ljava/lang/String;

    .line 17
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->messageToolMap:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public injectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V
    .locals 1
    .param p1, "message"    # Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 23
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 24
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 27
    :cond_0
    return-void
.end method

.method public onAudioStream([BI)V
    .locals 6
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 61
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 105
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    .local v4, "m":Lcom/rokid/security/sdk/ability/message/ICommonMessage;
    const/4 v5, 0x0

    .line 62
    .local v5, "$i$a$-forEach-CommonMessageImpl$onAudioStream$1":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/security/sdk/ability/message/ICommonMessage;->onAudioStream([BI)V

    .line 63
    nop

    .line 105
    .end local v4    # "m":Lcom/rokid/security/sdk/ability/message/ICommonMessage;
    .end local v5    # "$i$a$-forEach-CommonMessageImpl$onAudioStream$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 106
    :cond_0
    nop

    .line 64
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onMessage(Ljava/lang/String;I)V
    .locals 6
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "type"    # I

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "message received type="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " listeners="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 53
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 103
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    .local v4, "m":Lcom/rokid/security/sdk/ability/message/ICommonMessage;
    const/4 v5, 0x0

    .line 54
    .local v5, "$i$a$-forEach-CommonMessageImpl$onMessage$1":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/security/sdk/ability/message/ICommonMessage;->onMessage(Ljava/lang/String;I)V

    .line 55
    nop

    .line 103
    .end local v4    # "m":Lcom/rokid/security/sdk/ability/message/ICommonMessage;
    .end local v5    # "$i$a$-forEach-CommonMessageImpl$onMessage$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 104
    :cond_0
    nop

    .line 56
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onVideoStream([BI)V
    .locals 6
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 107
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    .local v4, "m":Lcom/rokid/security/sdk/ability/message/ICommonMessage;
    const/4 v5, 0x0

    .line 68
    .local v5, "$i$a$-forEach-CommonMessageImpl$onVideoStream$1":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/security/sdk/ability/message/ICommonMessage;->onVideoStream([BI)V

    .line 69
    nop

    .line 107
    .end local v4    # "m":Lcom/rokid/security/sdk/ability/message/ICommonMessage;
    .end local v5    # "$i$a$-forEach-CommonMessageImpl$onVideoStream$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 108
    :cond_0
    nop

    .line 70
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public registerMessageSendTool(Lcom/rokid/security/sdk/ability/message/ISendTool;I)V
    .locals 2
    .param p1, "tool"    # Lcom/rokid/security/sdk/ability/message/ISendTool;
    .param p2, "type"    # I

    const-string/jumbo v0, "tool"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .line 37
    sget-object v1, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->messageToolMap:Ljava/util/Map;

    invoke-interface {v1, v0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 38
    return-void
.end method

.method public final sendAudioStream([BI)V
    .locals 2
    .param p1, "streamData"    # [B
    .param p2, "type"    # I

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 85
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->messageToolMap:Ljava/util/Map;

    sget-object v1, Lcom/rokid/security/sdk/ability/NetChangeManager;->INSTANCE:Lcom/rokid/security/sdk/ability/NetChangeManager;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/NetChangeManager;->getNetworkMode()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/message/ISendTool;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2}, Lcom/rokid/security/sdk/ability/message/ISendTool;->sendAudioStream([BI)V

    .line 86
    :cond_0
    return-void
.end method

.method public final sendMessage(Ljava/lang/String;I)V
    .locals 3
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "type"    # I

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 74
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "send message type="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " mode="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/sdk/ability/NetChangeManager;->INSTANCE:Lcom/rokid/security/sdk/ability/NetChangeManager;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/NetChangeManager;->getNetworkMode()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 75
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->messageToolMap:Ljava/util/Map;

    sget-object v1, Lcom/rokid/security/sdk/ability/NetChangeManager;->INSTANCE:Lcom/rokid/security/sdk/ability/NetChangeManager;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/NetChangeManager;->getNetworkMode()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/message/ISendTool;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2}, Lcom/rokid/security/sdk/ability/message/ISendTool;->sendMessage(Ljava/lang/String;I)V

    .line 76
    :cond_0
    return-void
.end method

.method public final sendMessage(Ljava/lang/String;II)V
    .locals 3
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "type"    # I
    .param p3, "networkMode"    # I

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 79
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "send message type="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " mode="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 80
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->messageToolMap:Ljava/util/Map;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/message/ISendTool;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2}, Lcom/rokid/security/sdk/ability/message/ISendTool;->sendMessage(Ljava/lang/String;I)V

    .line 81
    :cond_0
    return-void
.end method

.method public final sendStreamData(Ljava/lang/String;[BII)V
    .locals 2
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "streamData"    # [B
    .param p3, "type"    # I
    .param p4, "networkMode"    # I

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "streamData"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 89
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->messageToolMap:Ljava/util/Map;

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/message/ISendTool;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2, p3}, Lcom/rokid/security/sdk/ability/message/ISendTool;->sendStreamData(Ljava/lang/String;[BI)V

    .line 90
    :cond_0
    return-void
.end method

.method public unInjectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V
    .locals 1
    .param p1, "message"    # Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 32
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->mICommonMessageList:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 34
    :cond_0
    return-void
.end method

.method public unRegisterMessageSendTool(Lcom/rokid/security/sdk/ability/message/ISendTool;)V
    .locals 9
    .param p1, "tool"    # Lcom/rokid/security/sdk/ability/message/ISendTool;

    const-string/jumbo v0, "tool"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->messageToolMap:Ljava/util/Map;

    .local v0, "$this$filterValues$iv":Ljava/util/Map;
    const/4 v1, 0x0

    .line 94
    .local v1, "$i$f$filterValues":I
    new-instance v2, Ljava/util/LinkedHashMap;

    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V

    .line 95
    .local v2, "result$iv":Ljava/util/LinkedHashMap;
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    .line 96
    .local v4, "entry$iv":Ljava/util/Map$Entry;
    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/rokid/security/sdk/ability/message/ISendTool;

    .local v5, "it":Lcom/rokid/security/sdk/ability/message/ISendTool;
    const/4 v6, 0x0

    .line 42
    .local v6, "$i$a$-filterValues-CommonMessageImpl$unRegisterMessageSendTool$keysToRemove$1":I
    invoke-static {v5, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    .line 96
    .end local v5    # "it":Lcom/rokid/security/sdk/ability/message/ISendTool;
    .end local v6    # "$i$a$-filterValues-CommonMessageImpl$unRegisterMessageSendTool$keysToRemove$1":I
    if-eqz v5, :cond_0

    .line 97
    invoke-interface {v4}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 100
    .end local v4    # "entry$iv":Ljava/util/Map$Entry;
    :cond_1
    move-object v0, v2

    check-cast v0, Ljava/util/Map;

    .line 42
    .end local v0    # "$this$filterValues$iv":Ljava/util/Map;
    .end local v1    # "$i$f$filterValues":I
    .end local v2    # "result$iv":Ljava/util/LinkedHashMap;
    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->toList(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v0

    .line 44
    .local v0, "keysToRemove":Ljava/util/List;
    move-object v1, v0

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 101
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Ljava/lang/Number;

    invoke-virtual {v5}, Ljava/lang/Number;->intValue()I

    move-result v5

    .local v5, "key":I
    const/4 v6, 0x0

    .line 45
    .local v6, "$i$a$-forEach-CommonMessageImpl$unRegisterMessageSendTool$1":I
    sget-object v7, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->messageToolMap:Ljava/util/Map;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-interface {v7, v8}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 46
    nop

    .line 101
    .end local v5    # "key":I
    .end local v6    # "$i$a$-forEach-CommonMessageImpl$unRegisterMessageSendTool$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 102
    :cond_2
    nop

    .line 47
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    return-void
.end method
