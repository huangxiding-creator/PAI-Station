.class public Lcom/amazonaws/services/s3/internal/ServiceUtils;
.super Ljava/lang/Object;
.source "ServiceUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;
    }
.end annotation


# static fields
.field public static final APPEND_MODE:Z = true

.field protected static final DATE_UTILS:Lcom/amazonaws/util/DateUtils;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field private static final DEAFAULT_BYTE_SIZE:I = 0x2800

.field public static final OVERWRITE_MODE:Z = false

.field private static final log:Lcom/amazonaws/logging/Log;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 60
    const-class v0, Lcom/amazonaws/services/s3/internal/ServiceUtils;

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/internal/ServiceUtils;->log:Lcom/amazonaws/logging/Log;

    .line 71
    new-instance v0, Lcom/amazonaws/util/DateUtils;

    invoke-direct {v0}, Lcom/amazonaws/util/DateUtils;-><init>()V

    sput-object v0, Lcom/amazonaws/services/s3/internal/ServiceUtils;->DATE_UTILS:Lcom/amazonaws/util/DateUtils;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static convertRequestToUrl(Lcom/amazonaws/Request;)Ljava/net/URL;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;)",
            "Ljava/net/URL;"
        }
    .end annotation

    .line 170
    .local p0, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/amazonaws/services/s3/internal/ServiceUtils;->convertRequestToUrl(Lcom/amazonaws/Request;Z)Ljava/net/URL;

    move-result-object v0

    return-object v0
.end method

