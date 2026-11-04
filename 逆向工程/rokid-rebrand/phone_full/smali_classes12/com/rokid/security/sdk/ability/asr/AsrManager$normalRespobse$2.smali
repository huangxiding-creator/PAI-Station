.class final Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$2;
.super Lkotlin/jvm/internal/Lambda;
.source "AsrManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/asr/AsrManager;->normalRespobse(Ljava/lang/String;Lkotlin/jvm/functions/Function2;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Lcom/rokid/security/sdk/ability/param/AsrIntent;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u00012\u0008\u0010\u0002\u001a\u0004\u0018\u00010\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "intentParam",
        "Lcom/rokid/security/sdk/ability/param/AsrIntent;",
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
.field final synthetic $callBack:Lkotlin/jvm/functions/Function2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function2<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $done:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method constructor <init>(Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/functions/Function2;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/concurrent/atomic/AtomicBoolean;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$2;->$done:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$2;->$callBack:Lkotlin/jvm/functions/Function2;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 253
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/sdk/ability/param/AsrIntent;

    invoke-virtual {p0, v0}, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$2;->invoke(Lcom/rokid/security/sdk/ability/param/AsrIntent;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Lcom/rokid/security/sdk/ability/param/AsrIntent;)V
    .locals 3
    .param p1, "intentParam"    # Lcom/rokid/security/sdk/ability/param/AsrIntent;

    .line 254
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$2;->$done:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 255
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "normalRespobse intent  "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/param/AsrIntent;->getTools()Lcom/rokid/security/sdk/ability/param/Tools;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/param/Tools;->getName()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_1
    move-object v2, v1

    :goto_0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "AsrManager::"

    invoke-static {v2, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 256
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/param/AsrIntent;->getTools()Lcom/rokid/security/sdk/ability/param/Tools;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/param/Tools;->getName()Ljava/lang/String;

    move-result-object v1

    :cond_2
    const-string/jumbo v0, "take_photo"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    const-string v1, ""

    if-eqz v0, :cond_3

    .line 257
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$2;->$callBack:Lkotlin/jvm/functions/Function2;

    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_VISION:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v1}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 259
    :cond_3
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrManager$normalRespobse$2;->$callBack:Lkotlin/jvm/functions/Function2;

    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->INTENT_NONE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;->getValue()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v1}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 261
    :goto_1
    return-void
.end method
