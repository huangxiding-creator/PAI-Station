.class public final Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;
.super Lokio/ForwardingSource;
.source "ProgressResponseBody.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->createSource(Lokio/Source;)Lokio/BufferedSource;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\u0003H\u0016R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0004\u001a\u00020\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\n"
    }
    d2 = {
        "com/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1",
        "Lokio/ForwardingSource;",
        "bytesRead",
        "",
        "lastProgress",
        "",
        "read",
        "sink",
        "Lokio/Buffer;",
        "byteCount",
        "base-utils_release"
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
.field private bytesRead:J

.field private lastProgress:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;


# direct methods
.method constructor <init>(Lokio/Source;Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;)V
    .locals 0
    .param p1, "$source"    # Lokio/Source;
    .param p2, "$receiver"    # Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->this$0:Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    .line 43
    invoke-direct {p0, p1}, Lokio/ForwardingSource;-><init>(Lokio/Source;)V

    return-void
.end method


# virtual methods
.method public read(Lokio/Buffer;J)J
    .locals 15
    .param p1, "sink"    # Lokio/Buffer;
    .param p2, "byteCount"    # J

    move-object v0, p0

    const-string/jumbo v1, "sink"

    move-object/from16 v2, p1

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    invoke-super/range {p0 .. p3}, Lokio/ForwardingSource;->read(Lokio/Buffer;J)J

    move-result-wide v3

    .line 49
    .local v3, "bytes":J
    iget-wide v5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->bytesRead:J

    const-wide/16 v7, -0x1

    cmp-long v1, v3, v7

    const-wide/16 v9, 0x0

    if-eqz v1, :cond_0

    move-wide v11, v3

    goto :goto_0

    :cond_0
    move-wide v11, v9

    :goto_0
    add-long/2addr v5, v11

    iput-wide v5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->bytesRead:J

    .line 52
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->this$0:Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->contentLength()J

    move-result-wide v5

    cmp-long v1, v5, v9

    if-lez v1, :cond_1

    .line 53
    iget-wide v5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->bytesRead:J

    const/16 v1, 0x64

    int-to-long v9, v1

    mul-long/2addr v5, v9

    iget-object v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->this$0:Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->contentLength()J

    move-result-wide v9

    div-long/2addr v5, v9

    long-to-int v1, v5

    goto :goto_1

    .line 54
    :cond_1
    const/4 v1, 0x0

    .line 52
    :goto_1
    nop

    .line 57
    .local v1, "progress":I
    iget v5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->lastProgress:I

    const/4 v6, 0x0

    if-eq v1, v5, :cond_2

    .line 58
    iput v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->lastProgress:I

    .line 59
    iget-object v5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->this$0:Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->access$getScope$p(Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v9

    new-instance v5, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1$read$1;

    iget-object v10, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->this$0:Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    invoke-direct {v5, v10, v1, v6}, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1$read$1;-><init>(Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;ILkotlin/coroutines/Continuation;)V

    move-object v12, v5

    check-cast v12, Lkotlin/jvm/functions/Function2;

    const/4 v13, 0x3

    const/4 v14, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-static/range {v9 .. v14}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 65
    :cond_2
    cmp-long v5, v3, v7

    if-nez v5, :cond_3

    .line 66
    iget-object v5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->this$0:Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->access$getScope$p(Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v7

    new-instance v5, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1$read$2;

    iget-object v8, v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;->this$0:Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    invoke-direct {v5, v8, v6}, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1$read$2;-><init>(Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;Lkotlin/coroutines/Continuation;)V

    move-object v10, v5

    check-cast v10, Lkotlin/jvm/functions/Function2;

    const/4 v11, 0x3

    const/4 v12, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-static/range {v7 .. v12}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 71
    :cond_3
    return-wide v3
.end method
