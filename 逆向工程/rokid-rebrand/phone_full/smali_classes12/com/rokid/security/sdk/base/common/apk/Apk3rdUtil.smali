.class public final Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;
.super Ljava/lang/Object;
.source "Apk3rdUtil.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\nJ\u000e\u0010\u000b\u001a\u00020\n2\u0006\u0010\u000c\u001a\u00020\u0008R\u0014\u0010\u0003\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;",
        "",
        "()V",
        "port",
        "",
        "getPort",
        "()I",
        "deserializeFileInfo",
        "Lcom/rokid/security/sdk/base/common/apk/FileInfo;",
        "data",
        "",
        "serializeFileInfo",
        "info",
        "sdk-base-common_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;

.field private static final port:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;->INSTANCE:Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;

    .line 10
    const/16 v0, 0x8ba

    sput v0, Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;->port:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final deserializeFileInfo([B)Lcom/rokid/security/sdk/base/common/apk/FileInfo;
    .locals 12
    .param p1, "data"    # [B

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    new-instance v0, Ljava/io/ByteArrayInputStream;

    invoke-direct {v0, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    check-cast v0, Ljava/io/Closeable;

    :try_start_0
    move-object v1, v0

    check-cast v1, Ljava/io/ByteArrayInputStream;

    .local v1, "byteIn":Ljava/io/ByteArrayInputStream;
    const/4 v2, 0x0

    .line 30
    .local v2, "$i$a$-use-Apk3rdUtil$deserializeFileInfo$1":I
    new-instance v3, Ljava/io/DataInputStream;

    move-object v4, v1

    check-cast v4, Ljava/io/InputStream;

    invoke-direct {v3, v4}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    check-cast v3, Ljava/io/Closeable;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    :try_start_1
    move-object v4, v3

    check-cast v4, Ljava/io/DataInputStream;

    .local v4, "dataIn":Ljava/io/DataInputStream;
    const/4 v5, 0x0

    .line 31
    .local v5, "$i$a$-use-Apk3rdUtil$deserializeFileInfo$1$1":I
    invoke-virtual {v4}, Ljava/io/DataInputStream;->readUTF()Ljava/lang/String;

    move-result-object v6

    .line 32
    .local v6, "fileName":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/io/DataInputStream;->readLong()J

    move-result-wide v7

    .line 33
    .local v7, "fileSize":J
    invoke-virtual {v4}, Ljava/io/DataInputStream;->readUTF()Ljava/lang/String;

    move-result-object v9

    .line 34
    .local v9, "fileType":Ljava/lang/String;
    new-instance v10, Lcom/rokid/security/sdk/base/common/apk/FileInfo;

    const-string v11, "fileName"

    invoke-static {v6, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v11, "fileType"

    invoke-static {v9, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v10, v6, v7, v8, v9}, Lcom/rokid/security/sdk/base/common/apk/FileInfo;-><init>(Ljava/lang/String;JLjava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 30
    .end local v4    # "dataIn":Ljava/io/DataInputStream;
    .end local v5    # "$i$a$-use-Apk3rdUtil$deserializeFileInfo$1$1":I
    .end local v6    # "fileName":Ljava/lang/String;
    .end local v7    # "fileSize":J
    .end local v9    # "fileType":Ljava/lang/String;
    const/4 v4, 0x0

    :try_start_2
    invoke-static {v3, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 29
    .end local v1    # "byteIn":Ljava/io/ByteArrayInputStream;
    .end local v2    # "$i$a$-use-Apk3rdUtil$deserializeFileInfo$1":I
    invoke-static {v0, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    return-object v10

    .line 30
    .restart local v1    # "byteIn":Ljava/io/ByteArrayInputStream;
    .restart local v2    # "$i$a$-use-Apk3rdUtil$deserializeFileInfo$1":I
    :catchall_0
    move-exception v4

    .end local v1    # "byteIn":Ljava/io/ByteArrayInputStream;
    .end local v2    # "$i$a$-use-Apk3rdUtil$deserializeFileInfo$1":I
    .end local p1    # "data":[B
    :try_start_3
    throw v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v1    # "byteIn":Ljava/io/ByteArrayInputStream;
    .restart local v2    # "$i$a$-use-Apk3rdUtil$deserializeFileInfo$1":I
    .restart local p1    # "data":[B
    :catchall_1
    move-exception v5

    :try_start_4
    invoke-static {v3, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "data":[B
    throw v5
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 29
    .end local v1    # "byteIn":Ljava/io/ByteArrayInputStream;
    .end local v2    # "$i$a$-use-Apk3rdUtil$deserializeFileInfo$1":I
    .restart local p1    # "data":[B
    :catchall_2
    move-exception v1

    .end local p1    # "data":[B
    :try_start_5
    throw v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    .restart local p1    # "data":[B
    :catchall_3
    move-exception v2

    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v2
.end method

.method public final getPort()I
    .locals 1

    .line 10
    sget v0, Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;->port:I

    return v0
.end method

.method public final serializeFileInfo(Lcom/rokid/security/sdk/base/common/apk/FileInfo;)[B
    .locals 8
    .param p1, "info"    # Lcom/rokid/security/sdk/base/common/apk/FileInfo;

    const-string v0, "info"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 15
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    check-cast v0, Ljava/io/Closeable;

    :try_start_0
    move-object v1, v0

    check-cast v1, Ljava/io/ByteArrayOutputStream;

    .local v1, "byteOut":Ljava/io/ByteArrayOutputStream;
    const/4 v2, 0x0

    .line 16
    .local v2, "$i$a$-use-Apk3rdUtil$serializeFileInfo$1":I
    new-instance v3, Ljava/io/DataOutputStream;

    move-object v4, v1

    check-cast v4, Ljava/io/OutputStream;

    invoke-direct {v3, v4}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    check-cast v3, Ljava/io/Closeable;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    :try_start_1
    move-object v4, v3

    check-cast v4, Ljava/io/DataOutputStream;

    .local v4, "dataOut":Ljava/io/DataOutputStream;
    const/4 v5, 0x0

    .line 17
    .local v5, "$i$a$-use-Apk3rdUtil$serializeFileInfo$1$1":I
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/apk/FileInfo;->getFileName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/io/DataOutputStream;->writeUTF(Ljava/lang/String;)V

    .line 18
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/apk/FileInfo;->getFileSize()J

    move-result-wide v6

    invoke-virtual {v4, v6, v7}, Ljava/io/DataOutputStream;->writeLong(J)V

    .line 19
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/apk/FileInfo;->getFileType()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/io/DataOutputStream;->writeUTF(Ljava/lang/String;)V

    .line 20
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 16
    .end local v4    # "dataOut":Ljava/io/DataOutputStream;
    .end local v5    # "$i$a$-use-Apk3rdUtil$serializeFileInfo$1$1":I
    const/4 v4, 0x0

    :try_start_2
    invoke-static {v3, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 15
    .end local v1    # "byteOut":Ljava/io/ByteArrayOutputStream;
    .end local v2    # "$i$a$-use-Apk3rdUtil$serializeFileInfo$1":I
    invoke-static {v0, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    const-string v0, "ByteArrayOutputStream().\u2026)\n            }\n        }"

    invoke-static {v6, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v6

    .line 16
    .restart local v1    # "byteOut":Ljava/io/ByteArrayOutputStream;
    .restart local v2    # "$i$a$-use-Apk3rdUtil$serializeFileInfo$1":I
    :catchall_0
    move-exception v4

    .end local v1    # "byteOut":Ljava/io/ByteArrayOutputStream;
    .end local v2    # "$i$a$-use-Apk3rdUtil$serializeFileInfo$1":I
    .end local p1    # "info":Lcom/rokid/security/sdk/base/common/apk/FileInfo;
    :try_start_3
    throw v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v1    # "byteOut":Ljava/io/ByteArrayOutputStream;
    .restart local v2    # "$i$a$-use-Apk3rdUtil$serializeFileInfo$1":I
    .restart local p1    # "info":Lcom/rokid/security/sdk/base/common/apk/FileInfo;
    :catchall_1
    move-exception v5

    :try_start_4
    invoke-static {v3, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "info":Lcom/rokid/security/sdk/base/common/apk/FileInfo;
    throw v5
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 15
    .end local v1    # "byteOut":Ljava/io/ByteArrayOutputStream;
    .end local v2    # "$i$a$-use-Apk3rdUtil$serializeFileInfo$1":I
    .restart local p1    # "info":Lcom/rokid/security/sdk/base/common/apk/FileInfo;
    :catchall_2
    move-exception v1

    .end local p1    # "info":Lcom/rokid/security/sdk/base/common/apk/FileInfo;
    :try_start_5
    throw v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    .restart local p1    # "info":Lcom/rokid/security/sdk/base/common/apk/FileInfo;
    :catchall_3
    move-exception v2

    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v2
.end method
