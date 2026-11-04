.class public final Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;
.super Ljava/lang/Object;
.source "OnlineRecManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
        "Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000#\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004*\u0001\u0000\u0008\n\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001J!\u0010\u0003\u001a\u00020\u00042\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0008H\u0016\u00a2\u0006\u0002\u0010\tJ\u0012\u0010\n\u001a\u00020\u00042\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u0002H\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;",
        "onFailed",
        "",
        "code",
        "",
        "errormsg",
        "",
        "(Ljava/lang/Integer;Ljava/lang/String;)V",
        "onSuccess",
        "data",
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
.field final synthetic $data:[B

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;[B)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;
    .param p2, "$data"    # [B

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;->$data:[B

    .line 170
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 5
    .param p1, "code"    # Ljava/lang/Integer;
    .param p2, "errormsg"    # Ljava/lang/String;

    .line 181
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "RecProvider recognizeFace onFailed data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;->$data:[B

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " code = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", errormsg = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 182
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    .line 183
    nop

    .line 184
    nop

    .line 185
    if-nez p2, :cond_0

    const-string v1, "recognizeFace onFailed "

    goto :goto_0

    :cond_0
    move-object v1, p2

    .line 186
    :goto_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    goto :goto_1

    :cond_1
    const/4 v2, -0x1

    .line 182
    :goto_1
    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v3, v4, v1, v2}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$sendRecogFaceResponseMsg(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V

    .line 188
    return-void
.end method

.method public onSuccess(Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;)V
    .locals 9
    .param p1, "data"    # Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;

    .line 172
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "RecProvider recognizeFace onSuccess data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 173
    if-eqz p1, :cond_0

    .line 174
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    const/16 v7, 0xc

    const/4 v8, 0x0

    const/4 v3, 0x1

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v4, p1

    invoke-static/range {v2 .. v8}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->sendRecogFaceResponseMsg$default(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;IILjava/lang/Object;)V

    goto :goto_0

    .line 176
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;->this$0:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    const-string v1, "data is null"

    const/4 v2, -0x1

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v3, v4, v1, v2}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->access$sendRecogFaceResponseMsg(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V

    .line 178
    :goto_0
    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/Object;

    .line 170
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1$callback$1;->onSuccess(Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;)V

    return-void
.end method