.method public static convertRequestToUrl(Lcom/amazonaws/Request;Z)Ljava/net/URL;
    .locals 9
    .param p1, "removeLeadingSlashInResourcePath"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;Z)",
            "Ljava/net/URL;"
        }
    .end annotation

    .line 188
    .local p0, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    invoke-interface {p0}, Lcom/amazonaws/Request;->getResourcePath()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/amazonaws/services/s3/internal/S3HttpUtils;->urlEncode(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    .line 192
    .local v0, "resourcePath":Ljava/lang/String;
    const-string v2, "/"

    if-eqz p1, :cond_0

    .line 193
    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 194
    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 201
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 202
    .local v1, "urlPath":Ljava/lang/String;
    const-string v2, "(?<=/)/"

    const-string v3, "%2F"

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 203
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {p0}, Lcom/amazonaws/Request;->getEndpoint()Ljava/net/URI;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 205
    .local v2, "urlString":Ljava/lang/String;
    const/4 v3, 0x1

    .line 206
    .local v3, "firstParam":Z
    invoke-interface {p0}, Lcom/amazonaws/Request;->getParameters()Ljava/util/Map;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 207
    .local v5, "param":Ljava/lang/String;
    if-eqz v3, :cond_1

    .line 208
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "?"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 209
    const/4 v3, 0x0

    goto :goto_1

    .line 211
    :cond_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "&"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 214
    :goto_1
    invoke-interface {p0}, Lcom/amazonaws/Request;->getParameters()Ljava/util/Map;

    move-result-object v6

    invoke-interface {v6, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 215
    .local v6, "value":Ljava/lang/String;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const/4 v8, 0x0

    invoke-static {v6, v8}, Lcom/amazonaws/services/s3/internal/S3HttpUtils;->urlEncode(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 216
    .end local v5    # "param":Ljava/lang/String;
    .end local v6    # "value":Ljava/lang/String;
    goto :goto_0

    .line 219
    :cond_2
    :try_start_0
    new-instance v4, Ljava/net/URL;

    invoke-direct {v4, v2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v4

    .line 220
    :catch_0
    move-exception v4

    .line 221
    .local v4, "e":Ljava/net/MalformedURLException;
    new-instance v5, Lcom/amazonaws/AmazonClientException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Unable to convert request to well formed URL: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 222
    invoke-virtual {v4}, Ljava/net/MalformedURLException;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6, v4}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v5
.end method

.method public static downloadObjectToFile(Lcom/amazonaws/services/s3/model/S3Object;Ljava/io/File;ZZ)V
    .locals 8
    .param p0, "s3Object"    # Lcom/amazonaws/services/s3/model/S3Object;
    .param p1, "destinationFile"    # Ljava/io/File;
    .param p2, "performIntegrityCheck"    # Z
    .param p3, "appendData"    # Z

    .line 268
    const-string v0, "Caught exception. Ignoring."

    invoke-virtual {p1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    .line 269
    .local v1, "parentDirectory":Ljava/io/File;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 270
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 273
    :cond_0
    const/4 v2, 0x0

    .line 275
    .local v2, "outputStream":Ljava/io/OutputStream;
    :try_start_0
    new-instance v3, Ljava/io/BufferedOutputStream;

    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, p1, p3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    invoke-direct {v3, v4}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v2, v3

    .line 277
    const/16 v3, 0x2800

    new-array v3, v3, [B

    .line 279
    .local v3, "buffer":[B
    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v4

    invoke-virtual {v4, v3}, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;->read([B)I

    move-result v4

    move v5, v4

    .local v5, "bytesRead":I
    const/4 v6, -0x1

    if-le v4, v6, :cond_1

    .line 280
    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4, v5}, Ljava/io/OutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 288
    .end local v3    # "buffer":[B
    .end local v5    # "bytesRead":I
    :cond_1
    :try_start_1
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 291
    goto :goto_1

    .line 289
    :catch_0
    move-exception v3

    .line 290
    .local v3, "e":Ljava/lang/Exception;
    sget-object v4, Lcom/amazonaws/services/s3/internal/ServiceUtils;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v4, v0}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 293
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_1
    :try_start_2
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 296
    goto :goto_2

    .line 294
    :catch_1
    move-exception v3

    .line 295
    .restart local v3    # "e":Ljava/lang/Exception;
    sget-object v4, Lcom/amazonaws/services/s3/internal/ServiceUtils;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v4, v0}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 297
    .end local v3    # "e":Ljava/lang/Exception;
    nop

    .line 299
    :goto_2
    const/4 v0, 0x0

    .line 300
    .local v0, "clientSideHash":[B
    const/4 v3, 0x0

    .line 304
    .local v3, "serverSideHash":[B
    :try_start_3
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v4

    invoke-virtual {v4}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getETag()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/amazonaws/services/s3/internal/ServiceUtils;->isMultipartUploadETag(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 305
    new-instance v4, Ljava/io/FileInputStream;

    invoke-direct {v4, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {v4}, Lcom/amazonaws/util/Md5Utils;->computeMD5Hash(Ljava/io/InputStream;)[B

    move-result-object v4

    move-object v0, v4

    .line 306
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v4

    invoke-virtual {v4}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getETag()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/amazonaws/util/BinaryUtils;->fromHex(Ljava/lang/String;)[B

    move-result-object v4
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    move-object v3, v4

    .line 310
    :cond_2
    goto :goto_3

    .line 308
    :catch_2
    move-exception v4

    .line 309
    .local v4, "e":Ljava/lang/Exception;
    sget-object v5, Lcom/amazonaws/services/s3/internal/ServiceUtils;->log:Lcom/amazonaws/logging/Log;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Unable to calculate MD5 hash to validate download: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v5, v6, v4}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 312
    .end local v4    # "e":Ljava/lang/Exception;
    :goto_3
    if-eqz p2, :cond_4

    if-eqz v0, :cond_4

    if-eqz v3, :cond_4

    .line 313
    invoke-static {v0, v3}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v4

    if-eqz v4, :cond_3

    goto :goto_4

    .line 314
    :cond_3
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Unable to verify integrity of data download.  Client calculated content hash didn\'t match hash calculated by Amazon S3.  The data stored in \'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 316
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\' may be corrupt."

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 319
    :cond_4
    :goto_4
    return-void

    .line 287
    .end local v0    # "clientSideHash":[B
    .end local v3    # "serverSideHash":[B
    :catchall_0
    move-exception v3

    goto :goto_5

    .line 282
    :catch_3
    move-exception v3

    .line 283
    .local v3, "e":Ljava/io/IOException;
    :try_start_4
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v4

    invoke-virtual {v4}, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;->abort()V

    .line 284
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Unable to store object contents to disk: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 285
    invoke-virtual {v3}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .end local v1    # "parentDirectory":Ljava/io/File;
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local p0    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .end local p1    # "destinationFile":Ljava/io/File;
    .end local p2    # "performIntegrityCheck":Z
    .end local p3    # "appendData":Z
    throw v4
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 288
    .end local v3    # "e":Ljava/io/IOException;
    .restart local v1    # "parentDirectory":Ljava/io/File;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .restart local p0    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .restart local p1    # "destinationFile":Ljava/io/File;
    .restart local p2    # "performIntegrityCheck":Z
    .restart local p3    # "appendData":Z
    :goto_5
    :try_start_5
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4

    .line 291
    goto :goto_6

    .line 289
    :catch_4
    move-exception v4

    .line 290
    .restart local v4    # "e":Ljava/lang/Exception;
    sget-object v5, Lcom/amazonaws/services/s3/internal/ServiceUtils;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v5, v0}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 293
    .end local v4    # "e":Ljava/lang/Exception;
    :goto_6
    :try_start_6
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v4

    invoke-virtual {v4}, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_5

    .line 296
    goto :goto_7

    .line 294
    :catch_5
    move-exception v4

    .line 295
    .restart local v4    # "e":Ljava/lang/Exception;
    sget-object v5, Lcom/amazonaws/services/s3/internal/ServiceUtils;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v5, v0}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 297
    .end local v4    # "e":Ljava/lang/Exception;
    :goto_7
    throw v3
.end method

.method public static formatIso8601Date(Ljava/util/Date;)Ljava/lang/String;
    .locals 1
    .param p0, "date"    # Ljava/util/Date;

    .line 88
    invoke-static {p0}, Lcom/amazonaws/util/DateUtils;->formatISO8601Date(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static formatRfc822Date(Ljava/util/Date;)Ljava/lang/String;
    .locals 1
    .param p0, "date"    # Ljava/util/Date;

    .line 106
    invoke-static {p0}, Lcom/amazonaws/util/DateUtils;->formatRFC822Date(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static isMultipartUploadETag(Ljava/lang/String;)Z
    .locals 1
    .param p0, "eTag"    # Ljava/lang/String;

    .line 118
    const-string v0, "-"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method public static join(Ljava/util/List;)Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 236
    .local p0, "strings":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const-string v0, ""

    .line 238
    .local v0, "result":Ljava/lang/String;
    const/4 v1, 0x1

    .line 239
    .local v1, "first":Z
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 240
    .local v3, "s":Ljava/lang/String;
    if-nez v1, :cond_0

    .line 241
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 244
    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 245
    const/4 v1, 0x0

    .line 246
    .end local v3    # "s":Ljava/lang/String;
    goto :goto_0

    .line 248
    :cond_1
    return-object v0
.end method

.method public static parseIso8601Date(Ljava/lang/String;)Ljava/util/Date;
    .locals 1
    .param p0, "dateString"    # Ljava/lang/String;

    .line 79
    invoke-static {p0}, Lcom/amazonaws/util/DateUtils;->parseISO8601Date(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v0

    return-object v0
.end method

.method public static parseRfc822Date(Ljava/lang/String;)Ljava/util/Date;
    .locals 1
    .param p0, "dateString"    # Ljava/lang/String;

    .line 97
    invoke-static {p0}, Lcom/amazonaws/util/DateUtils;->parseRFC822Date(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v0

    return-object v0
.end method

.method public static removeQuotes(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "s"    # Ljava/lang/String;

    .line 143
    if-nez p0, :cond_0

    .line 144
    const/4 v0, 0x0

    return-object v0

    .line 147
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 148
    const-string v0, "\""

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    .line 149
    invoke-virtual {p0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    .line 151
    :cond_1
    invoke-virtual {p0, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 152
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    sub-int/2addr v0, v2

    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    .line 155
    :cond_2
    return-object p0
.end method

.method public static retryableDownloadS3ObjectToFile(Ljava/io/File;Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;Z)Lcom/amazonaws/services/s3/model/S3Object;
    .locals 7
    .param p0, "file"    # Ljava/io/File;
    .param p1, "retryableS3DownloadTask"    # Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;
    .param p2, "appendData"    # Z

    .line 360
    const/4 v0, 0x0

    .line 364
    .local v0, "hasRetried":Z
    :cond_0
    const/4 v1, 0x0

    .line 365
    .local v1, "needRetry":Z
    invoke-interface {p1}, Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;->getS3ObjectStream()Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v2

    .line 366
    .local v2, "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    if-nez v2, :cond_1

    .line 367
    const/4 v3, 0x0

    return-object v3

    .line 371
    :cond_1
    nop

    .line 372
    :try_start_0
    invoke-interface {p1}, Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;->needIntegrityCheck()Z

    move-result v3

    .line 371
    invoke-static {v2, p0, v3, p2}, Lcom/amazonaws/services/s3/internal/ServiceUtils;->downloadObjectToFile(Lcom/amazonaws/services/s3/model/S3Object;Ljava/io/File;ZZ)V
    :try_end_0
    .catch Lcom/amazonaws/AmazonClientException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 402
    :goto_0
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;->abort()V

    .line 403
    goto :goto_1

    .line 402
    :catchall_0
    move-exception v3

    goto :goto_2

    .line 374
    :catch_0
    move-exception v3

    .line 375
    .local v3, "ace":Lcom/amazonaws/AmazonClientException;
    :try_start_1
    invoke-virtual {v3}, Lcom/amazonaws/AmazonClientException;->isRetryable()Z

    move-result v4

    if-eqz v4, :cond_4

    .line 388
    invoke-virtual {v3}, Lcom/amazonaws/AmazonClientException;->getCause()Ljava/lang/Throwable;

    move-result-object v4

    instance-of v4, v4, Ljava/net/SocketException;

    if-nez v4, :cond_3

    .line 389
    invoke-virtual {v3}, Lcom/amazonaws/AmazonClientException;->getCause()Ljava/lang/Throwable;

    move-result-object v4

    instance-of v4, v4, Ljavax/net/ssl/SSLProtocolException;

    if-nez v4, :cond_3

    .line 392
    const/4 v1, 0x1

    .line 393
    if-nez v0, :cond_2

    .line 396
    sget-object v4, Lcom/amazonaws/services/s3/internal/ServiceUtils;->log:Lcom/amazonaws/logging/Log;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Retry the download of object "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/S3Object;->getKey()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " (bucket "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 397
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/S3Object;->getBucketName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ")"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 396
    invoke-interface {v4, v5, v3}, Lcom/amazonaws/logging/Log;->info(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 398
    const/4 v0, 0x1

    .end local v3    # "ace":Lcom/amazonaws/AmazonClientException;
    goto :goto_0

    .line 404
    :goto_1
    if-nez v1, :cond_0

    .line 405
    return-object v2

    .line 394
    .restart local v3    # "ace":Lcom/amazonaws/AmazonClientException;
    :cond_2
    nop

    .end local v0    # "hasRetried":Z
    .end local v1    # "needRetry":Z
    .end local v2    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .end local p0    # "file":Ljava/io/File;
    .end local p1    # "retryableS3DownloadTask":Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;
    .end local p2    # "appendData":Z
    throw v3

    .line 390
    .restart local v0    # "hasRetried":Z
    .restart local v1    # "needRetry":Z
    .restart local v2    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .restart local p0    # "file":Ljava/io/File;
    .restart local p1    # "retryableS3DownloadTask":Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;
    .restart local p2    # "appendData":Z
    :cond_3
    nop

    .end local v0    # "hasRetried":Z
    .end local v1    # "needRetry":Z
    .end local v2    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .end local p0    # "file":Ljava/io/File;
    .end local p1    # "retryableS3DownloadTask":Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;
    .end local p2    # "appendData":Z
    throw v3

    .line 376
    .restart local v0    # "hasRetried":Z
    .restart local v1    # "needRetry":Z
    .restart local v2    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .restart local p0    # "file":Ljava/io/File;
    .restart local p1    # "retryableS3DownloadTask":Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;
    .restart local p2    # "appendData":Z
    :cond_4
    nop

    .end local v0    # "hasRetried":Z
    .end local v1    # "needRetry":Z
    .end local v2    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .end local p0    # "file":Ljava/io/File;
    .end local p1    # "retryableS3DownloadTask":Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;
    .end local p2    # "appendData":Z
    throw v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 402
    .end local v3    # "ace":Lcom/amazonaws/AmazonClientException;
    .restart local v0    # "hasRetried":Z
    .restart local v1    # "needRetry":Z
    .restart local v2    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .restart local p0    # "file":Ljava/io/File;
    .restart local p1    # "retryableS3DownloadTask":Lcom/amazonaws/services/s3/internal/ServiceUtils$RetryableS3DownloadTask;
    .restart local p2    # "appendData":Z
    :goto_2
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v4

    invoke-virtual {v4}, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;->abort()V

    .line 403
    throw v3
.end method

.method public static skipMd5CheckPerRequest(Lcom/amazonaws/AmazonWebServiceRequest;)Z
    .locals 1
    .param p0, "request"    # Lcom/amazonaws/AmazonWebServiceRequest;

    .line 463
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/amazonaws/services/s3/internal/ServiceUtils;->skipMd5CheckPerRequest(Lcom/amazonaws/AmazonWebServiceRequest;Lcom/amazonaws/services/s3/S3ClientOptions;)Z

    move-result v0

    return v0
.end method

.method public static skipMd5CheckPerRequest(Lcom/amazonaws/AmazonWebServiceRequest;Lcom/amazonaws/services/s3/S3ClientOptions;)Z
    .locals 5
    .param p0, "request"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .param p1, "clientOptions"    # Lcom/amazonaws/services/s3/S3ClientOptions;

    .line 475
    const/4 v0, 0x1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/S3ClientOptions;->isContentMd5CheckSkipped()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 476
    return v0

    .line 479
    :cond_0
    const-string v1, "com.amazonaws.services.s3.disableGetObjectMD5Validation"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 480
    return v0

    .line 483
    :cond_1
    instance-of v1, p0, Lcom/amazonaws/services/s3/model/GetObjectRequest;

    const/4 v2, 0x0

    if-eqz v1, :cond_4

    .line 484
    move-object v1, p0

    check-cast v1, Lcom/amazonaws/services/s3/model/GetObjectRequest;

    .line 486
    .local v1, "getObjectRequest":Lcom/amazonaws/services/s3/model/GetObjectRequest;
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/GetObjectRequest;->getRange()[J

    move-result-object v3

    if-eqz v3, :cond_2

    .line 487
    return v0

    .line 489
    :cond_2
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/GetObjectRequest;->getSSECustomerKey()Lcom/amazonaws/services/s3/model/SSECustomerKey;

    move-result-object v3

    if-eqz v3, :cond_3

    .line 490
    return v0

    .line 492
    .end local v1    # "getObjectRequest":Lcom/amazonaws/services/s3/model/GetObjectRequest;
    :cond_3
    goto :goto_1

    :cond_4
    instance-of v1, p0, Lcom/amazonaws/services/s3/model/PutObjectRequest;

    if-eqz v1, :cond_8

    .line 493
    move-object v1, p0

    check-cast v1, Lcom/amazonaws/services/s3/model/PutObjectRequest;

    .line 494
    .local v1, "putObjectRequest":Lcom/amazonaws/services/s3/model/PutObjectRequest;
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v3

    .line 495
    .local v3, "om":Lcom/amazonaws/services/s3/model/ObjectMetadata;
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getSSEAlgorithm()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_5

    .line 496
    return v0

    .line 498
    :cond_5
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getSSECustomerKey()Lcom/amazonaws/services/s3/model/SSECustomerKey;

    move-result-object v4

    if-eqz v4, :cond_6

    .line 499
    return v0

    .line 501
    :cond_6
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getSSEAwsKeyManagementParams()Lcom/amazonaws/services/s3/model/SSEAwsKeyManagementParams;

    move-result-object v4

    if-eqz v4, :cond_a

    .line 502
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getSSEAwsKeyManagementParams()Lcom/amazonaws/services/s3/model/SSEAwsKeyManagementParams;

    move-result-object v4

    invoke-virtual {v4}, Lcom/amazonaws/services/s3/model/SSEAwsKeyManagementParams;->getEncryption()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_7

    .line 503
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getSSEAwsKeyManagementParams()Lcom/amazonaws/services/s3/model/SSEAwsKeyManagementParams;

    move-result-object v4

    invoke-virtual {v4}, Lcom/amazonaws/services/s3/model/SSEAwsKeyManagementParams;->getAwsKmsKeyId()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_a

    .line 504
    :cond_7
    return v0

    .line 506
    .end local v1    # "putObjectRequest":Lcom/amazonaws/services/s3/model/PutObjectRequest;
    .end local v3    # "om":Lcom/amazonaws/services/s3/model/ObjectMetadata;
    :cond_8
    instance-of v1, p0, Lcom/amazonaws/services/s3/model/UploadPartRequest;

    if-eqz v1, :cond_a

    .line 507
    move-object v1, p0

    check-cast v1, Lcom/amazonaws/services/s3/model/UploadPartRequest;

    .line 508
    .local v1, "uploadPartRequest":Lcom/amazonaws/services/s3/model/UploadPartRequest;
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getSSECustomerKey()Lcom/amazonaws/services/s3/model/SSECustomerKey;

    move-result-object v3

    if-eqz v3, :cond_9

    goto :goto_0

    :cond_9
    move v0, v2

    :goto_0
    return v0

    .line 506
    .end local v1    # "uploadPartRequest":Lcom/amazonaws/services/s3/model/UploadPartRequest;
    :cond_a
    nop

    .line 511
    :goto_1
    return v2
.end method

.method public static skipMd5CheckPerResponse(Lcom/amazonaws/services/s3/model/ObjectMetadata;)Z
    .locals 1
    .param p0, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;

    .line 423
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/amazonaws/services/s3/internal/ServiceUtils;->skipMd5CheckPerResponse(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/S3ClientOptions;)Z

    move-result v0

    return v0
.end method

.method public static skipMd5CheckPerResponse(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/S3ClientOptions;)Z
    .locals 4
    .param p0, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .param p1, "clientOptions"    # Lcom/amazonaws/services/s3/S3ClientOptions;

    .line 442
    const/4 v0, 0x1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/S3ClientOptions;->isContentMd5CheckSkipped()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 443
    return v0

    .line 446
    :cond_0
    const/4 v1, 0x0

    if-nez p0, :cond_1

    .line 447
    return v1

    .line 449
    :cond_1
    sget-object v2, Lcom/amazonaws/services/s3/model/SSEAlgorithm;->KMS:Lcom/amazonaws/services/s3/model/SSEAlgorithm;

    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/SSEAlgorithm;->toString()Ljava/lang/String;

    move-result-object v2

    .line 450
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getSSEAlgorithm()Ljava/lang/String;

    move-result-object v3

    .line 449
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    .line 451
    .local v2, "sseKMS":Z
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getSSECustomerAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    if-eqz v2, :cond_2

    goto :goto_0

    :cond_2
    move v0, v1

    :cond_3
    :goto_0
    return v0
.end method

.method public static toByteArray(Ljava/lang/String;)[B
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .line 131
    sget-object v0, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    return-object v0
.end method
