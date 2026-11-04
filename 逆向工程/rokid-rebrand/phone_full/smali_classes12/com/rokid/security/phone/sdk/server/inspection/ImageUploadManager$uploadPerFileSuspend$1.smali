.class final Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;
.super Lkotlin/coroutines/jvm/internal/ContinuationImpl;
.source "ImageUploadManager.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->uploadPerFileSuspend(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.security.phone.sdk.server.inspection.ImageUploadManager"
    f = "ImageUploadManager.kt"
    i = {
        0x1,
        0x1,
        0x1,
        0x2,
        0x2,
        0x2
    }
    l = {
        0x56,
        0x5c,
        0x6d
    }
    m = "uploadPerFileSuspend"
    n = {
        "this",
        "filePath",
        "deferred",
        "this",
        "filePath",
        "deferred"
    }
    s = {
        "L$0",
        "L$1",
        "L$2",
        "L$0",
        "L$1",
        "L$2"
    }
.end annotation


# instance fields
.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field label:I

.field synthetic result:Ljava/lang/Object;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;Lkotlin/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    invoke-direct {p0, p2}, Lkotlin/coroutines/jvm/internal/ContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->result:Ljava/lang/Object;

    iget v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->label:I

    const/high16 v1, -0x80000000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->label:I

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    const/4 v1, 0x0

    move-object v2, p0

    check-cast v2, Lkotlin/coroutines/Continuation;

    invoke-static {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->access$uploadPerFileSuspend(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
