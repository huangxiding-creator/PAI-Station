.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;
.super Ljava/lang/Object;
.source "DownloadHelper.kt"

# interfaces
.implements Lokhttp3/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->download(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nDownloadHelper.kt\nKotlin\n*S Kotlin\n*F\n+ 1 DownloadHelper.kt\ncom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,204:1\n1#2:205\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000%\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\t\u001a\u00020\nH\u0016\u00a8\u0006\u000b"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1",
        "Lokhttp3/Callback;",
        "onFailure",
        "",
        "call",
        "Lokhttp3/Call;",
        "e",
        "Ljava/io/IOException;",
        "onResponse",
        "response",
        "Lokhttp3/Response;",
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
.field final synthetic $filePath:Ljava/lang/String;

.field final synthetic $listener:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

.field final synthetic $request:Lokhttp3/Request;

.field final synthetic $url:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "$listener"    # Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;
    .param p2, "$request"    # Lokhttp3/Request;
    .param p3, "$filePath"    # Ljava/lang/String;
    .param p4, "$url"    # Ljava/lang/String;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$listener:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$request:Lokhttp3/Request;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$filePath:Ljava/lang/String;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$url:Ljava/lang/String;

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Lokhttp3/Call;Ljava/io/IOException;)V
    .locals 2
    .param p1, "call"    # Lokhttp3/Call;
    .param p2, "e"    # Ljava/io/IOException;

    const-string v0, "call"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "e"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 66
    invoke-virtual {p2}, Ljava/io/IOException;->printStackTrace()V

    .line 67
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$listener:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    move-object v1, p2

    check-cast v1, Ljava/lang/Exception;

    invoke-interface {v0, v1}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;->onError(Ljava/lang/Exception;)V

    .line 68
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getDownloadingSet$p()Ljava/util/Set;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$request:Lokhttp3/Request;

    invoke-virtual {v1}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 69
    return-void
.end method

.method public onResponse(Lokhttp3/Call;Lokhttp3/Response;)V
    .locals 12
    .param p1, "call"    # Lokhttp3/Call;
    .param p2, "response"    # Lokhttp3/Response;

    const-string v0, "call"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "response"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 72
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "response = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 73
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "responseHeader = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 74
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "responseBody = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/io/InputStream;->available()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 75
    const/4 v0, 0x0

    .line 76
    .local v0, "ips":Ljava/io/InputStream;
    const/16 v1, 0x800

    new-array v1, v1, [B

    .line 77
    .local v1, "buf":[B
    const/4 v2, 0x0

    .line 78
    .local v2, "len":I
    const/4 v3, 0x0

    .line 80
    .local v3, "fos":Ljava/io/FileOutputStream;
    nop

    .line 81
    :try_start_0
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v4

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v4}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v4

    move-object v0, v4

    .line 82
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v4

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v4}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v4

    .line 83
    .local v4, "total":J
    new-instance v6, Ljava/io/File;

    iget-object v7, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$filePath:Ljava/lang/String;

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 84
    .local v6, "file":Ljava/io/File;
    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 85
    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    .line 87
    :cond_1
    new-instance v7, Ljava/io/FileOutputStream;

    invoke-direct {v7, v6}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    move-object v3, v7

    .line 88
    const-wide/16 v7, 0x0

    .line 89
    .local v7, "sum":J
    :goto_1
    invoke-virtual {v0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v9

    move v10, v9

    .line 205
    .local v10, "it":I
    const/4 v11, 0x0

    .line 89
    .local v11, "$i$a$-also-DownloadHelper$download$1$onResponse$1":I
    move v2, v10

    .end local v10    # "it":I
    .end local v11    # "$i$a$-also-DownloadHelper$download$1$onResponse$1":I
    const/4 v10, -0x1

    if-eq v9, v10, :cond_2

    .line 90
    const/4 v9, 0x0

    invoke-virtual {v3, v1, v9, v2}, Ljava/io/FileOutputStream;->write([BII)V

    .line 91
    int-to-long v9, v2

    add-long/2addr v7, v9

    .line 93
    iget-object v9, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$listener:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    invoke-interface {v9, v7, v8, v4, v5}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;->onProgress(JJ)V

    goto :goto_1

    .line 95
    :cond_2
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->flush()V

    .line 97
    iget-object v9, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$listener:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    invoke-interface {v9}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;->onComplete()V

    .line 98
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getDownloadingSet$p()Ljava/util/Set;

    move-result-object v9

    iget-object v10, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$request:Lokhttp3/Request;

    invoke-virtual {v10}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v10

    invoke-interface {v9, v10}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 105
    nop

    .end local v4    # "total":J
    .end local v6    # "file":Ljava/io/File;
    .end local v7    # "sum":J
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getDownloadingSet$p()Ljava/util/Set;

    move-result-object v4

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$request:Lokhttp3/Request;

    invoke-virtual {v5}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 106
    nop

    .line 107
    if-eqz v0, :cond_3

    :try_start_1
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .line 108
    :catch_0
    move-exception v4

    .line 110
    :cond_3
    :goto_2
    nop

    .line 111
    :try_start_2
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_4

    .line 112
    :catch_1
    move-exception v4

    goto :goto_4

    .line 105
    :catchall_0
    move-exception v4

    goto :goto_5

    .line 99
    :catch_2
    move-exception v4

    .line 100
    .local v4, "e":Ljava/lang/Exception;
    :try_start_3
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getTAG$p()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "\u4e0b\u8f7d\u51fa\u9519-"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$url:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    filled-new-array {v6, v7}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 101
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V

    .line 102
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$listener:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    invoke-interface {v5, v4}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;->onError(Ljava/lang/Exception;)V

    .line 103
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getDownloadingSet$p()Ljava/util/Set;

    move-result-object v5

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$request:Lokhttp3/Request;

    invoke-virtual {v6}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v6

    invoke-interface {v5, v6}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 105
    nop

    .end local v4    # "e":Ljava/lang/Exception;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getDownloadingSet$p()Ljava/util/Set;

    move-result-object v4

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$request:Lokhttp3/Request;

    invoke-virtual {v5}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 106
    nop

    .line 107
    if-eqz v0, :cond_4

    :try_start_4
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_3

    .line 108
    :catch_3
    move-exception v4

    .line 110
    :cond_4
    :goto_3
    nop

    .line 111
    if-eqz v3, :cond_5

    :try_start_5
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4

    goto :goto_4

    .line 112
    :catch_4
    move-exception v4

    .line 114
    :cond_5
    :goto_4
    nop

    .line 115
    return-void

    .line 105
    :goto_5
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->access$getDownloadingSet$p()Ljava/util/Set;

    move-result-object v5

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;->$request:Lokhttp3/Request;

    invoke-virtual {v6}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v6

    invoke-interface {v5, v6}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 106
    nop

    .line 107
    if-eqz v0, :cond_6

    :try_start_6
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_5

    goto :goto_6

    .line 108
    :catch_5
    move-exception v5

    .line 110
    :cond_6
    :goto_6
    nop

    .line 111
    if-eqz v3, :cond_7

    :try_start_7
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_6

    goto :goto_7

    .line 112
    :catch_6
    move-exception v5

    :cond_7
    :goto_7
    throw v4
.end method
