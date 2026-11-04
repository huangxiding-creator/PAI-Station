.class final Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;
.super Lkotlin/jvm/internal/Lambda;
.source "AsrManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/asr/AsrManager;->onAsrComplete(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Ljava/lang/Integer;",
        "Ljava/lang/String;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\n\u00a2\u0006\u0002\u0008\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "intentIndex",
        "",
        "intentJson",
        "",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $asr:Ljava/lang/String;

.field final synthetic $extra:Lcom/rokid/security/sdk/base/common/AsrExtra;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/base/common/AsrExtra;Ljava/lang/String;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;->$extra:Lcom/rokid/security/sdk/base/common/AsrExtra;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;->$asr:Ljava/lang/String;

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p1, "p1"    # Ljava/lang/Object;
    .param p2, "p2"    # Ljava/lang/Object;

    .line 217
    move-object v0, p1

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    move-object v1, p2

    check-cast v1, Ljava/lang/String;

    invoke-virtual {p0, v0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;->invoke(ILjava/lang/String;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(ILjava/lang/String;)V
    .locals 10
    .param p1, "intentIndex"    # I
    .param p2, "intentJson"    # Ljava/lang/String;

    const-string v0, "intentJson"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 218
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;->$extra:Lcom/rokid/security/sdk/base/common/AsrExtra;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;->$asr:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setAsrContent(Ljava/lang/String;)V

    .line 219
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;->$extra:Lcom/rokid/security/sdk/base/common/AsrExtra;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setIntent(I)V

    .line 220
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;->$extra:Lcom/rokid/security/sdk/base/common/AsrExtra;

    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/base/common/AsrExtra;->setIntentAction(Ljava/lang/String;)V

    .line 221
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$onAsrComplete$1;->$extra:Lcom/rokid/security/sdk/base/common/AsrExtra;

    invoke-virtual {v0, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 222
    .local v0, "extraStr":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "sendNormalData chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " intent="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "AsrManager::"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 223
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v1, "extraStr"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "ASR_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v0

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 224
    return-void
.end method
