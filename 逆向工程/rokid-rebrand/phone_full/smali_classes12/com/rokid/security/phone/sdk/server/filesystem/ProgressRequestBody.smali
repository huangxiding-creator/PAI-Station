.class public final Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;
.super Lokhttp3/RequestBody;
.source "ProgressRequestBody.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0018\u00002\u00020\u0001:\u0001\u000eB\u0015\u0012\u0006\u0010\u0002\u001a\u00020\u0001\u0012\u0006\u0010\u0003\u001a\u00020\u0004\u00a2\u0006\u0002\u0010\u0005J\u0008\u0010\u0006\u001a\u00020\u0007H\u0016J\n\u0010\u0008\u001a\u0004\u0018\u00010\tH\u0016J\u0010\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\rH\u0016R\u000e\u0010\u0002\u001a\u00020\u0001X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;",
        "Lokhttp3/RequestBody;",
        "delegate",
        "listener",
        "Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;",
        "(Lokhttp3/RequestBody;Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;)V",
        "contentLength",
        "",
        "contentType",
        "Lokhttp3/MediaType;",
        "writeTo",
        "",
        "sink",
        "Lokio/BufferedSink;",
        "CountingSink",
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
.field private final delegate:Lokhttp3/RequestBody;

.field private final listener:Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;


# direct methods
.method public constructor <init>(Lokhttp3/RequestBody;Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;)V
    .locals 1
    .param p1, "delegate"    # Lokhttp3/RequestBody;
    .param p2, "listener"    # Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;

    const-string v0, "delegate"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    invoke-direct {p0}, Lokhttp3/RequestBody;-><init>()V

    .line 18
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;->delegate:Lokhttp3/RequestBody;

    .line 19
    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;->listener:Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;

    .line 17
    return-void
.end method

.method public static final synthetic access$getListener$p(Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;)Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;

    .line 17
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;->listener:Lcom/rokid/security/sdk/base/common/filesystem/UploadProgressListener;

    return-object v0
.end method


# virtual methods
.method public contentLength()J
    .locals 2

    .line 24
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;->delegate:Lokhttp3/RequestBody;

    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v0

    return-wide v0
.end method

.method public contentType()Lokhttp3/MediaType;
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;->delegate:Lokhttp3/RequestBody;

    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentType()Lokhttp3/MediaType;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Lokio/BufferedSink;)V
    .locals 2
    .param p1, "sink"    # Lokio/BufferedSink;

    const-string/jumbo v0, "sink"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    new-instance v0, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;

    move-object v1, p1

    check-cast v1, Lokio/Sink;

    invoke-direct {v0, p0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;-><init>(Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody;Lokio/Sink;)V

    .line 32
    .local v0, "countingSink":Lcom/rokid/security/phone/sdk/server/filesystem/ProgressRequestBody$CountingSink;
    return-void
.end method
