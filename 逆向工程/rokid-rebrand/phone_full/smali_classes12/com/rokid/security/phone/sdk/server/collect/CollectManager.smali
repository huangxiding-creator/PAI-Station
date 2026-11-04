.class public final Lcom/rokid/security/phone/sdk/server/collect/CollectManager;
.super Ljava/lang/Object;
.source "CollectManager.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00005\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0004*\u0001\u0006\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\n\u001a\u00020\u000bJ\u0006\u0010\u000c\u001a\u00020\u000bJ*\u0010\r\u001a\u00020\u000b2\u0006\u0010\u000e\u001a\u00020\u00042\u0006\u0010\u000f\u001a\u00020\u00102\u0008\u0008\u0002\u0010\u0011\u001a\u00020\u00122\u0008\u0008\u0002\u0010\u0013\u001a\u00020\u0004J\u0010\u0010\u0014\u001a\u00020\u000b2\u0008\u0010\u0015\u001a\u0004\u0018\u00010\tR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0007R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0016"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/collect/CollectManager;",
        "",
        "()V",
        "TAG",
        "",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;",
        "mProvider",
        "Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;",
        "init",
        "",
        "release",
        "sendCollectResponseMsg",
        "tag",
        "isSuccess",
        "",
        "errorCode",
        "",
        "errorMsg",
        "setProvider",
        "provider",
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

.field private final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;

.field private mProvider:Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    const-string v0, "COLLECT_CollectManager"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->TAG:Ljava/lang/String;

    .line 23
    new-instance v0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;

    .line 19
    return-void
.end method

.method public static final synthetic access$getMProvider$p(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    .line 19
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->mProvider:Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    .line 19
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static synthetic sendCollectResponseMsg$default(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;Ljava/lang/String;ZILjava/lang/String;ILjava/lang/Object;)V
    .locals 0

    .line 105
    and-int/lit8 p6, p5, 0x4

    if-eqz p6, :cond_0

    const/4 p3, 0x0

    :cond_0
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_1

    const-string p4, ""

    :cond_1
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->sendCollectResponseMsg(Ljava/lang/String;ZILjava/lang/String;)V

    return-void
.end method


# virtual methods
.method public final init()V
    .locals 2

    .line 123
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 124
    return-void
.end method

.method public final release()V
    .locals 2

    .line 127
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->mProvider:Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;

    .line 128
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 129
    return-void
.end method

.method public final sendCollectResponseMsg(Ljava/lang/String;ZILjava/lang/String;)V
    .locals 10
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "isSuccess"    # Z
    .param p3, "errorCode"    # I
    .param p4, "errorMsg"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "errorMsg"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 106
    nop

    .line 107
    :try_start_0
    new-instance v0, Lcom/rokid/security/sdk/base/common/CollectExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/CollectExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendCollectResponseMsg_u24lambda_u240":Lcom/rokid/security/sdk/base/common/CollectExtra;
    const/4 v2, 0x0

    .line 108
    .local v2, "$i$a$-apply-CollectManager$sendCollectResponseMsg$collectExtra$1":I
    const-string v3, "collect_response"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/CollectExtra;->setMethodName(Ljava/lang/String;)V

    .line 109
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/CollectExtra;->setSuccess(Z)V

    .line 110
    invoke-virtual {v1, p4}, Lcom/rokid/security/sdk/base/common/CollectExtra;->setErrorMsg(Ljava/lang/String;)V

    .line 111
    invoke-virtual {v1, p3}, Lcom/rokid/security/sdk/base/common/CollectExtra;->setErrorCode(I)V

    .line 112
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/CollectExtra;->setTag(Ljava/lang/String;)V

    .line 113
    nop

    .line 107
    .end local v1    # "$this$sendCollectResponseMsg_u24lambda_u240":Lcom/rokid/security/sdk/base/common/CollectExtra;
    .end local v2    # "$i$a$-apply-CollectManager$sendCollectResponseMsg$collectExtra$1":I
    nop

    .line 114
    .local v0, "collectExtra":Lcom/rokid/security/sdk/base/common/CollectExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 115
    .local v1, "extra":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "COLLECT_ACTION"

    const-string v4, "extra"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "collectExtra":Lcom/rokid/security/sdk/base/common/CollectExtra;
    .end local v1    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 117
    :catch_0
    move-exception v0

    .line 118
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 120
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public final setProvider(Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;)V
    .locals 0
    .param p1, "provider"    # Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;

    .line 102
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->mProvider:Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;

    .line 103
    return-void
.end method
