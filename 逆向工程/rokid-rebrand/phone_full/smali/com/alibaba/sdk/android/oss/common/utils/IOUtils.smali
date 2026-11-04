.class public Lcom/alibaba/sdk/android/oss/common/utils/IOUtils;
.super Ljava/lang/Object;
.source "IOUtils.java"


# static fields
.field private static final BUFFER_SIZE:I = 0x1000


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static readStreamAsBytesArray(Ljava/io/InputStream;)[B
    .locals 6
    .param p0, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 59
    const/4 v0, 0x0

    if-nez p0, :cond_0

    .line 60
    new-array v0, v0, [B

    return-object v0

    .line 63
    :cond_0
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 64
    .local v1, "output":Ljava/io/ByteArrayOutputStream;
    const/16 v2, 0x1000

    new-array v2, v2, [B

    .line 66
    .local v2, "buffer":[B
    :goto_0
    invoke-virtual {p0, v2}, Ljava/io/InputStream;->read([B)I

    move-result v3

    move v4, v3

    .local v4, "len":I
    const/4 v5, -0x1

    if-le v3, v5, :cond_1

    .line 67
    invoke-virtual {v1, v2, v0, v4}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 69
    :cond_1
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->flush()V

    .line 70
    invoke-static {v1}, Lcom/alibaba/sdk/android/oss/common/utils/IOUtils;->safeClose(Ljava/io/OutputStream;)V

    .line 71
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0
.end method

.method public static readStreamAsBytesArray(Ljava/io/InputStream;I)[B
    .locals 9
    .param p0, "in"    # Ljava/io/InputStream;
    .param p1, "readLength"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 76
    const/4 v0, 0x0

    if-nez p0, :cond_0

    .line 77
    new-array v0, v0, [B

    return-object v0

    .line 80
    :cond_0
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 81
    .local v1, "output":Ljava/io/ByteArrayOutputStream;
    const/16 v2, 0x1000

    new-array v2, v2, [B

    .line 83
    .local v2, "buffer":[B
    const-wide/16 v3, 0x0

    .line 84
    .local v3, "readed":J
    :goto_0
    int-to-long v5, p1

    cmp-long v5, v3, v5

    if-gez v5, :cond_1

    int-to-long v5, p1

    sub-long/2addr v5, v3

    long-to-int v5, v5

    const/16 v6, 0x800

    invoke-static {v6, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    invoke-virtual {p0, v2, v0, v5}, Ljava/io/InputStream;->read([BII)I

    move-result v5

    move v6, v5

    .local v6, "len":I
    const/4 v7, -0x1

    if-le v5, v7, :cond_1

    .line 85
    invoke-virtual {v1, v2, v0, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 86
    int-to-long v7, v6

    add-long/2addr v3, v7

    goto :goto_0

    .line 88
    .end local v6    # "len":I
    :cond_1
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->flush()V

    .line 89
    invoke-static {v1}, Lcom/alibaba/sdk/android/oss/common/utils/IOUtils;->safeClose(Ljava/io/OutputStream;)V

    .line 90
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0
.end method

.method public static readStreamAsString(Ljava/io/InputStream;Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p0, "in"    # Ljava/io/InputStream;
    .param p1, "charset"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 26
    if-nez p0, :cond_0

    .line 27
    const-string v0, ""

    return-object v0

    .line 29
    :cond_0
    const/4 v0, 0x0

    .line 30
    .local v0, "reader":Ljava/io/Reader;
    new-instance v1, Ljava/io/StringWriter;

    invoke-direct {v1}, Ljava/io/StringWriter;-><init>()V

    .line 33
    .local v1, "writer":Ljava/io/Writer;
    const/16 v2, 0x1000

    new-array v2, v2, [C

    .line 35
    .local v2, "buffer":[C
    :try_start_0
    new-instance v3, Ljava/io/BufferedReader;

    new-instance v4, Ljava/io/InputStreamReader;

    invoke-direct {v4, p0, p1}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    move-object v0, v3

    .line 39
    :goto_0
    invoke-virtual {v0, v2}, Ljava/io/Reader;->read([C)I

    move-result v3

    move v4, v3

    .local v4, "n":I
    if-lez v3, :cond_1

    .line 40
    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3, v4}, Ljava/io/Writer;->write([CII)V

    goto :goto_0

    .line 43
    :cond_1
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 45
    .end local v4    # "n":I
    .local v3, "result":Ljava/lang/String;
    invoke-static {p0}, Lcom/alibaba/sdk/android/oss/common/utils/IOUtils;->safeClose(Ljava/io/InputStream;)V

    .line 46
    nop

    .line 47
    invoke-virtual {v0}, Ljava/io/Reader;->close()V

    .line 49
    nop

    .line 50
    invoke-virtual {v1}, Ljava/io/Writer;->close()V

    .line 54
    return-object v3

    .line 45
    .end local v3    # "result":Ljava/lang/String;
    :catchall_0
    move-exception v3

    invoke-static {p0}, Lcom/alibaba/sdk/android/oss/common/utils/IOUtils;->safeClose(Ljava/io/InputStream;)V

    .line 46
    if-eqz v0, :cond_2

    .line 47
    invoke-virtual {v0}, Ljava/io/Reader;->close()V

    .line 49
    :cond_2
    nop

    .line 50
    invoke-virtual {v1}, Ljava/io/Writer;->close()V

    .line 52
    throw v3
.end method

.method public static safeClose(Ljava/io/InputStream;)V
    .locals 1
    .param p0, "inputStream"    # Ljava/io/InputStream;

    .line 94
    if-eqz p0, :cond_0

    .line 96
    :try_start_0
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 98
    goto :goto_0

    .line 97
    :catch_0
    move-exception v0

    .line 100
    :cond_0
    :goto_0
    return-void
.end method

.method public static safeClose(Ljava/io/OutputStream;)V
    .locals 1
    .param p0, "outputStream"    # Ljava/io/OutputStream;

    .line 103
    if-eqz p0, :cond_0

    .line 105
    :try_start_0
    invoke-virtual {p0}, Ljava/io/OutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 107
    goto :goto_0

    .line 106
    :catch_0
    move-exception v0

    .line 109
    :cond_0
    :goto_0
    return-void
.end method
