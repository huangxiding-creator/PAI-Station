.class public final Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;
.super Lokio/ForwardingSink;
.source "ProgressRequestBody.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "CountingSink"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u0086\u0004\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u0018\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\u0006H\u0016R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;",
        "Lokio/ForwardingSink;",
        "delegate",
        "Lokio/Sink;",
        "(Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;Lokio/Sink;)V",
        "bytesWritten",
        "",
        "contentLength",
        "write",
        "",
        "source",
        "Lokio/Buffer;",
        "byteCount",
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
.field private bytesWritten:J

.field private final contentLength:J

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;


# direct methods
.method public constructor <init>(Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;Lokio/Sink;)V
    .locals 2
    .param p1, "this$0"    # Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;
    .param p2, "delegate"    # Lokio/Sink;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lokio/Sink;",
            ")V"
        }
    .end annotation

    const-string v0, "delegate"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;

    invoke-direct {p0, p2}, Lokio/ForwardingSink;-><init>(Lokio/Sink;)V

    .line 36
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;->contentLength()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;->contentLength:J

    .line 34
    return-void
.end method


# virtual methods
.method public write(Lokio/Buffer;J)V
    .locals 4
    .param p1, "source"    # Lokio/Buffer;
    .param p2, "byteCount"    # J

    const-string/jumbo v0, "source"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 39
    invoke-super {p0, p1, p2, p3}, Lokio/ForwardingSink;->write(Lokio/Buffer;J)V

    .line 40
    iget-wide v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;->bytesWritten:J

    add-long/2addr v0, p2

    iput-wide v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;->bytesWritten:J

    .line 41
    const/16 v0, 0x64

    int-to-long v0, v0

    iget-wide v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;->bytesWritten:J

    mul-long/2addr v0, v2

    iget-wide v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;->contentLength:J

    div-long/2addr v0, v2

    long-to-int v0, v0

    .line 42
    .local v0, "progress":I
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;->access$getListener$p(Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;)Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;->onProgress(I)V

    .line 43
    return-void
.end method
