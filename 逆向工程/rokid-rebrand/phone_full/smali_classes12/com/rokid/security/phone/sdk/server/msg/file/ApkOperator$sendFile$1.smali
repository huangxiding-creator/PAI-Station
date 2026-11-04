.class final Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;
.super Lkotlin/jvm/internal/Lambda;
.source "ApkOperator.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->sendFile(Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Ljava/lang/Boolean;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "it",
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
.field final synthetic $file:Ljava/io/File;

.field final synthetic $listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->$file:Ljava/io/File;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 26
    move-object v0, p1

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->invoke(Z)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Z)V
    .locals 2
    .param p1, "it"    # Z

    .line 27
    if-eqz p1, :cond_0

    .line 28
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->$file:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$setFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Ljava/io/File;)V

    .line 29
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$setMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;)V

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->$file:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$startSendApk(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Ljava/io/File;)V

    goto :goto_0

    .line 32
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " sendFile:  P2P not connect"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 33
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$getMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v1, "P2P not connect"

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;->onError(Ljava/lang/String;)V

    .line 35
    :cond_1
    :goto_0
    return-void
.end method
